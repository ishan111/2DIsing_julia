@everywhere function parallel_Ising(n_grid,L,J,P,Tmin,Tinc,Tmax,len,gridqm,Ts,ncores::Cons=4)

    #Compute properties in parallel, over ncores cores, with a Monte Carlo simulation
    #Dividing MC steps over all available cores
    a=@spawn Ising(n_grid,ceil(Int, L / ncores),J,P,Tmin,Tinc,Tmax,len,gridqm,Ts)
    b=@spawn Ising(n_grid,ceil(Int, L / ncores),J,P,Tmin,Tinc,Tmax,len,gridqm,Ts)
    c=@spawn Ising(n_grid,ceil(Int, L / ncores),J,P,Tmin,Tinc,Tmax,len,gridqm,Ts)
    d=@spawn Ising(n_grid,ceil(Int, L / ncores),J,P,Tmin,Tinc,Tmax,len,gridqm,Ts)
    Mp1,x1,T1 = fetch(a)
    Mp2,x2,T2 = fetch(b)
    Mp3,x3,T3 = fetch(c)
    Mp4,x4,T4 = fetch(d)

    Mpavg=(Mp1+Mp2+Mp3+Mp4)/ncores
    xavg=(x1+x2+x3+x4)/ncores
    Tsavg=(T1+T2+T3+T4)/ncores
    return Mpavg, xavg, Tsavg  # average value
end
