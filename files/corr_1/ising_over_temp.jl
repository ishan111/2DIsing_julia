function ising_over_temp(n_grid::Int64,J::Float64,L::Int64,Tmin::Float64,Tinc::Float64,Tmax::Float64)

len=convert(Int64,floor((Tmax-Tmin)/Tinc));
#allocating required memory
#gridqm=Array{Array{Int8}}(1,len+1);
Ts=[]
global steps
file=jldopen("equilibration.jld","w")
const i=1
# The temperature loop
print("equilibration started!","\n")

for T in Tmin:Tinc:Tmax
    grid, steps = Equilibration(n_grid, T, J, L)
    write(file,"grid$i",grid)
    #storing equilibrated arrangements with temperature
    #gridqm[1,i] = grid;
    append!(Ts,T)
    i+=1
end
close(file)
print("Number of steps = ",steps,"\n")
#print("equilibration finished!","\n")
len = length(Ts)
return  Ts, len
end
