function Equilibration(n_grid::Int64,T::Float64,J::Float64,L::Int64)

#creating random arrangement
grid=randn(n_grid,n_grid)
for i in 1:n_grid^2
    if grid[i]<0.5
        grid[i]=1
    else
        grid[i]=-1
    end
end

steps = 0
Ene=[]

#pick a random spin
while true
    E=0
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
        above=n_grid
    else
        above=row-1
    end
    if row==n_grid
        below=1
    else
        below=row+1
    end

    neighbors=grid[above,col]+grid[row,left]+grid[row,right]+grid[below,col]

    #Energy change after spin flip
    dE = 2*(J*grid[row,col]*neighbors)

    #Spin flip condition
    if dE <= 0
        grid[row,col] = -grid[row,col]
    else
        if  rand() <= exp(-dE/T)
            grid[row,col] = -grid[row,col]
        end
    end
    steps+= 1
    if steps%100000==0
        for i in 1:n_grid
            for j in 1:n_grid
                above = mod(i - 1 - 1, size(grid,1)) + 1;
                below = mod(i + 1 - 1, size(grid,1)) + 1;
                left  = mod(j - 1 - 1, size(grid,2)) + 1;
                right = mod(j + 1 - 1, size(grid,2)) + 1;
                energy = -(grid[above,j]+grid[i,left]+grid[i,right]+grid[below,j])*grid[i,j]       
                E+=energy/4
            end
        end
        append!(Ene,E)
        if length(Ene)>2 && Ene[length(Ene)] == Ene[length(Ene)-1]
            break
        end
    end
end
return grid, steps
end
