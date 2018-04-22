using StatsBase
using JLD
function Equilibration(n_grid::Int64,T::Float64,J::Float64,E_steps,J_B_B,J_B_A,J_B_C,J_A_B,J_A_A,J_A_C,J_C_B,J_C_A,J_C_C)



#creating random arrangement
#if isdefined(Symbol("grid$n_grid")) == false 
    grid=rand(n_grid,n_grid)
    for i in 1:n_grid^2
        if i%2==0
            grid[i]=1
        else 
            grid[i]=-1
        end
    end
    #for i in 1:z
     #  if i%2==0
      #      while true
       #     r_3=rand(2:n_grid-1)
        #    c_3=rand(1:n_grid)
         #   if grid[r_3,c_3]==1
          #      grid[r_3,c_3]=0
           #     break
            #end
            #end
        #else
         #   while true
          #  r_3=rand(2:n_grid-1)
           # c_3=rand(1:n_grid)
    #        if grid[r_3,c_3]==-1
     #           grid[r_3,c_3]=0
      #          break
       #     end
        #    end
        #end 
    #end
    grid[convert(Int,ceil(n_grid/2)),convert(Int,ceil(n_grid/2))]=0
#else
    #grid= eval(Symbol("grid",n_grid))
#end
# 
steps = 0
Ene=[]

grid[1,:] = 1
grid[n_grid,:] = -1
# row_ele=convert(Array,2:1:n_grid-1)
# col_ele=convert(Array,1:1:n_grid)

#pick a random spin
while true
    #global E_1_before,E_1_after,E_2_before,E_2_after
    row_ele=convert(Array,2:1:n_grid-1)
    col_ele=convert(Array,1:1:n_grid)
    E=0
    while true
        global row_1 = sample(row_ele)
        global col_1 = sample(col_ele)
        if grid[row_1,col_1]!=0
                break
        end
    end
   
    deleteat!(row_ele, findin(row_ele, [row_1]))
    deleteat!(col_ele, findin(col_ele, [col_1]))
    while true
        global row_2 = sample(row_ele)
        global col_2 = sample(col_ele)
        if grid[row_2,col_2]!=0
                break
        end
    end

 if grid[row_1,col_1] != grid[row_2,col_2]
   
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

        #neighbors_1=grid[above,col_1]+grid[row_1,left]+grid[row_1,right]+grid[below,col_1]
############################ Before swap spin 1 energy##########################
        if grid[row_1,col_1]==0
                if grid[above,col_1] == 0
                    E_1_before_above=-J_B_B
                elseif grid[above,col_1] == 1
                    E_1_before_above=-J_B_A
                else
                    E_1_before_above=-J_B_C
                end
                if grid[row_1,left] == 0
                    E_1_before_left=-J_B_B
                elseif grid[row_1,left] == 1
                    E_1_before_left=-J_B_A
                else
                    E_1_before_left=-J_B_C
                end
                if grid[row_1,right] == 0
                    E_1_before_right=-J_B_B
                elseif grid[row_1,right] == 1
                    E_1_before_right=-J_B_A
                else
                    E_1_before_right=-J_B_C
                end
                if grid[below,col_1] == 0
                    E_1_before_below=-J_B_B
                elseif grid[below,col_1] == 1
                    E_1_before_below=-J_B_A
                else
                    E_1_before_below=-J_B_C
                end
                E_1_before=E_1_before_above+E_1_before_left+E_1_before_right+E_1_before_below
        elseif grid[row_1,col_1]==1
                
                if grid[above,col_1] == 0
                    E_1_before_above=-J_A_B
                elseif grid[above,col_1] == 1
                    E_1_before_above=-J_A_A
                else
                    E_1_before_above=-J_A_C
                end
                if grid[row_1,left] == 0
                    E_1_before_left=-J_A_B
                elseif grid[row_1,left] == 1
                    E_1_before_left=-J_A_A
                else
                    E_1_before_left=-J_A_C
                end
                if grid[row_1,right] == 0
                    E_1_before_right=-J_A_B
                elseif grid[row_1,right] == 1
                    E_1_before_right=-J_A_A
                else
                    E_1_before_right=-J_A_C
                end
                if grid[below,col_1] == 0
                    E_1_before_below=-J_A_B
                elseif grid[below,col_1] == 1
                    E_1_before_below=-J_A_A
                else
                    E_1_before_below=-J_A_C
                end
                E_1_before=E_1_before_above+E_1_before_left+E_1_before_right+E_1_before_below
                
          else 
                
                if grid[above,col_1] == 0
                    E_1_before_above=-J_C_B
                elseif grid[above,col_1] == 1
                    E_1_before_above=-J_C_A
                else
                    E_1_before_above=-J_C_C
                end
                if grid[row_1,left] == 0
                    E_1_before_left=-J_C_B
                elseif grid[row_1,left] == 1
                    E_1_before_left=-J_C_A
                else
                    E_1_before_left=-J_C_C
                end
                if grid[row_1,right] == 0
                    E_1_before_right=-J_C_B
                elseif grid[row_1,right] == 1
                    E_1_before_right=-J_C_A
                else
                    E_1_before_right=-J_C_C
                end
                if grid[below,col_1] == 0
                    E_1_before_below=-J_C_B
                elseif grid[below,col_1] == 1
                    E_1_before_below=-J_C_A
                else
                    E_1_before_below=-J_C_C
                end
                E_1_before=E_1_before_above+E_1_before_left+E_1_before_right+E_1_before_below
        end
