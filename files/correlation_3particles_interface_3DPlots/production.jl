using StatsBase
using JLD
function Production(n_grid,grid,T,J,L,J_B_B,J_B_A,J_B_C,J_A_B,J_A_A,J_A_C,J_C_B,J_C_A,J_C_C)

#density_3=Array{Float64}(L,n_grid)

steps = 0
Ene=[]

r=1:1:n_grid-1
Si,Sj,SiSj = 0.0,0.0,0.0
sum_Si=zeros(n_grid,n_grid,11)
sum_Sj=zeros(n_grid,n_grid,11)
sum_SiSj=zeros(n_grid,n_grid,11)
x_1=zeros(n_grid,n_grid,11)
x_2=zeros(n_grid,n_grid,11)

grid[convert(Int,ceil(n_grid/2)),convert(Int,ceil(n_grid/2))]=0
    
#grid[1,:] = 1
#grid[n_grid,:] = -1
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
     
#################Energy change after spin flip######

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
            
        ########## Correlation Calculation ##############
            p=1
            for i=convert(Int,floor(n_grid/2))-5:1:convert(Int,floor(n_grid/2))+5
              for f in 1:n_grid  
                for r in 1:n_grid
                    Si = grid[i,f]
                    if r==n_grid    
                        Sj = grid[i,r]
                        sum_Si[f,r,p]+=Si
                        sum_Sj[f,r,p]+=Sj
                        sum_SiSj[f,r,p]+=Si*Sj
                        x_1[f,r,p]=f
                        x_2[f,r,p]=r  
                    else
                        Sj = grid[i,mod(r,n_grid)]
                        sum_Si[f,mod(r,n_grid),p]+=Si
                        sum_Sj[f,mod(r,n_grid),p]+=Sj
                        sum_SiSj[f,mod(r,n_grid),p]+=Si*Sj
                        x_1[f,mod(r,n_grid),p]=f
                        x_2[f,mod(r,n_grid),p]=mod(r,n_grid)
                    end
                end
              end
                p+=1
            end
        #######################################################

        if steps%L==0
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

gridpr=grid
avg_Si=sum_Sj/L
avg_Sj=sum_Sj/L
avg_SiSj=sum_SiSj/L
corr=avg_SiSj-(avg_Sj.*avg_Si)
return grid, corr, x_1, x_2
end
