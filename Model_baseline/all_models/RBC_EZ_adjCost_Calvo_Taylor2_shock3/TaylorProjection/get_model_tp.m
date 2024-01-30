syms d dp logtheta logthetap za zap loghata loghatap auxvar1 auxvar1p real
syms tilvp_tilvss tilv_tilvss hatzp hatz real
syms logtilv_tilvss logtilvp_tilvss real
syms tilu tilup tilc tilcp l lp real
syms logtilu logtilup logtilc logtilcp real
syms loguc logucp lognegtilul lognegtilulp real
syms logtillambda logtillambdap logtilw logtilwp real
syms logmden logmdenp logmnom logmnomp real
syms logtilq logtilqp logtilr logtilrp real
syms logtilx logtilxp logtilxback logtilxbackp real
syms logtilkstarback logtilkstarbackp real
syms logtilk logtilkp real
syms logl loglp real
syms logtily logtilyp real
syms logqey logqeyp real
syms logMp u17 real

syms MUD RHOTHETA THETABAR SDV_THETA SDV_ZA ALPHA LAMBDA_A GAMMA NU PSI BETA DELTA PHI SCALEPARAM LOGTILUSS KAPPA LAMBDA_X  real

syms LAMBDA_MU SDV_ZMU loghatmu loghatmup real
syms m mp SDV_M xi xip RHOXI SDV_XI real
syms logAT logATback logAT_ss RHOAT real
syms OOMEGA real
syms logsoepistar logsoepistarp logsoerstar logsoerstarp logsoeystar logsoeystarp real
syms RHOSOEPISTAR logsoepistar_ss RHOSOERSTAR logsoerstar_ss RHOSOEYSTAR logsoeystar_ss SDV_SOEPISTAR SDV_SOERSTAR SDV_SOEYSTAR PISTARSS real
syms SOEPSIZERO real
syms logsoepistarback logsoepistarbackp real
syms logsoeimp logsoeexp logsoeimpp logsoeexpp logsoeph logsoephp logsoes logsoesp logsoes_ss logsoeph_ss SOEVARPHI SOECHIC SOEVARPHISTAR SOECHICSTAR IMPY EXPY real
syms logsoebstar logsoebstarback logsoepsiback logsoepsi SOEPSIONE logsoebstar_ss  real
syms logsoephback logsoephbackp real
syms logpiagg logpiaggp logsoesback logsoesbackp DISYSTAR real
syms logtilv logtilvp LOGTILVSS DUMMYTFP real

%% Exogenous state variables

x2p=[dp;
    logthetap;
    zap;
    logsoepistarp;
    logsoerstarp;
    logsoeystarp
    ];

Phi_fun=[MUD;
    (1-RHOTHETA)*log(THETABAR)+RHOTHETA*logtheta;
    0;
    (1-RHOSOEPISTAR)*logsoepistar_ss+RHOSOEPISTAR*logsoepistar;
    (1-RHOSOERSTAR)*logsoerstar_ss+RHOSOERSTAR*logsoerstar;
    (1-RHOSOEYSTAR)*logsoeystar_ss+RHOSOEYSTAR*logsoeystar
    ];

eta_mat=[0,0,0,0,0,0;
         0,0,0,0,0,0;
         0,0,0,0,0,0;
         0,0,0,0,0,0;
         0,0,0,0,0,0;
         0,0,0,0,0,0;
         0,0,0,0,0,0;
         0,0,0,0,0,0;
         0,0,0,0,0,0;
         0,0,0,0,0,0;
         0,0,0,0,0,0;
         1,0,0,0,0,0;
         0,SDV_THETA,0,0,0,0;
         0,0,SDV_ZA,0,0,0;
         0,0,0,SDV_SOEPISTAR,0,0;
         0,0,0,0,SDV_SOERSTAR,0;
         DISYSTAR,0,0,0,0,SDV_SOEYSTAR
         ];
     
% other variables that depend only on the exogenous state vars
syms loghata loghatap loghatz loghatzp real
loghata_=LAMBDA_A-OOMEGA*(1-ALPHA)*DUMMYTFP*d*exp(logtheta)+za;
loghatap_=LAMBDA_A-OOMEGA*(1-ALPHA)*DUMMYTFP*dp*exp(logthetap)+zap;


loghatz_=1/(1-ALPHA)*loghata;
loghatzp_=1/(1-ALPHA)*loghatap;

