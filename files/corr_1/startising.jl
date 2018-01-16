using JLD

include("equilibration.jl")
include("production.jl")
include("Ising.jl")
include("ising_over_temp.jl")

n_grid = 101
J = 1.0
L = 2000000
Tmin = 2.269
Tinc = 1.0
Tmax = 2.269
P = 2
r = 1:1:convert(Int,floor(n_grid/2))
Ts, len = ising_over_temp(n_grid,J,L,Tmin,Tinc,Tmax)
corr_avg, SiSj_avg, err, Ts = Ising(n_grid,L,J,P,Tmin,Tinc,Tmax,len,Ts)

#File = (r[:,:]corr_avg[1,1,:])
fid=open("Data.dat","a+")
@printf(fid,"%s %s\r\n","Date/Time : ",Dates.format(now(), "yyyy-mm-dd HH:MM:SS"));
@printf(fid,"%s %f\r\n","J=",J);
@printf(fid,"%s %f\r\n","Lattice Size=",n_grid);
@printf(fid,"%s %f\r\n","Minimum temperature = ",Tmin);
@printf(fid,"%s %f\r\n","Maximum temperature = ",Tmax);
@printf(fid,"%s %f\r\n","Increment in temperature = ",Tinc);
@printf(fid,"%s %f\r\n","No.of Production run = ",P);
@printf(fid,"%s %f\r\n","No.of steps in production run = ",L);
@printf(fid,"%s\r\n","Data:");
@printf(fid,"%6s %12s\r\n\r\n","r (distance)","Correlation function","Error");
for i in 1:size(r[:,:])[1]
@printf(fid,"%6u %16e %26\r\n",r[:,:][i],corr_avg[1,1,i]);
end
@printf(fid,"%s\r\n\r\n\r\n\r\n","");
close(fid);
#using Gadfly
#plt1=plot(x=Ts,y=Mp_avg,Guide.xlabel("Temp"),Guide.ylabel("Magnetisation/site"))
#plt2=plot(x=Ts,y=x_avg,Guide.xlabel("Temp"),Guide.ylabel("Susceptibility/site"))
#display(plt1)
#display(plt2)
