function ising_over_temp(n_grid::Int64,J::Float64,L::Int64,Tmin::Float64,Tinc::Float64,Tmax::Float64)

len=convert(Int64,floor((Tmax-Tmin)/Tinc));
#allocating required memory
#gridqm=Array{Array{Int8}}(1,len+1);
Ts=Array{Float64}(1,len+1);

file=jldopen("equilibration.jld","w")
const i=1
# The temperature loop
print("equilibration started!","\n")
print("Number of steps = ",(2^8)*n_grid^2,"\n")
for T in Tmin:Tinc:Tmax
    grid = Equilibration(n_grid, T, J, L)
    write(file,"grid$i",grid)
    #storing equilibrated arrangements with temperature
    #gridqm[1,i] = grid;
    Ts[1,i] = T
    i+=1
end
close(file)
print("equilibration finished!","\n")
len = length(Ts)
return  Ts, len
end
