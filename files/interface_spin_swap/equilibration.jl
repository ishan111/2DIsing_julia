using StatsBase
using JLD
function Equilibration(n_grid::Int64,T::Float64,J::Float64)



#creating random arrangement
if isdefined(Symbol("grid$n_grid")) == false
    print("yes")
    grid=rand(n_grid,n_grid)
    for i in 1:n_grid^2
        if i%2==0
            grid[i]=1
        else 
            grid[i]=-1
        end
    end
else
    grid= eval(Symbol("grid",n_grid))
end
# 
steps = 0
Ene=[]

grid[1,:] = 1
grid[n_grid,:] = -1
# row_ele=convert(Array,2:1:n_grid-1)
# col_ele=convert(Array,1:1:n_grid)

#pick a random spin
while true
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
        steps+= 1
        if steps%50000000==0
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
            break  
            if length(Ene)>2 && Ene[length(Ene)] == Ene[length(Ene)-1]
                break
            end
        end
    end
end

if isdefined(Symbol("grid$n_grid")) == false
    file=jldopen("grid.jld","r+")
    write(file,"grid$n_grid",grid)
    close(file)
end
# load("grid.jld")["grid"]
print("Finished")

return grid, steps
end