############################ After swap spin 1 energy##########################
        if grid[row_2,col_2]==0
                if grid[above,col_1] == 0
                    E_1_after_above=-J_B_B
                elseif grid[above,col_1] == 1
                    E_1_after_above=-J_B_A
                else
                    E_1_after_above=-J_B_C
                end
                if grid[row_1,left] == 0
                    E_1_after_left=-J_B_B
                elseif grid[row_1,left] == 1
                    E_1_after_left=-J_B_A
                else
                    E_1_after_left=-J_B_C
                end
                if grid[row_1,right] == 0
                    E_1_after_right=-J_B_B
                elseif grid[row_1,right] == 1
                    E_1_after_right=-J_B_A
                else
                    E_1_after_right=-J_B_C
                end
                if grid[below,col_1] == 0
                    E_1_after_below=-J_B_B
                elseif grid[below,col_1] == 1
                    E_1_after_below=-J_B_A
                else
                    E_1_after_below=-J_B_C
                end
                E_1_after=E_1_after_above+E_1_after_left+E_1_after_right+E_1_after_below
        
          elseif grid[row_2,col_2]==1
                
                if grid[above,col_1] == 0
                    E_1_after_above=-J_A_B
                elseif grid[above,col_1] == 1
                    E_1_after_above=-J_A_A
                else
                    E_1_after_above=-J_A_C
                end
                if grid[row_1,left] == 0
                    E_1_after_left=-J_A_B
                elseif grid[row_1,left] == 1
                    E_1_after_left=-J_A_A
                else
                    E_1_after_left=-J_A_C
                end
                if grid[row_1,right] == 0
                    E_1_after_right=-J_A_B
                elseif grid[row_1,right] == 1
                    E_1_after_right=-J_A_A
                else
                    E_1_after_right=-J_A_C
                end
                if grid[below,col_1] == 0
                    E_1_after_below=-J_A_B
                elseif grid[below,col_1] == 1
                    E_1_after_below=-J_A_A
                else
                    E_1_after_below=-J_A_C
                end
                E_1_after=E_1_after_above+E_1_after_left+E_1_after_right+E_1_after_below
            
            else 
                
                if grid[above,col_1] == 0
                    E_1_after_above=-J_C_B
                elseif grid[above,col_1] == 1
                    E_1_after_above=-J_C_A
                else
                    E_1_after_above=-J_C_C
                end
                if grid[row_1,left] == 0
                    E_1_after_left=-J_C_B
                elseif grid[row_1,left] == 1
                    E_1_after_left=-J_C_A
                else
                    E_1_after_left=-J_C_C
                end
                if grid[row_1,right] == 0
                    E_1_after_right=-J_C_B
                elseif grid[row_1,right] == 1
                    E_1_after_right=-J_C_A
                else
                    E_1_after_right=-J_C_C
                end
                if grid[below,col_1] == 0
                    E_1_after_below=-J_C_B
                elseif grid[below,col_1] == 1
                    E_1_after_below=-J_C_A
                else
                    E_1_after_below=-J_C_C
                end
                E_1_after=E_1_after_above+E_1_after_left+E_1_after_right+E_1_after_below    
        end
