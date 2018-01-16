#Production
function Production(n_grid::Int64,T::Float64,J::Float64,L::Int64,grid,r::Int64,M::Float64=0.0,M2::Float64=0.0)
#M=0.0
#M2=0.0
icorr,jcorr = convert(Int,ceil(n_grid/2)),convert(Int,ceil(n_grid/2))
Si,Sj,SiSj = 0.0,0.0,0.0


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
        if rand() <= exp(-dE/T)
            grid[row,col] = -grid[row,col]
        end
    end

    #Calculating Properties
    #M+=sum(grid)/length(grid)
    #M2+=(sum(grid)/length(grid))^2
    #sumofneighbors=circshift(grid,[0 1])+circshift(grid,[0 -1])+circshift(grid,[1 0])+circshift(grid,[-1 0])
    #Em = - J*grid.*sumofneighbors
    #E=0.5*sum(Em)
    #Emean[1,iter]=E/length(grid)
    Sn_corr =  grid[mod(icorr-r,n_grid),jcorr] + 
    grid[mod(icorr+r,n_grid),jcorr]+
    grid[icorr,mod(jcorr-r,n_grid)]+
    grid[icorr,mod(jcorr+r,n_grid)]

    Si+= grid[icorr,jcorr]
    Sj+= Sn_corr/4
    SiSj+= grid[icorr,jcorr]*Sn_corr/4
end

corr = (SiSj/L)-((Si/L)*(Sj/L))
gridpr=grid;
#Ms=M/L;
#Es=mean(Emean)
#xs=(M2/L-Ms^2)/T;
#Cs=(mean(Emean.^2)-mean(Emean)^2)/T^2
return gridpr, corr, SiSj/L
end
