using JLD

include("equilibration.jl")
include("production.jl")
include("Ising.jl")
include("ising_over_temp.jl")


Ts, len = ising_over_temp(5,1.0,1000000,1.0,0.1,3.0)
Mp_avg,x_avg,Ts = Ising(5,1000000,1.0,2,1.0,0.1,3.0,len,Ts)
#using Gadfly
#plt1=plot(x=Ts,y=Mp_avg,Guide.xlabel("Temp"),Guide.ylabel("Magnetisation/site"))
#plt2=plot(x=Ts,y=x_avg,Guide.xlabel("Temp"),Guide.ylabel("Susceptibility/site"))
#display(plt1)
#display(plt2)
