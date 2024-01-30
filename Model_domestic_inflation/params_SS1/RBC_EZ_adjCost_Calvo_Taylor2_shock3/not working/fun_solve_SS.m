function y=fun_solve_SS(x)
parameters

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

%%% Variables to find with fsolve
tilwss=x(1);

%%% Steady state of variables in levels

% loghatzss=log(hatzss);
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

% these are the equations for which fsolve will find the solution
y=[tilwss+(1-PSI)*(tiluss^(-PSI))*tilulss/tillambdass;];




