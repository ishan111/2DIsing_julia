function Ising(n_grid::Int64,L::Int64,J::Float64,P::Int64,Tmin::Float64,Tinc::Float64,Tmax::Float64,len,Ts)

#Mp=zeros(P,len)
#x=zeros(P,len)
SiSj = zeros(P,len,floor(n_grid/2))
corr=zeros(P,len,floor(n_grid/2))

for Pr in 1:P
    print("P = ",Pr,"\n")
    for h in 1:len
    	for r in 1:convert(Int,floor(n_grid/2))-1
        	grid = load("equilibration.jld")["grid$h"]
        	gridpr, correlation, SiS= Production(n_grid,Ts[1,h],J,L,grid,r,0.0,0.0)
        	#Mp[Pr,h] = Ms
        	#x[Pr,h] = xs
            SiSj[Pr,h,r] = SiS
        	corr[Pr,h,r] = correlation
    	end
    end
end

#Mp_avg = mean(Mp,1)
#x_avg = mean(x,1)
corr_avg = mean(corr,1)
err = std(SiSj,1)
SiSj_avg = mean(SiSj,1)

#using Plots
#plt1 = Plots.scatter(Ts,Mp_avg,color="red",legend=false,xaxis="Temp",yaxis="<M>/spin");
#plt2 = Plots.scatter(Ts,x_avg,color="green", reuse= false,legend=false,xaxis="Temp",yaxis="<x>/spin");
#display(plt1)
#display(plt2)

    print("FINISHED!")
return corr_avg, SiSj_avg, err, Ts
end
