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

syms MUD RHOTHETA THETABAR SDV_THETA SDV_ZA ALPHA LAMBDA_A GAMMA NU PSI BETA DELTA PHI SCALEPARAM LOGTILUSS KAPPA LAMBDA_X real

syms LAMBDA_MU SDV_ZMU loghatmu loghatmup real
syms m mp SDV_M xi xip RHOXI SDV_XI real
syms logAT logATback logAT_ss RHOAT real
syms OOMEGA real
syms logsoepistar logsoepistarp logsoerstar logsoerstarp logsoeystar logsoeystarp real
syms RHOSOEPISTAR logsoepistar_ss RHOSOERSTAR logsoerstar_ss RHOSOEYSTAR logsoeystar_ss SDV_SOEPISTAR SDV_SOERSTAR SDV_SOEYSTAR PISTARSS real
syms SOEPSIZERO real
syms logsoepistarback logsoepistarbackp real
syms logsoeimp logsoeexp logsoeimpp logsoeexpp logsoeph logsoephp logsoes logsoesp logsoes_ss logsoeph_ss SOEVARPHI SOECHIC SOEVARPHISTAR SOECHICSTAR IMPY EXPY real
syms logsoebstar logsoebstarback logsoepsiback logsoepsi SOEPSIONE logsoebstar_ss real
syms logsoepistarback logsoepistarbackp real 
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
loghata=LAMBDA_A-OOMEGA*(1-ALPHA)*DUMMYTFP*d*exp(logtheta)+za;
loghatap=LAMBDA_A-OOMEGA*(1-ALPHA)*DUMMYTFP*dp*exp(logthetap)+zap;


loghatz=1/(1-ALPHA)*loghata;
loghatzp=1/(1-ALPHA)*loghatap;

%% Model

% define auxiliary variable nl to bind l within [0,1]
syms nl nlp real
l=exp(nl)/(1+exp(nl));
lp=exp(nlp)/(1+exp(nlp));
logl=nl-log(1+exp(nl));
loglp=nlp-log(1+exp(nlp));
f0=-1+exp(-auxvar1)*exp(logtilvp_tilvss+loghatzp)^(1-GAMMA); % auxiliary variable - VERY IMPORTANT to do it in log
f1=[-exp(logtilv_tilvss)^(1-PSI)+exp(logtilu-LOGTILUSS)^(1-PSI)*SCALEPARAM+BETA*exp(auxvar1*(1-PSI)/(1-GAMMA))]*exp(-logtilv_tilvss)^(1-PSI);
f39=-logtilv+logtilv_tilvss+LOGTILUSS;


f2=-logtilu+logtilc+NU*log(1-l);%+xi;
f3=-loguc+NU*log(1-l);%+xi;
f4=-lognegtilul+log(NU)+logtilc+(NU-1)*log(1-l);% %lognegtilul is the log of negative tilul, because tilul itself is negative
f5=-logtilw+lognegtilul-loguc;

f7=-logmnom+log(BETA)-PSI*logtilc+NU*(1-PSI)*log(1-l)-PSI*loghatz+(PSI-GAMMA)*logtilv_tilvss+(PSI-GAMMA)*loghatz; %nominator of logm

f8=-logmden-PSI*logtilc+NU*(1-PSI)*log(1-l)+(PSI-GAMMA)/(1-GAMMA)*auxvar1; %denominator of logmp


f9=exp(logmnomp-logmden-dp*exp(logthetap))*(exp(logtilrp)+exp(logtilqp)*(1-DELTA))*exp(-logtilq)-1;
syms S Sprime logtilxback Sp Sprimep logtilxbackp real
f9a=-S+KAPPA/2*(exp(logtilx-logtilxback+loghatz)-LAMBDA_X)^2;
f9b=-Sprime+KAPPA*(exp(logtilx-logtilxback+loghatz)-LAMBDA_X);
f9c=-logtilx+logtilxbackp;
f10=-1+exp(logtilq)*(1-S-Sprime*exp(logtilx-logtilxback+loghatz))+...
    exp(logmnomp-logmden+logtilqp)*Sprimep*exp(2*(logtilxp-logtilx+loghatzp));