%% Model
% define auxiliary variable nl to bind l within [0,1]
syms nl nlp real
logl=nl-log(1+exp(nl));
loglp=nlp-log(1+exp(nlp));
syms u01p u02 real
u01p_=logtilvp_tilvss+loghatzp;
u02_=exp(-auxvar1);
f0=-1+exp(u01p)^(1-GAMMA)*u02; % auxiliary variable
syms u1 u2 u1p u2p real
u1_=exp(u2)*SCALEPARAM+BETA*exp(auxvar1*((1-PSI)/(1-GAMMA)));
u1p_=exp(u2p)*SCALEPARAM+BETA*exp(auxvar1p*((1-PSI)/(1-GAMMA)));
u2_=(logtilu-LOGTILUSS)*(1-PSI);
u2p_=(logtilup-LOGTILUSS)*(1-PSI);
logtilv_tilvss_=1/(1-PSI)*log(u1);
logtilvp_tilvss_=1/(1-PSI)*log(u1p);
l_=exp(logl);
lp_=exp(loglp);
logtilu_=logtilc+NU*log(1-l);%+xi;
logtilup_=logtilcp+NU*log(1-lp);%+xip;
loguc_=NU*log(1-l);%+xi;
logucp_=NU*log(1-lp);%+xip;
lognegtilul_=logtilw+loguc;
lognegtilulp_=logtilwp+logucp;

logtilv_=logtilv_tilvss+LOGTILUSS;
logtilvp_=logtilvp_tilvss+LOGTILUSS;

logtilc_=logtilw+log(1-l)-log(NU);
logtilcp_=logtilwp+log(1-lp)-log(NU);
logmnom_=log(BETA)-PSI*logtilc+NU*(1-PSI)*log(1-l)-PSI*loghatz+(PSI-GAMMA)*logtilv_tilvss+(PSI-GAMMA)*loghatz;
logmnomp_=log(BETA)-PSI*logtilcp+NU*(1-PSI)*log(1-lp)-PSI*loghatzp+(PSI-GAMMA)*logtilvp_tilvss+(PSI-GAMMA)*loghatzp;

logmden_=-PSI*logtilc+NU*(1-PSI)*log(1-l)+(PSI-GAMMA)/(1-GAMMA)*auxvar1; %denominator of logmp

syms tilr tilrp tilq tilqp theta thetap real
tilrp_=exp(logtilrp);
theta_=exp(logtheta);
thetap_=exp(logthetap);
syms u03 u04 real
logMp_=logmnomp-logmden;
u03_=logMp-dp*thetap;
u04_=1/tilq;
f9=exp(u03)*(tilrp+tilqp*(1-DELTA))*u04-1;
syms S Sprime logtilxback Sp Sprimep logtilxbackp real
S_=KAPPA/2*(exp(logtilx-logtilxback+loghatz)-LAMBDA_X)^2;
Sprime_=KAPPA*(exp(logtilx-logtilxback+loghatz)-LAMBDA_X);
Sprimep_=KAPPA*(exp(logtilxp-logtilxbackp+loghatzp)-LAMBDA_X);
f9c=-logtilx+logtilxbackp;
f10=-1+exp(logtilq)*(1-S-Sprime*exp(logtilx-logtilxback+loghatz))+...
    exp(logmnomp-logmden+logtilqp)*Sprimep*exp(2*(logtilxp-logtilx+loghatzp));
