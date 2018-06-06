#Production
function Production(n_grid::Int64,T::Float64,J::Float64,L::Int64,grid,r)
#M=0.0
#M2=0.0
# icorr,jcorr = convert(Int,ceil(n_grid/2)),convert(Int,ceil(n_grid/2))
Si,Sj,SiSj = 0.0,0.0,0.0
sum_Si=zeros(11,1)
sum_Sj=zeros(11,1)
sum_SiSj=zeros(11,1)

for iter in 1:L
    row_ele=convert(Array,2:1:n_grid-1)
    col_ele=convert(Array,1:1:n_grid)
    E=0
    row_1 = sample(row_ele)
    col_1 = sample(col_ele)
    deleteat!(row_ele, findin(row_ele, [row_1]))
    deleteat!(col_ele, findin(col_ele, [col_1]))
    row_2 = sample(row_ele)
    col_2 = sample(col_ele)

    if grid[row_1,col_1] != grid[row_2,col_2]
    # for i in 1:n_grid
    #         for j in 1:n_grid
    #             above = mod(i - 1 - 1, size(grid,1)) + 1;
    #             below = mod(i + 1 - 1, size(grid,1)) + 1;
    #             left  = mod(j - 1 - 1, size(grid,2)) + 1;
    #             right = mod(j + 1 - 1, size(grid,2)) + 1;
    #             energy = -(grid[above,j]+grid[i,left]+grid[i,right]+grid[below,j])*grid[i,j]       
    #             E+=energy/4
    #         end
    # end
    #nearest neighbors
        if col_1==1
            left=n_grid
        else
            left=col_1-1
        end
        if col_1==n_grid
            right=1
        else
            right=col_1+1
        end
        if row_1==1
            above=n_grid
        else
            above=row_1-1
        end
        if row_1==n_grid
            below=1
        else
            below=row_1+1
        end

        neighbors_1=grid[above,col_1]+grid[row_1,left]+grid[row_1,right]+grid[below,col_1]

        if col_2==1
            left=n_grid
        else
            left=col_2-1
        end
        if col_2==n_grid
            right=1
        else
            right=col_2+1
        end
        if row_2==1
            above=n_grid
        else
            above=row_2-1
        end
        if row_2==n_grid
            below=1
        else
            below=row_2+1
        end

        neighbors_2=grid[above,col_2]+grid[row_2,left]+grid[row_2,right]+grid[below,col_2]
        #Energy change after spin flip
        dE = 2*(J*grid[row_1,col_1]*neighbors_1) + 2*(J*grid[row_2,col_2]*neighbors_2)

        #Spin flip condition
        if dE <= 0
            grid[row_1,col_1] = -grid[row_1,col_1]
            grid[row_2,col_2] = -grid[row_2,col_2]
        else
            if  rand() <= exp(-dE/T)
                grid[row_1,col_1] = -grid[row_1,col_1]
                grid[row_2,col_2] = -grid[row_2,col_2]
            end
        end
    end
    j=convert(Int,ceil(n_grid/2))
    p=1
    for i=convert(Int,floor(n_grid/2))-5:1:convert(Int,floor(n_grid/2))+5
        Si = grid[i,j]
        Sj = (grid[i,j-r]+grid[i,j+r])/2
        sum_Si[p,1]+=Si
        sum_Sj[p,1]+=Sj
        sum_SiSj[p,1]+=Si*Sj
        p+=1
    end
end

gridpr=grid
avg_Si=sum_Sj/L
avg_Sj=sum_Sj/L
avg_SiSj=sum_SiSj/L
corr=avg_SiSj-(avg_Sj.*avg_Si)
# corr=avg_SiSj
return gridpr, corr

end
