@everywhere function Ising(n_grid,L,J,P,Tmin,Tinc,Tmax,len,gridqm,Ts)


Mp=zeros(P,len);
x=zeros(P,len);

for Pr in 1:P
    print("production run = ",Pr,"\n")
    for h in 1:len
        gridpr,Ms,xs = Production(n_grid,Ts[1,h],J,L,gridqm[1,h])
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