tilq_=exp(logtilq);
tilqp_=exp(logtilqp);
syms u4 tilx logtilx tily logtily real
syms soeph soeexp soes soeimp real 
tilc_=exp(logtilc);
tilx_=exp(logtilx);
soeph_=exp(logsoeph);
soeexp_=exp(logsoeexp);
soes_=exp(logsoes);
soeimp_=exp(logsoeimp);
tily_=(tilc+tilx+soeph*soeexp-soes*soeimp)/soeph;
logtily_=log(tily);
syms u4p tilyp logtilyp tilxp tilcp real
syms soephp soeexpp soesp soeimpp real 
tilcp_=exp(logtilcp);
tilxp_=exp(logtilxp);
soephp_=exp(logsoephp);
soeexpp_=exp(logsoeexpp);
soesp_=exp(logsoesp);
soeimpp_=exp(logsoeimpp);
tilyp_=(tilcp+tilxp+soephp*soeexpp-soesp*soeimpp)/soephp;
logtilyp_=log(tilyp);
syms u05 real
u05_=exp(-logtilx);
f15=exp(logtilkstarbackp)*u05-(1-DELTA)*exp(logtilk)*u05-(1-S);
logtilk_=logtilkstarback-d*theta-loghatz;
logtilkp_=logtilkstarbackp-dp*thetap-loghatzp;
syms w wp real
syms tildiv tildivp logtilqe logtilqep real
w_=exp(logtilw);
wp_=exp(logtilwp);
tildiv_=tily-w*l-tilx;
tildivp_=tilyp-wp*lp-tilxp;
u17_=logMp+loghatzp;
f17=-1+exp(u17)*(tildivp+exp(logtilqep))*exp(-logtilqe);
syms logqf logqfp real
f18=-1+exp(logMp)*exp(-logqf);
syms logmc logmcp logtilg1 logtilg1p logtilg2 logtilg2p logpi logpip logpistar logpistarp logpiback logpibackp real
syms logvpback logvpbackp real
syms THETA_P CHI EPSILON real
logmc_=(ALPHA-1)*log(1-ALPHA)-ALPHA*log(ALPHA)+(1-ALPHA)*logtilw+ALPHA*logtilr-logsoeph;
f19=-1+[exp(logmc+logtily)+THETA_P*exp(logmnomp-logmden-EPSILON*(CHI*logpi-logpip)+logtilg1p+loghatzp)]*exp(-logtilg1);
logtilg2_=log(EPSILON)+logtilg1-log(EPSILON-1);
logtilg2p_=log(EPSILON)+logtilg1p-log(EPSILON-1);
syms aux2 aux2p pi_power pi_powerp real
pi_power_=THETA_P*exp(logpiback*(CHI*(1-EPSILON)))+(1-THETA_P)*exp(aux2*(1-EPSILON));
pi_powerp_=THETA_P*exp(logpibackp*(CHI*(1-EPSILON)))+(1-THETA_P)*exp(aux2p*(1-EPSILON));
logpi_=log(pi_power)/(1-EPSILON);
logpip_=log(pi_powerp)/(1-EPSILON);
logpistar_=aux2-logpi;
logpistarp_=aux2p-logpip;
f20=-1+[exp(logpistar+logtily)+THETA_P*exp(logmnomp-logmden+(1-EPSILON)*(CHI*logpi-logpip)...
    +logpistar-logpistarp+logtilg2p+loghatzp)]*exp(-logtilg2);
f22=-logpibackp+logpi;
f23=-1+[THETA_P*exp(-EPSILON*(CHI*logpiback-logpi)+logvpback)+(1-THETA_P)*exp(-EPSILON*logpistar)]*exp(-logvpbackp);
logtilr_=-(logtilk-logl)+log(ALPHA)-log(1-ALPHA)+logtilw;
logtilrp_=-(logtilkp-loglp)+log(ALPHA)-log(1-ALPHA)+logtilwp;
syms u13a real
u13a_=exp(logtily+logvpbackp)+PHI;
f13=-log(u13a)+loghata+logAT-loghatz+(ALPHA)*(logtilkstarback-d*exp(logtheta))+(1-ALPHA)*logl;
syms logR logRp RSS PISS GAMMA_PI real
syms GAMMA_Y LAMBDA_Y logtilyback logtilybackp real
syms logRback logRbackp GAMMA_R real
syms GAMMA_D YSS GAMMA_E real
logR_=log(RSS)+GAMMA_R*(logRback-log(RSS))+(1-GAMMA_R)*[GAMMA_PI*(logpiagg-log(PISS))+GAMMA_Y*(logtily-logtilyback+loghatz-LAMBDA_Y)+GAMMA_D*(-d*exp(logtheta))+GAMMA_E*(logsoes-logsoesback+logpiagg-logsoepistar-log(PISS)+logsoepistar_ss)];%+m;%-MUD*THETABAR (d-MUD)*logtily
syms ZZETA real
f24=-1+exp(logmnomp-logmden+logR-logpiaggp);
f25=-logtilybackp+logtily;
f26=-logRbackp+logR;
syms logtilwelf logtilwelfp tilwelf tilwelfp real
f27=-exp(logtilwelf)^(1-PSI)+(1-BETA)*(exp(log(1-LOSS)+logtilc+NU*log(1-l)))^(1-PSI)+BETA*(exp(logtilwelfp)^(1-GAMMA))^((1-PSI)/(1-GAMMA));
tilwelf_=exp(logtilwelf);
tilwelfp_=exp(logtilwelfp);
syms logAT logATback logATp logAT_ss RHOAT OOMEGA2 real
f28=-logAT+(1-RHOAT)*logAT_ss+RHOAT*logATback-(1-OOMEGA)*(1-ALPHA)*DUMMYTFP*(d*exp(logtheta)-MUD*THETABAR);

