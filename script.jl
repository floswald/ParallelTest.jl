
info("Started julia master process")
using ParallelTest

# do something in your system to start processes:
# salloc -N 3 --ntasks-per-node=5
wrkers = ParallelTest.machines()

@everywhere using ParallelTest

info("make everybody say hello")

@everywhere ParallelTest.sayhello()

info("make everybody do some math")

pmap( i->ParallelTest.domath(i), [100 for j in 1:length(workers())] )

# println("make everybody pass a memory test")

#pmap( i->doBIGmath(10000,10000), 1:length(workers()) )
#pmap( i->doBIGmath(15000,10000), 1:length(workers()) )

#println("trying parallel for loop with $(nprocs()) processes")
#println("numworkers: $(length(workers()))")
#println("workers: $(workers())")

# info("svd call on master")
# @time ParallelTest.serial();
info("parallel svd call")
@time ParallelTest.parallel();

info(" quitting ")

quit()
