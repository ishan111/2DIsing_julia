@everywhere function Equilibration(n_grid,T,J,L)

#creating random arrangement
grid=randn(n_grid,n_grid)
for i in 1:n_grid^2
    if grid[i]<0.5
        grid[i]=1
    else
        grid[i]=-1
    end
end

numIters = (2^9)*length(grid)

#pick a random spin
for iter in 1:numIters
    row = rand(1:n_grid)
    col = rand(1:n_grid)
    
    #nearest neighbors
    if col==1
        left=n_grid
    else
        left=col-1
    end
    if col==n_grid
        right=1
    else
        right=col+1
    end
    if row==1
        below=n_grid
    else
        below=row-1
    end
    if row==n_grid
        above=1
    else
        above=row+1
    end

    neighbors=grid[above,col]+grid[row,left]+grid[row,right]+grid[below,col]
    
    #Energy change after spin flip
    dE = 2*(J*grid[row,col]*neighbors)
    
    #Spin flip condition
    if dE <= 0
        grid[row,col] = -grid[row,col]
    else
        prob=exp(-dE/T)
        r=rand(1)
        if  r[1,1] <= prob
            grid[row,col] = -grid[row,col]
        end
    end
end
return grid
end