###########################################################
##########################################################
     #nearest neighbors for spin 2          
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

        #neighbors_2=grid[above,col_2]+grid[row_2,left]+grid[row_2,right]+grid[below,col_2]
############################ before swap spin 2 energy##########################
        if grid[row_2,col_2]==0
                if grid[above,col_2] == 0
                    E_2_before_above=-J_B_B
                elseif grid[above,col_2] == 1
                    E_2_before_above=-J_B_A
                else
                    E_2_before_above=-J_B_C
                end
                if grid[row_2,left] == 0
                    E_2_before_left=-J_B_B
                elseif grid[row_2,left] == 1
                    E_2_before_left=-J_B_A
                else
                    E_2_before_left=-J_B_C
                end
                if grid[row_2,right] == 0
                    E_2_before_right=-J_B_B
                elseif grid[row_2,right] == 1
                    E_2_before_right=-J_B_A
                else
                    E_2_before_right=-J_B_C
                end
                if grid[below,col_2] == 0
                    E_2_before_below=-J_B_B
                elseif grid[below,col_2] == 1
                    E_2_before_below=-J_B_A
                else
                    E_2_before_below=-J_B_C
                end
                E_2_before=E_2_before_above+E_2_before_left+E_2_before_right+E_2_before_below
           elseif grid[row_2,col_2]==1
                
                if grid[above,col_2] == 0
                    E_2_before_above=-J_A_B
                elseif grid[above,col_2] == 1
                    E_2_before_above=-J_A_A
                else
                    E_2_before_above=-J_A_C
                end
                if grid[row_2,left] == 0
                    E_2_before_left=-J_A_B
                elseif grid[row_2,left] == 1
                    E_2_before_left=-J_A_A
                else
                    E_2_before_left=-J_A_C
                end
                if grid[row_2,right] == 0
                    E_2_before_right=-J_A_B
                elseif grid[row_2,right] == 1
                    E_2_before_right=-J_A_A
                else
                    E_2_before_right=-J_A_C
                end
                if grid[below,col_2] == 0
                    E_2_before_below=-J_A_B
                elseif grid[below,col_2] == 1
                    E_2_before_below=-J_A_A
                else
                    E_2_before_below=-J_A_C
                end
                E_2_before=E_2_before_above+E_2_before_left+E_2_before_right+E_2_before_below
            
           else 
                
                if grid[above,col_2] == 0
                    E_2_before_above=-J_C_B
                elseif grid[above,col_2] == 1
                    E_2_before_above=-J_C_A
                else
                    E_2_before_above=-J_C_C
                end
                if grid[row_2,left] == 0
                    E_2_before_left=-J_C_B
                elseif grid[row_2,left] == 1
                    E_2_before_left=-J_C_A
                else
                    E_2_before_left=-J_C_C
                end
                if grid[row_2,right] == 0
                    E_2_before_right=-J_C_B
                elseif grid[row_2,right] == 1
                    E_2_before_right=-J_C_A
                else
                    E_2_before_right=-J_C_C
                end
                if grid[below,col_2] == 0
                    E_2_before_below=-J_C_B
                elseif grid[below,col_2] == 1
                    E_2_before_below=-J_C_A
                else
                    E_2_before_below=-J_C_C
                end
                E_2_before=E_2_before_above+E_2_before_left+E_2_before_right+E_2_before_below
            end
                
