module ParallelTest

	function hosts()
		hosts = []
		pids = []
		for i in workers()
			host, pid = fetch(@spawnat i (gethostname(), getpid()))
			push!(hosts, host)
			push!(pids, pid)
		end
		println("your hosts = $hosts")
		println("your pids = $pids")
	end

	function addprocs_ec2(machines::Array{AbstractString}) 
		pids = addprocs(machinces,sshflags=`-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o LogLevel=ERROR`,tunnel=true)
		return pids
	end

	# to be run on all nodes


	function sayhello()
	   println("hi I am worker number $(myid()), I live on $(gethostname())")
	end

	function domath(i::Integer)
		if i < 2
			error("need i>2")
		end
		println("Hi, I am worker number $(myid()) doing some math")
		x = rand(i,i)
		mean(x)
	end

	serial() = map( n -> sum(svd(rand(n,n))[1]) , [800 for i in 1:64])
	parallel() = pmap( n -> sum(svd(rand(n,n))[1]) , [800 for i in 1:64])



	function doBIGmath(n=30000,m=10000)
		println("allocating a $n by $m matrix ")
		x = rand(n,m);
		r = round(sizeof(x) /  1.074e+9 , 2)
		println("my matrix has $r GB")
		mean(x)
	end

	function machines(; verbose = false)
		if verbose sayhello() end
		# which scheduler system
		if haskey(ENV,"PBS_NODEFILE")
			sys = :pbs 
		    # read PBS_NODEFILE
		    filestream = open(ENV["PBS_NODEFILE"])
		    seekstart(filestream)
		    node_file = readlines(filestream)

		    # strip eol
		    node_file = map(x->strip(x,['\n']),node_file)

		    # get number of workers on each node
		    procs = Dict{ASCIIString,Int}()
		    for n in node_file
		        procs[n] = get(procs,n,0) + 1
		    end

		    println("name of compute nodes and number of workers:")
		    println(procs)

		    # add processes on master itself
		    master = ENV["HOSTNAME"]

		    wrker = 0
		    while wrker < ppn
		        addprocs(1)
		        wrker += 1
		    end
		    println("added $wrker processes on master itself")

		    # add procs on other machines
		    for (k,v) in procs
		        wrker = 0
		        if k!=master
		            while wrker < ppn
		                addprocs([k], dir= JULIA_HOME)
		                # println("addprocs($k)")
		                wrker += 1
		            end
		            println("added $wrker processes on machine $k")
		        end
		    end
		elseif haskey(ENV,"SLURM_JOB_NODELIST")
			# magi[90-91]   salloc -N 2
			# magi[50,90-91]  salloc -N 3 -n 15

			# salloc -N 3 --ntasks-per-node=5
			# magi3 /home/dist/florian.oswald $ scontrol show hostnames $SLURM_JOB_NODELIST
			# magi50
			# magi90
			# magi91
			machine_file = readlines(`scontrol show hostnames`)
			println("ParallelTest :: machine file $machine_file")
			pids = readlines(`pgrep julia`)

			println("ParallelTest :: pids = $pids")

			# designate first process id as master who will call addprocs on the others.
			# so, if you are not master, exit
			if getpid() != parse(Int,pids[1])
				println("I am not the master, so goodbye")
				exit()
			end

			sleep(5)
			if haskey(ENV,"SLURM_NTASKS")
				tasks_per_cpu = floor(Int,parse(Int,ENV["SLURM_NTASKS"]) / length(machine_file))
			else
				tasks_per_cpu = length(machine_file)
			end
			println("ParallelTest :: tasks per cpu: $tasks_per_cpu")

			machines = [(i,tasks_per_cpu) for i in machine_file]
			println("ParallelTest :: array of machines: $machines")
			addprocs(machines)
		        println("ParallelTest :: done. added $(length(workers()))")
		        println("ParallelTest :: workers: $(workers())")
			return(workers())
		elseif haskey(ENV,"PE_HOSTFILE")
			sys = :sge
		else
			sys = :local
		end
	end



end # module
