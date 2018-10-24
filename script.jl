
println("Started julia master process")
using ParallelTest

# do something in your system to start processes:
# salloc -N 3 --ntasks-per-node=5
wrkers = ParallelTest.machines()

@everywhere using ParallelTest

println("make everybody say hello")

@everywhere ParallelTest.sayhello()

println("make everybody do some math")

pmap( i->ParallelTest.domath(i), [100 for j in 1:length(workers())] )

# println("make everybody pass a memory test")

#pmap( i->doBIGmath(10000,10000), 1:length(workers()) )
#pmap( i->doBIGmath(15000,10000), 1:length(workers()) )

#println("trying parallel for loop with $(nprocs()) processes")
#println("numworkers: $(length(workers()))")
#println("workers: $(workers())")

# println("svd call on master")
# @time ParallelTest.serial();
println("parallel svd call warm up JIT")
@time ParallelTest.parallel();
println("parallel svd call")
@time ParallelTest.parallel();

println(" quitting ")

quit()