f36=-logsoepistarback+logsoepistarp;
logsoeimp_=log(1-SOEVARPHI)-SOECHIC*logsoes+log(exp(logtilc)+exp(logtilx));
logsoeimpp_=log(1-SOEVARPHI)-SOECHIC*logsoesp+log(exp(logtilcp)+exp(logtilxp));
f33=-logsoeexp+log(SOEVARPHISTAR)-SOECHICSTAR*(logsoeph-logsoes)+logsoeystar;
f34=-exp(logsoeph+logsoeexp)+exp(logsoes+logsoeimp)-exp(logsoes+logsoerstar+logsoepsiback+logsoebstarback-loghatz-logsoepistarp)+exp(logsoes+logsoebstar);
f30=-logsoepsi+log(SOEPSIZERO)-SOEPSIONE*(exp(logsoebstar)-exp(logsoebstar_ss));
f31=-logR+logsoerstarp+logsoepsi+logsoesp-logsoes+logpiaggp-logsoepistarp;
f29=-1+(SOEVARPHI*(exp(logsoeph))^(1-SOECHIC)+(1-SOEVARPHI)*(exp(logsoes))^(1-SOECHIC))^(1/(1-SOECHIC));
f35=-logsoephbackp+logsoeph;
logpiagg_=logpi-logsoephbackp+logsoephback;
logpiaggp_=logpip-logsoephp+logsoeph;
f38=-logsoesbackp+logsoes;

%%
f=[f0;f9;f13;f15;f17;f18;f9c;f10;f19;f20;f22;f23;f24;f25;f26;f27;f28;f36;f33;f34;f30;f31;f29;f35;f38];%
f=simplify(f);

x=[logtilkstarback;
    logtilxback;
    logpiback;
    logvpback;
    logtilyback;
    logRback;
    logATback;
    logsoebstarback;
    logsoepsiback;
    logsoephback;
    logsoesback;
    d;
    logtheta;
    za;
    logsoepistar;
    logsoerstar;
    logsoeystar  ];

xp=[logtilkstarbackp;
    logtilxbackp;
    logpibackp;
    logvpbackp;
    logtilybackp;
    logRbackp;
    logAT;
    logsoebstar;
    logsoepsi;
    logsoephbackp;
    logsoesbackp;
    dp;
    logthetap;
    zap;
      logsoepistarp;
    logsoerstarp;
    logsoeystarp   ];



y=[auxvar1,nl,logtilw,logtilx,logtilqe,logqf,logtilq,logtilg1,aux2,logtilwelf,logsoepistarback,logsoeexp,logsoes,logsoeph];
yp=[auxvar1p,nlp,logtilwp,logtilxp,logtilqep,logqfp,logtilqp,logtilg1p,aux2p,logtilwelfp,logsoepistarbackp,logsoeexpp,logsoesp,logsoephp];


subsvars=[loghata;loghatap;loghatz;loghatzp;u1;u1p;u2;u2p;logtilv_tilvss;logtilvp_tilvss;l;lp;logtilu;logtilup;loguc;logucp;...
    logtilc;logtilcp;logmnom;logmnomp;logmden;...
    theta;thetap;tilrp;tilq;tilqp;logtilr;logtilrp;...
    tilc;tilcp;tilx;tilxp;logtilk;logtilkp;u01p;u02;u03;u04;u05;logMp;u17;tily;logtily;tilyp;logtilyp;...
    w;wp;tildiv;tildivp;S;Sprime;Sprimep;logmc;logtilg2;logtilg2p;logpistar;logpistarp;...
    u13a;logR;pi_power;pi_powerp;logpi;logpip;tilwelf;tilwelfp;...
    logsoeimp;logsoeimpp;...
    soeph;soephp;soeexp;soeexpp;soes;soesp;soeimp;soeimpp;logpiagg;logpiaggp;logtilv;logtilvp]; 


subsfuns=sym(zeros(size(subsvars)));
for i=1:length(subsfuns)
    subsfuns(i)=eval([char(subsvars(i)) '_']);
end

symparams=[MUD RHOTHETA THETABAR SDV_THETA SDV_ZA ALPHA LAMBDA_A GAMMA ...
    NU PSI BETA DELTA PHI SCALEPARAM LOGTILUSS KAPPA LAMBDA_X...
    THETA_P CHI EPSILON RSS PISS GAMMA_PI GAMMA_Y LAMBDA_Y GAMMA_R LAMBDA_MU SDV_ZMU SDV_M RHOXI LOSS GAMMA_D YSS RHOAT logAT_ss OOMEGA ZZETA...
    RHOSOEPISTAR logsoepistar_ss RHOSOERSTAR logsoerstar_ss RHOSOEYSTAR logsoeystar_ss SDV_SOEPISTAR SDV_SOERSTAR SDV_SOEYSTAR PISTARSS SOEPSIZERO...
     SOEVARPHI SOECHIC SOEVARPHISTAR SOECHICSTAR logsoes_ss logsoeph_ss IMPY EXPY SOEPSIONE logsoebstar_ss DISYSTAR GAMMA_E DUMMYTFP];
