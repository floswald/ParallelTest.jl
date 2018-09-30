
println("Started julia master process")
using ParallelTest

# do something in your system to start processes:
# salloc -N 3 --ntasks-per-node=5
wrkers = ParallelTest.machines()

@everywhere using ParallelTest

println("make everybody say hello")

@everywhere sayhello()

println("make everybody do some math")

pmap( i->domath(i), [100 for j in 1:length(workers())] )

println("make everybody pass a memory test")

#pmap( i->doBIGmath(10000,10000), 1:length(workers()) )
#pmap( i->doBIGmath(15000,10000), 1:length(workers()) )

#println("trying parallel for loop with $(nprocs()) processes")
#println("numworkers: $(length(workers()))")
#println("workers: $(workers())")
@time map( n -> sum(svd(rand(n,n))[1]) , [800 for i in 1:32]);
@time pmap( n -> sum(svd(rand(n,n))[1]) , [800 for i in 1:32]);

println(" quitting ")

quit()
