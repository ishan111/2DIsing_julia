@everywhere function ising_over_temp(n_grid,J,L,Tmin,Tinc,Tmax)
len = floor((Tmax-Tmin)/Tinc);
len=convert(Int64,len);
#allocating required memory
gridqm=Array{Array{Int8}}(1,len+1);
Ts=Array{Float64}(1,len+1);
i=1;

# The temperature loop
print("equilibration started!","\n");
print("Number of steps = ",(2^8)*n_grid^2,"\n");
for T in Tmin:Tinc:Tmax
    grid = Equilibration(n_grid, T, J, L);

    #storing equilibrated arrangements with temperature 
    gridqm[1,i] = grid;
    Ts[1,i] = T;
    i=i+1;
end
print("equilibration finished!","\n");
len = length(Ts);
return gridqm, Ts, len
end