f14=[-exp(logtily+logsoeph)+exp(logtilc)+exp(logtilx)+exp(logsoeph+logsoeexp)-exp(logsoes+logsoeimp)]*exp(-logtilx);
f15=exp(logtilkstarbackp)*exp(-logtilx)-(1-DELTA)*exp(logtilk)*exp(-logtilx)-(1-S);
f16=-logtilk+logtilkstarback-d*exp(logtheta)-loghatz;%-loghatmu;
syms tildiv tildivp logtilqe logtilqep real
f17=-1+exp(-logtilqe)*exp(logmnomp-logmden+loghatzp)*(tildivp+exp(logtilqep));
f17a=[-tildiv+exp(logtily)-exp(logtilw+logl)-exp(logtilx)]*exp(-logtilx); % dividends equal total output excluding labour income and investments
syms logqf logqfp real
f18=-1+exp(-logqf)*exp(logmnomp-logmden);
syms logmc logmcp logtilg1 logtilg1p logtilg2 logtilg2p logpi logpip logpistar logpistarp logpiback logpibackp real
syms logvpback logvpbackp real
syms THETA_P CHI EPSILON real
logmc=(ALPHA-1)*log(1-ALPHA)-ALPHA*log(ALPHA)+(1-ALPHA)*logtilw+ALPHA*logtilr-logsoeph;
f19=[-exp(logtilg1)+exp(logmc+logtily)+THETA_P*exp(logmnomp-logmden-EPSILON*(CHI*logpi-logpip)+logtilg1p+loghatzp)]*exp(-logtilg1);
logtilg2=log(EPSILON)+logtilg1-log(EPSILON-1);
logtilg2p=log(EPSILON)+logtilg1p-log(EPSILON-1);
f20=[-exp(logtilg2)+exp(logpistar+logtily)+THETA_P*exp(logmnomp-logmden+(1-EPSILON)*(CHI*logpi-logpip)...
    +logpistar-logpistarp+logtilg2p+loghatzp)]*exp(-logtilg2);
f21=-1+THETA_P*exp((1-EPSILON)*(CHI*logpiback-logpi))+(1-THETA_P)*exp((1-EPSILON)*logpistar);
syms aux2 aux2p real
f21b=aux2-logpi-logpistar;
f22=-logpibackp+logpi;
f23=[-exp(logvpbackp)+THETA_P*exp(-EPSILON*(CHI*logpiback-logpi)+logvpback)+(1-THETA_P)*exp(-EPSILON*logpistar)]*exp(-logvpbackp);
f11=-(logtilk-logl)+log(ALPHA)-log(1-ALPHA)+logtilw-logtilr;
f13=-log(exp(logtily+logvpbackp)+PHI)+loghata+logAT-loghatz+(ALPHA)*(logtilkstarback-d*exp(logtheta))+(1-ALPHA)*logl;
syms logR logRp RSS PISS GAMMA_PI real
syms GAMMA_Y LAMBDA_Y logtilyback logtilybackp real
syms logRback logRbackp GAMMA_R logtily_f real
syms GAMMA_D YSS GAMMA_E real
logR=log(RSS)+GAMMA_R*(logRback-log(RSS))+(1-GAMMA_R)*[GAMMA_PI*(logpiagg-log(PISS))+GAMMA_Y*(logtily-logtilyback+loghatz-LAMBDA_Y)+GAMMA_E*(logsoes-logsoesback+logpiagg-logsoepistar-log(PISS)+logsoepistar_ss)];
f24=-1+exp(logmnomp-logmden+logR-logpiaggp);
f25=-logtilybackp+logtily;
f26=-logRbackp+logR;
syms logtilwelf logtilwelfp LOSS OOMEGA2 real
f27=-exp(logtilwelf)^(1-PSI)+(1-BETA)*(exp(log(1-LOSS)+logtilc+NU*log(1-l)))^(1-PSI)+BETA*(exp(logtilwelfp)^(1-GAMMA))^((1-PSI)/(1-GAMMA));
f28=-logAT+(1-RHOAT)*logAT_ss+RHOAT*logATback-(1-OOMEGA)*(1-ALPHA)*DUMMYTFP*(d*exp(logtheta)-MUD*THETABAR);


