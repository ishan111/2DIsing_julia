function Ising(n_grid::Int64,L::Int64,J::Float64,P::Int64,Tmin::Float64,Tinc::Float64,Tmax::Float64,len,Ts)

Mp=zeros(P,len);
x=zeros(P,len);

for Pr in 1:P
    print("production run = ",Pr,"\n")
    for h in 1:len
        grid = load("equilibration.jld")["grid$h"]
        gridpr,Ms,xs = Production(n_grid,Ts[1,h],J,L,grid,0.0,0.0)
        Mp[Pr,h] = Ms;
        x[Pr,h] = xs;
    end
end

Mp_avg=mean(Mp,1);
x_avg=mean(x,1);

#using Plots
#plt1 = Plots.scatter(Ts,Mp_avg,color="red",legend=false,xaxis="Temp",yaxis="<M>/spin");
#plt2 = Plots.scatter(Ts,x_avg,color="green", reuse= false,legend=false,xaxis="Temp",yaxis="<x>/spin");
#display(plt1)
#display(plt2)

    print("FINISHED!")
    return Mp_avg, x_avg, Ts
end
