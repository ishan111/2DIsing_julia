addprocs(4)

include("equilibration.jl")
include("production.jl")
include("ising.jl")
include("ising_over_temp.jl")
include("parallel_ising.jl")

gridqm, Ts, len = ising_over_temp(50,1,1000000,1,0.1,3)
Mpavg,xavg, Tsavg = parallel_Ising(50,1000000,1,2,1,0.1,3,len,gridqm,Ts)
#using Gadfly
#plt1=plot(x=Tsavg,y=Mpavg,Guide.xlabel("Temp"),Guide.ylabel("Magnetisation/site"))
#plt2=plot(x=Tsavg,y=xavg,Guide.xlabel("Temp"),Guide.ylabel("Susceptibility/site"))
#display(plt1)
#display(plt2)
open("Data/magnetisation.txt") do f
    