f36=-logsoepistarback+logsoepistarp;
f32=-logsoeimp+log(1-SOEVARPHI)-SOECHIC*logsoes+log(exp(logtilc)+exp(logtilx));
f33=-logsoeexp+log(SOEVARPHISTAR)-SOECHICSTAR*(logsoeph-logsoes)+logsoeystar;
f34=-exp(logsoeph+logsoeexp)+exp(logsoes+logsoeimp)-exp(logsoes+logsoerstar+logsoepsiback+logsoebstarback-loghatz-logsoepistarp)+exp(logsoes+logsoebstar);
f30=-logsoepsi+log(SOEPSIZERO)-SOEPSIONE*(exp(logsoebstar)-exp(logsoebstar_ss));
f31=-logR+logsoerstarp+logsoepsi+logsoesp-logsoes+logpiaggp-logsoepistarp;
f29=-1+(SOEVARPHI*(exp(logsoeph))^(1-SOECHIC)+(1-SOEVARPHI)*(exp(logsoes))^(1-SOECHIC))^(1/(1-SOECHIC));
f35=-logsoephbackp+logsoeph;
f37=-logpiagg+logpi-logsoephbackp+logsoephback;
f38=-logsoesbackp+logsoes;
% End of model %%%%%%%%%%%%%%%%%%%%%%%
%% 

f=[f0;f1;f2;f3;f4;f5;f7;f8;f9;f9a;f9b;f9c;f10;f11;f13;f14;f15;f16;f17;f17a;f18;f19;f20;f21;f22;f23;f24;f25;f26;f21b;f27;f28;f36;f32;f33;f34;f30;...
    f31;f29;f35;f37;f38;f39];
f=simplify(f);

f=subs(f,[hatz,tilu,tilc,l],exp([loghatz,logtilu,logtilc,logl]));
f=subs(f,[hatzp,tilup,tilcp,lp],exp([loghatzp,logtilup,logtilcp,loglp]));

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
    logsoeystar ];

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
    logsoeystarp ];

y=[auxvar1,logtilv_tilvss,logtilu,logtilc,nl,logtilw,loguc,...
    lognegtilul,logmnom,logmden,logtilr,logtilq,logtilx,logtilk,logtily,...
    logtilqe,logqf,tildiv,S,Sprime,...
    logtilg1,logpi,logpistar,aux2,logtilwelf,logsoepistarback,...
    logsoes,logsoeimp,logsoeexp,logsoeph,logpiagg,logtilv];
yp=[auxvar1p,logtilvp_tilvss,logtilup,logtilcp,nlp,logtilwp,logucp,...
    lognegtilulp,logmnomp,logmdenp,logtilrp,logtilqp,logtilxp,logtilkp,logtilyp,...
    logtilqep,logqfp,tildivp,Sp,Sprimep,...
    logtilg1p,logpip,logpistarp,aux2p,logtilwelfp,logsoepistarbackp,...
    logsoesp,logsoeimpp,logsoeexpp,logsoephp,logpiaggp,logtilvp];

symparams=[MUD RHOTHETA THETABAR SDV_THETA SDV_ZA ALPHA LAMBDA_A GAMMA ...
    NU PSI BETA DELTA PHI SCALEPARAM LOGTILUSS KAPPA LAMBDA_X...
    THETA_P CHI EPSILON RSS PISS GAMMA_PI GAMMA_Y LAMBDA_Y GAMMA_R LAMBDA_MU SDV_ZMU SDV_M RHOXI LOSS GAMMA_D YSS RHOAT logAT_ss OOMEGA ZZETA...
    RHOSOEPISTAR logsoepistar_ss RHOSOERSTAR logsoerstar_ss RHOSOEYSTAR logsoeystar_ss SDV_SOEPISTAR SDV_SOERSTAR SDV_SOEYSTAR PISTARSS SOEPSIZERO...
    SOEVARPHI SOECHIC SOEVARPHISTAR SOECHICSTAR logsoes_ss logsoeph_ss IMPY EXPY SOEPSIONE logsoebstar_ss DISYSTAR GAMMA_E DUMMYTFP];

