
include("equilibration.jl")
include("production.jl")
include("ising.jl")
include("ising_over_temp.jl")

gridqm, Ts, len = ising_over_temp(50,1,1000000,1,0.1,3)
Mp_avg,x_avg,Ts = Ising(50,1000000,1,2,1,0.1,3,len,gridqm,Ts)
using Gadfly
plt1=plot(x=Ts,y=Mp_avg,Guide.xlabel("Temp"),Guide.ylabel("Magnetisation/site"))
plt2=plot(x=Ts,y=x_avg,Guide.xlabel("Temp"),Guide.ylabel("Susceptibility/site"))
display(plt1)
display(plt2)
