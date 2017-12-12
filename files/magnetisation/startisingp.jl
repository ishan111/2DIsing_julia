using JLD

@everywhere include("equilibration.jl")
@everywhere include("production.jl")
@everywhere include("Ising.jl")
@everywhere include("ising_over_temp.jl")
@everywhere include("parallel_ising.jl")

Ts, len = ising_over_temp(50,1.0,1000000,1.0,0.1,3.0)
Mpavg,xavg, Tsavg = parallel_Ising(50,1000000,1.0,2,1.0,0.1,3.0,len,Ts,4)
#using Gadfly
#plt1=plot(x=Tsavg,y=Mpavg,Guide.xlabel("Temp"),Guide.ylabel("Magnetisation/site"))
#plt2=plot(x=Tsavg,y=xavg,Guide.xlabel("Temp"),Guide.ylabel("Susceptibility/site"))
#display(plt1)
#display(plt2)
