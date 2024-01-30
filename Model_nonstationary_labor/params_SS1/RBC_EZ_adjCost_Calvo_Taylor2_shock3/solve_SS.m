function [ residual,auxvar1ss,logtilv_tilvss_ss,logtiluss,logtilcss,loglss,logtilwss,logucss,...%,logtillambdass
    lognegtilulss,logmnomss,logmdenss,logtilrss,logtilqss,logtilxss,logtilkss,logtilyss,logtilqess,logqfss,tildivss,...
    Sss,Sprimess,logtilg1ss,logtilkstarss, ...
    SCALEPARAM,LOGTILUSS,logtilwelfss,Profits_ss,soeimpss,soeexpss,SOEVARPHI] = solve_SS( tilwss,tilrss,vpss,dss,thetass,hatass,hatzss,hatmuss,piss,tilqss,...
    ALPHA,DELTA,THETA_P,EPSILON,CHI,NU,PHI,GAMMA,BETA,PSI,LOSS,logAT_ss,EXPY,IMPY)
%Auxiliary function to use with fsolve to find tilwss for the Calvo pricing
%model.
AT_ss=exp(logAT_ss);

loghatzss=log(hatzss);
k_to_l=ALPHA/(1-ALPHA)*tilwss/tilrss;

kstar_to_l=k_to_l*exp(dss*thetass)*hatzss*hatmuss;

nxy=EXPY-IMPY;
nxy2=1/(1-nxy);
lss=(PHI+nxy2*tilwss/NU*vpss)/(AT_ss*hatass/hatzss*kstar_to_l^ALPHA*exp(-dss*thetass*ALPHA)...
    +nxy2*tilwss/NU*vpss-(nxy2*kstar_to_l-(1-DELTA)*nxy2*k_to_l)*vpss);

tilkstarss=kstar_to_l*lss;

tilkss=tilkstarss/hatzss/hatmuss*exp(-dss*thetass);
tilxss=tilkstarss-(1-DELTA)*tilkss;

tilcss=(1-lss)*tilwss/NU;
tilyss=(tilcss+tilxss)/(1-nxy);
soeexpss=EXPY*tilyss;
soeimpss=IMPY*tilyss;
SOEVARPHI=1-soeimpss/(tilcss+tilxss);

% logs
logtilcss=log(tilcss);

% continue

logtiluss=logtilcss+NU*log(1-lss);
ucss=(1-lss)^NU;
tilulss=-NU*tilcss*(1-lss)^(NU-1);

tilwelfss=(tilcss*(1-lss)^NU)+BETA*(hatzss^(1-PSI));
logtilwelfss=log(tilwelfss);


logtilv_tilvss_ss=0;
auxvar1ss=(logtilv_tilvss_ss+loghatzss)*(1-GAMMA);
SCALEPARAM=1-BETA*exp(auxvar1ss)^((1-PSI)/(1-GAMMA)); %SCALEPARAM is needed to state the utility function in ratios of steady state utility

loglss=log(lss);

logucss=log(ucss);

lognegtilulss=log(NU)+logtilcss+(NU-1)*log(1-lss);


logmnomss=log(BETA)-PSI*logtilcss+NU*(1-PSI)*log(1-lss)-PSI*loghatzss+(PSI-GAMMA)*logtilv_tilvss_ss+(PSI-GAMMA)*loghatzss;
logmdenss=-PSI*logtilcss+NU*(1-PSI)*log(1-lss)+(PSI-GAMMA)/(1-GAMMA)*auxvar1ss;


logtilwss=log(tilwss);
logtilrss=log(tilrss);
logtilqss=log(tilqss);
logtilxss=log(tilxss);
logtilkss=log(tilkss);
logtilkstarss=log(tilkstarss);
logtilyss=log(tilyss);

LOGTILUSS=logtiluss;



tildivss=tilyss-tilwss*lss-tilxss;

logtilqess=(logmnomss-logmdenss+loghatzss+log(tildivss))-log(1-exp(logmnomss-logmdenss+loghatzss));

logqfss=logmnomss-logmdenss;

%%%%%% continue
mss=exp(logmnomss-logmdenss);

mcss=(1/(1-ALPHA))^(1-ALPHA)*(1/ALPHA)^ALPHA*tilwss^(1-ALPHA)*tilrss^ALPHA;

tilg1ss=mcss*tilyss/[1-THETA_P*mss*(piss^CHI/piss)^(-EPSILON)*hatzss];

tilg2ss=EPSILON*tilg1ss/(EPSILON-1);

pistarss=[tilg2ss-THETA_P*mss*(piss^CHI/piss)^(1-EPSILON)*tilg2ss*hatzss]/tilyss;

residual=-1+THETA_P*(piss^CHI/piss)^(1-EPSILON)+(1-THETA_P)*pistarss^(1-EPSILON);

Sss=0;
Sprimess=0;
logtilg1ss=log(tilg1ss);


Profits_ss=tilyss-tilwss*lss-tilrss*tilkss;
end

