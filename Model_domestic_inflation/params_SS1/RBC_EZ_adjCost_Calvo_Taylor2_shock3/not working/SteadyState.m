%%% Known variables in steady state %%%
pibackss=PISS;
piss=PISS;
pistarss=[(1-THETA_P*(piss^CHI/piss)^(1-EPSILON))/(1-THETA_P)]^(1/(1-EPSILON));
vpss=(1-THETA_P)*pistarss^(-EPSILON)/[1-THETA_P*(piss^CHI/piss)^(-EPSILON)];
dss=MUD;
thetass=THETABAR;
loghatass=LAMBDA_A-(1-ALPHA)*dss*thetass;
loghatmuss=LAMBDA_MU;
loghatzss=1/(1-ALPHA)*loghatass+ALPHA/(1-ALPHA)*loghatmuss;
hatzss=exp(loghatzss);
mss=BETA*hatzss^(-PSI);
tilqss=1;
tilrss=(tilqss/(mss*exp(-dss*thetass)))-tilqss*(1-DELTA);
hatass=exp(loghatass);
hatmuss=exp(loghatmuss);
LAMBDA_X=hatzss;
Sss=0;
Sprimess=0;
zass=0;
%%% Initial values for fsolve
x0=1.45;

[x,fval,exitflag] =fsolve(@fun_solve_SS,x0,optimset('Display','on'));

%%% Variables to find with fsolve
tilwss=x(1);

%%% Steady state of variables in levels
k_to_l=ALPHA/(1-ALPHA)*tilwss/tilrss;
kstar_to_l=k_to_l*exp(dss*thetass)*hatzss*hatmuss;
lss=(PHI+tilwss/NU*vpss)/(hatass/hatzss*kstar_to_l^ALPHA*exp(-dss*thetass*ALPHA)...
    +tilwss/NU*vpss-(kstar_to_l-(1-DELTA)*k_to_l)*vpss);
tilkstarss=kstar_to_l*lss;
tilkss=tilkstarss/hatzss/hatmuss*exp(-dss*thetass);
tilxss=tilkstarss-(1-DELTA)*tilkss;
tilcss=(1-lss)*tilwss/NU;
tilyss=tilcss+tilxss;
tiluss=tilcss*(1-lss)^NU;
ucss=(1-lss)^NU;
tillambdass=(1-PSI)*(tiluss^(-PSI))*ucss;
tilulss=-NU*tilcss*(1-lss)^(NU-1);
tildivss=tilyss-tilwss*lss-tilxss;
mcss=(1/(1-ALPHA))^(1-ALPHA)*(1/ALPHA)^ALPHA*tilwss^(1-ALPHA)*tilrss^ALPHA;
mss=BETA*hatzss^(-PSI);
tilg1ss=mcss*tilyss/[1-THETA_P*mss*(piss^CHI/piss)^(-EPSILON)*hatzss];
tilg2ss=EPSILON*tilg1ss/(EPSILON-1);
tilwss=-(1-PSI)*(tiluss^(-PSI))*tilulss/tillambdass;
tilwelfss=((1-LOSS)*tilcss*(1-lss)^NU);


%%% Logs of variables to save
logtilv_tilvss_ss=0;
auxvar1ss=(logtilv_tilvss_ss+loghatzss)*(1-GAMMA);
SCALEPARAM=1-BETA*exp(auxvar1ss)^((1-PSI)/(1-GAMMA)); %SCALEPARAM is needed to state the utility function in ratios of steady state utility
logtilcss=log(tilcss);
logtiluss=logtilcss+NU*log(1-lss);
logthetass=log(thetass);
loglss=log(lss);
logucss=log(ucss);
logtillambdass=log(1-PSI)-PSI*logtiluss+logucss;
lognegtilulss=log(NU)+logtilcss+(NU-1)*log(1-lss);
logmnomss=log(BETA)+logtillambdass-PSI*loghatzss+(PSI-GAMMA)*logtilv_tilvss_ss+(PSI-GAMMA)*loghatzss;
logmdenss=logtillambdass+(PSI-GAMMA)/(1-GAMMA)*auxvar1ss;
logtilwss=log(tilwss);
logtilrss=log(tilrss);
logtilqss=log(tilqss);
logtilxss=log(tilxss);
logtilkss=log(tilkss);
logtilkstarss=log(tilkstarss);
logtilyss=log(tilyss);
LOGTILUSS=logtiluss;
logtilqess=(logmnomss-logmdenss+loghatzss+log(tildivss))-log(1-exp(logmnomss-logmdenss+loghatzss));
logqfss=logmnomss-logmdenss;
mss=exp(logmnomss-logmdenss);

%Parameters in steady state
LAMBDA_X=hatzss;
RSS=PISS/exp(logmnomss-logmdenss);
LAMBDA_Y=loghatzss;
xiss=0;

% Steady state risk-free rate
Rf_ss=exp(-logqfss);
Rf_ss_Ann=100*(Rf_ss^4-1);
