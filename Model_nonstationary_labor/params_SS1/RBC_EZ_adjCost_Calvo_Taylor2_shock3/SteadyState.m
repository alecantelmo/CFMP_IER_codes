
pibackss=PISS;
piss=PISS;
piaggss=PISS;
pistarss=[(1-THETA_P*(piss^CHI/piss)^(1-EPSILON))/(1-THETA_P)]^(1/(1-EPSILON));
vpss=(1-THETA_P)*pistarss^(-EPSILON)/[1-THETA_P*(piss^CHI/piss)^(-EPSILON)];
dss=MUD;
thetass=THETABAR;
loghatass=LAMBDA_A-OOMEGA*(1-ALPHA)*dss*thetass;
loghatlaborss=0;
logsoepistarss=log(PISTARSS);
logsoepistarbackss=logsoepistarss;
soephss=1;
soesss=1;
soepsiss=SOEPSIZERO;

loghatmuss=0; % assume no investment specific shock (or trend)
loghatzss=1/(1-ALPHA)*loghatass+ALPHA/(1-ALPHA)*loghatmuss+loghatlaborss;

hatzss=exp(loghatzss);
mss=BETA*hatzss^(-PSI);
tilqss=1;

tilrss=tilqss/(mss*exp(-dss*thetass))-tilqss*(1-DELTA);

hatass=exp(loghatass);
hatmuss=exp(loghatmuss);
hatlaborss=exp(loghatlaborss);


OPTIONS = optimoptions('fsolve','tolF',1e-10);
tilwss=1.5;%initial value for fsolve
[tilwss,R,~,output,J]=fsolve(@(tilwss) solve_SS(tilwss,tilrss,vpss,dss,thetass,hatass,hatzss,hatmuss,piss,tilqss,...
    ALPHA,DELTA,THETA_P,EPSILON,CHI,NU,PHI,GAMMA,BETA,PSI,LOSS,logAT_ss,EXPY,IMPY),tilwss,OPTIONS);


[ ~,auxvar1ss,logtilv_tilvss_ss,logtiluss,logtilcss,loglss,logtilwss,logucss,...%logtillambdass,
    lognegtilulss,logmnomss,logmdenss,logtilrss,logtilqss,logtilxss,logtilkss,logtilyss,logtilqess,logqfss,tildivss,...
    Sss,Sprimess,logtilg1ss,logtilkstarss, ...
    SCALEPARAM,LOGTILUSS,logtilwelfss,Profits_ss,soeimpss,soeexpss,SOEVARPHI] = solve_SS( tilwss,tilrss,vpss,dss,thetass,hatass,hatzss,hatmuss,piss,tilqss,...
    ALPHA,DELTA,THETA_P,EPSILON,CHI,NU,PHI,GAMMA,BETA,PSI,LOSS,logAT_ss,EXPY,IMPY);

logpibackss=log(piss);
logvpbackss=log(vpss);
logpiss=log(piss);
logpistarss=log(pistarss);
lss=exp(loglss);
nlss=log(lss)-log(1-lss);
aux2ss=logpiss+logpistarss;

logtilv_ss=logtilcss+NU*log(1-lss);


logtilybackss=logtilyss;
loghatmuss=LAMBDA_MU;
LAMBDA_X=hatzss;
RSS=PISS/exp(logmnomss-logmdenss);
LAMBDA_Y=loghatzss;
xiss=0;
logRbackss=log(RSS);
logthetass=log(thetass);
zass=0;
Rf_ss=exp(-logqfss);
Rf_ss_Ann=100*(Rf_ss^4-1);
mss=0;
AT_ss=exp(logAT_ss);
logATss=logAT_ss;
logsoerstarss=log(RSS*PISTARSS/(SOEPSIZERO*PISS));


logsoephss=log(soephss);
logsoesss=log(soesss);
logsoeimpss=log(soeimpss);
logsoeexpss=log(soeexpss);
soevarphiss=SOEVARPHI;
logsoeystarss=log(soeexpss/SOEVARPHISTAR);
logsoepsiss=log(soepsiss);
soebstarss=(soeexpss-soeimpss)/(1-exp(logsoerstarss)*SOEPSIZERO/(hatzss*PISTARSS));
logsoebstarss=log(soebstarss);
logpiaggss=log(piaggss);
loghatlaborss=0;