############################ After swap spin 2 energy##########################
        if grid[row_1,col_1]==0
                if grid[above,col_2] == 0
                    E_2_after_above=-J_B_B
                elseif grid[above,col_2] == 1
                    E_2_after_above=-J_B_A
                else
                    E_2_after_above=-J_B_C
                end
                if grid[row_2,left] == 0
                    E_2_after_left=-J_B_B
                elseif grid[row_2,left] == 1
                    E_2_after_left=-J_B_A
                else
                    E_2_after_left=-J_B_C
                end
                if grid[row_2,right] == 0
                    E_2_after_right=-J_B_B
                elseif grid[row_2,right] == 1
                    E_2_after_right=-J_B_A
                else
                    E_2_after_right=-J_B_C
                end
                if grid[below,col_2] == 0
                    E_2_after_below=-J_B_B
                elseif grid[below,col_2] == 1
                    E_2_after_below=-J_B_A
                else
                    E_2_after_below=-J_B_C
                end
                E_2_after=E_2_after_above+E_2_after_left+E_2_after_right+E_2_after_below
        
          elseif grid[row_1,col_1]==1
                
                if grid[above,col_2] == 0
                    E_2_after_above=-J_A_B
                elseif grid[above,col_2] == 1
                    E_2_after_above=-J_A_A
                else
                    E_2_after_above=-J_A_C
                end
                if grid[row_2,left] == 0
                    E_2_after_left=-J_A_B
                elseif grid[row_2,left] == 1
                    E_2_after_left=-J_A_A
                else
                    E_2_after_left=-J_A_C
                end
                if grid[row_2,right] == 0
                    E_2_after_right=-J_A_B
                elseif grid[row_2,right] == 1
                    E_2_after_right=-J_A_A
                else
                    E_2_after_right=-J_A_C
                end
                if grid[below,col_2] == 0
                    E_2_after_below=-J_A_B
                elseif grid[below,col_2] == 1
                    E_2_after_below=-J_A_A
                else
                    E_2_after_below=-J_A_C
                end
                E_2_after=E_2_after_above+E_2_after_left+E_2_after_right+E_2_after_below
            
            else 
                
                if grid[above,col_2] == 0
                    E_2_after_above=-J_C_B
                elseif grid[above,col_2] == 1
                    E_2_after_above=-J_C_A
                else
                    E_2_after_above=-J_C_C
                end
                if grid[row_2,left] == 0
                    E_2_after_left=-J_C_B
                elseif grid[row_2,left] == 1
                    E_2_after_left=-J_C_A
                else
                    E_2_after_left=-J_C_C
                end
                if grid[row_2,right] == 0
                    E_2_after_right=-J_C_B
                elseif grid[row_2,right] == 1
                    E_2_after_right=-J_C_A
                else
                    E_2_after_right=-J_C_C
                end
                if grid[below,col_2] == 0
                    E_2_after_below=-J_C_B
                elseif grid[below,col_2] == 1
                    E_2_after_below=-J_C_A
                else
                    E_2_after_below=-J_C_C
                end
                E_2_after=E_2_after_above+E_2_after_left+E_2_after_right+E_2_after_below    
        end
####################################################        
#################Energy change after spin flip######
####################################################
        dE = (E_2_after+E_1_after)-(E_2_before+E_1_before)

        #Spin flip condition
        if dE <= 0
            grid[row_1,col_1],grid[row_2,col_2]= grid[row_2,col_2],grid[row_1,col_1]
        else
            if  rand() <= exp(-dE/T)
                grid[row_1,col_1],grid[row_2,col_2]= grid[row_2,col_2],grid[row_1,col_1]
            end
        end
        steps+= 1
        if steps%E_steps==0
            break
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
                breakS
            end
        end
    end
end

return grid, steps
end
