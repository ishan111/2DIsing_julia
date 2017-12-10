#Production
@everywhere function Production(n_grid,T,J,L,grid)
Mmean=zeros(1,L)
Emean=zeros(1,L)
for iter in 1:L
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
    
    #Calculating Properties
    Mmean[1,iter]=mean(grid)
    
    #sumofneighbors=circshift(grid,[0 1])+circshift(grid,[0 -1])+circshift(grid,[1 0])+circshift(grid,[-1 0])
    #Em = - J*grid.*sumofneighbors
    #E=0.5*sum(Em)
    #Emean[1,iter]=E/length(grid)
end
gridpr=grid;
Ms=mean(Mmean);
#Es=mean(Emean)
xs=(mean(Mmean.^2)-mean(Mmean)^2)/T;
#Cs=(mean(Emean.^2)-mean(Emean)^2)/T^2
return gridpr, Ms, xs
end																				
