# ParallelTest


## Successfully test on malbec

### submit script

```
#!/bin/bash
#SBATCH --job-name=jltest
#SBATCH --output=partest.out
#SBATCH --error=partest.err
#SBATCH --partition=cpushort
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=8
#SBATCH --nodelist=cnode[053,055]

julia6 script.jl
```

submit with

```
sbatch run.slurm
```

### Output

```
Started julia processes
hi I am worker number 1, I live on cnode053
done. added 16
workers: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]
make everybody say hello
hi I am worker number 1, I live on cnode053
	From worker 2:	hi I am worker number 2, I live on cnode053
	From worker 12:	hi I am worker number 12, I live on cnode053
	From worker 15:	hi I am worker number 15, I live on cnode053
	From worker 16:	hi I am worker number 16, I live on cnode053
	From worker 11:	hi I am worker number 11, I live on cnode053
	From worker 13:	hi I am worker number 13, I live on cnode053
	From worker 14:	hi I am worker number 14, I live on cnode053
	From worker 17:	hi I am worker number 17, I live on cnode053
	From worker 3:	hi I am worker number 3, I live on cnode055
	From worker 10:	hi I am worker number 10, I live on cnode055
	From worker 6:	hi I am worker number 6, I live on cnode055
	From worker 7:	hi I am worker number 7, I live on cnode055
	From worker 9:	hi I am worker number 9, I live on cnode055
	From worker 5:	hi I am worker number 5, I live on cnode055
	From worker 4:	hi I am worker number 4, I live on cnode055
	From worker 8:	hi I am worker number 8, I live on cnode055
make everybody do some math
	From worker 2:	Hi, I am worker number 2 doing some math
	From worker 16:	Hi, I am worker number 16 doing some math
	From worker 12:	Hi, I am worker number 12 doing some math
	From worker 15:	Hi, I am worker number 15 doing some math
	From worker 11:	Hi, I am worker number 11 doing some math
	From worker 13:	Hi, I am worker number 13 doing some math
	From worker 17:	Hi, I am worker number 17 doing some math
	From worker 14:	Hi, I am worker number 14 doing some math
	From worker 3:	Hi, I am worker number 3 doing some math
	From worker 4:	Hi, I am worker number 4 doing some math
	From worker 7:	Hi, I am worker number 7 doing some math
	From worker 6:	Hi, I am worker number 6 doing some math
	From worker 10:	Hi, I am worker number 10 doing some math
	From worker 8:	Hi, I am worker number 8 doing some math
	From worker 9:	Hi, I am worker number 9 doing some math
	From worker 5:	Hi, I am worker number 5 doing some math
	From worker 2:	allocating a 10000 by 10000 matrix 
	From worker 3:	allocating a 10000 by 10000 matrix 
	From worker 2:	my matrix has 0.74 GB
	From worker 16:	allocating a 10000 by 10000 matrix 
	From worker 12:	allocating a 10000 by 10000 matrix 
	From worker 15:	allocating a 10000 by 10000 matrix 
	From worker 11:	allocating a 10000 by 10000 matrix 
	From worker 14:	allocating a 10000 by 10000 matrix 
	From worker 17:	allocating a 10000 by 10000 matrix 
	From worker 13:	allocating a 10000 by 10000 matrix 
	From worker 16:	my matrix has 0.74 GB
	From worker 12:	my matrix has 0.74 GB
	From worker 15:	my matrix has 0.74 GB
	From worker 11:	my matrix has 0.74 GB
	From worker 14:	my matrix has 0.74 GB
	From worker 17:	my matrix has 0.74 GB
	From worker 13:	my matrix has 0.74 GB
	From worker 3:	my matrix has 0.74 GB
	From worker 6:	allocating a 10000 by 10000 matrix 
	From worker 4:	allocating a 10000 by 10000 matrix 
	From worker 7:	allocating a 10000 by 10000 matrix 
	From worker 8:	allocating a 10000 by 10000 matrix 
	From worker 9:	allocating a 10000 by 10000 matrix 
	From worker 5:	allocating a 10000 by 10000 matrix 
	From worker 10:	allocating a 10000 by 10000 matrix 
	From worker 6:	my matrix has 0.74 GB
	From worker 4:	my matrix has 0.74 GB
	From worker 7:	my matrix has 0.74 GB
	From worker 8:	my matrix has 0.74 GB
	From worker 9:	my matrix has 0.74 GB
	From worker 5:	my matrix has 0.74 GB
	From worker 10:	my matrix has 0.74 GB
serial call takes 19.83183173
parallel call takes 2.616415247
 quitting 
```
