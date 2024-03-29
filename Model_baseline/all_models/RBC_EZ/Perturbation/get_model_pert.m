syms d dp logtheta logthetap za zap loghata loghatap auxvar1 auxvar1p real
syms tilvp_tilvss tilv_tilvss hatzp hatz real
syms logtilv_tilvss logtilvp_tilvss real
syms tilu tilup tilc tilcp l lp real
syms logtilu logtilup logtilc logtilcp real
syms loguc logucp lognegtilul lognegtilulp real
syms logtillambda logtillambdap logtilw logtilwp real
syms logmden logmdenp logmnom logmnomp real
syms logtilq logtilqp logtilr logtilrp real
% The model is defined by:
% 1. A vector of state variables: x
% 2. A vector of control varaibles: y
% 3. Vectors of future states and controls: xp, yp
% 4. Equilibrium conditions : Ef=0
% 5. Evolution of state variables: xp=h(x)+eta_mat*epsilons.
% 6. The lower block of h(x) is defined by the symbolic vector Phi_fun.
%    This is the expected value of the future exogeneous state variables.
% 7. Policy function of control variables: y=g(x)
% 8. Symbolic parameters: symparams

syms logtilx logtilxp logtilxback logtilxbackp real
syms logtilkstarback logtilkstarbackp real
syms logtilk logtilkp real
syms logl loglp real
syms logtily logtilyp real
syms logqey logqeyp real

syms MUD RHOTHETA THETABAR SDV_THETA SDV_ZA ALPHA LAMBDA_A GAMMA NU PSI BETA DELTA PHI SCALEPARAM LOGTILUSS real


% Exogenous state variables

x2p=[dp;
    logthetap;
    zap];

% Expected value of future exogenous state variables as a function of
% current state. This is the lower block of h(x), which is known.

Phi_fun=[MUD;
    (1-RHOTHETA)*log(THETABAR)+RHOTHETA*logtheta;
    0];

% The matrix eta, as in Schmitt-Grohe and Uribe (2004).
eta_mat=[0,0,0;
         1,0,0;
         0,SDV_THETA,0;
         0,0,SDV_ZA];

% other variables that depend only on the exogenous state vars
loghata=LAMBDA_A+za-(1-ALPHA)*d*exp(logtheta);
loghatap=LAMBDA_A+zap-(1-ALPHA)*dp*exp(logthetap);
loghatmu=0; loghatmup=0; % assume no investment specific shock
loghatz=1/(1-ALPHA)*loghata+ALPHA/(1-ALPHA)*loghatmu;
loghatzp=1/(1-ALPHA)*loghatap+ALPHA/(1-ALPHA)*loghatmup;

% define auxiliary variable nl to bind l within [0,1]
syms nl nlp real
l=exp(nl)/(1+exp(nl));
lp=exp(nlp)/(1+exp(nlp));
logl=nl-log(1+exp(nl));
loglp=nlp-log(1+exp(nlp));


f0=-exp(auxvar1)+exp(logtilvp_tilvss+loghatzp)^(1-GAMMA); % auxiliary variable - VERY IMPORTANT to do it in log
f1=-exp(logtilv_tilvss)^(1-PSI)+exp(logtilu-LOGTILUSS)^(1-PSI)*SCALEPARAM+BETA*exp(auxvar1*(1-PSI)/(1-GAMMA));

f2=-logtilu+logtilc+NU*log(1-l);

f3=-loguc+NU*log(1-l);
f4=-lognegtilul+log(NU)+logtilc+(NU-1)*log(1-l); %lognegtilul is the log of negative tilul, because tilul itself is negative
f5=log(1-PSI)-PSI*logtilu+lognegtilul-logtillambda-logtilw; % note the use again of lognegtilul (and not logtilul)
f6=log(1-PSI)-PSI*logtilu+loguc-logtillambda;

f7=-logmnom+log(BETA)+logtillambda-PSI*loghatz+(PSI-GAMMA)*logtilv_tilvss+(PSI-GAMMA)*loghatz; %nominator of logm


f8=-logmden+logtillambda+(PSI-GAMMA)/(1-GAMMA)*auxvar1; %denominator of logmp

f9=exp(logmnomp-logmden-dp*exp(logthetap)-loghatmup)*(exp(logtilrp)+exp(logtilqp)*(1-DELTA))-exp(logtilq);

S=0; Sprime=0; Sp=0; Sprimep=0; % no adj costs

f10=-1+exp(logtilq)*(1-S-Sprime*exp(logtilx-logtilxback+loghatz))+exp(logmnomp-logmden+logtilqp)*Sprimep*exp(2*(logtilxp-logtilx+loghatzp));

f11=-logtilr+log(ALPHA)+loghata+loghatmu+(ALPHA-1)*(logtilkstarback-d*exp(logtheta))+(1-ALPHA)*logl;
f12=-logtilw+log(1-ALPHA)+loghata-loghatz+(ALPHA)*(logtilkstarback-d*exp(logtheta))-ALPHA*logl;

f13=-log(exp(logtily)+PHI)+loghata-loghatz+(ALPHA)*(logtilkstarback-d*exp(logtheta))+(1-ALPHA)*logl;

f14=-exp(logtily)+exp(logtilc)+exp(logtilx);

f15=exp(logtilkstarbackp)-(1-DELTA)*exp(logtilk)-(1-S)*exp(logtilx);
f16=-logtilk+logtilkstarback-d*exp(logtheta)-loghatz-loghatmu;

syms tildiv tildivp logtilqe logtilqep real

f17=-exp(logtilqe)+exp(logmnomp-logmden+loghatzp)*(tildivp+exp(logtilqep));
f17a=-tildiv+exp(logtily)-exp(logtilw+logl)-exp(logtilx); % dividends equal total output excluding labour income and investments


syms logqf logqfp real
f18=-exp(logqf)+exp(logmnomp-logmden);


f=[f0;f1;f2;f3;f4;f5;f6;f7;f8;f9;f10;f11;f12;f13;f14;f15;f16;f17;f17a;f18];
f=simplify(f);

f=subs(f,[hatz,tilu,tilc,l],exp([loghatz,logtilu,logtilc,logl]));
f=subs(f,[hatzp,tilup,tilcp,lp],exp([loghatzp,logtilup,logtilcp,loglp]));

x=[logtilkstarback;
    d;
    logtheta;
    za];

xp=[logtilkstarbackp;
    dp;
    logthetap;
    zap];

y=[auxvar1,logtilv_tilvss,logtilu,logtilc,nl,logtillambda,logtilw,loguc,lognegtilul,logmnom,logmden,logtilr,logtilq,logtilx,logtilk,logtily,logtilqe,logqf,tildiv];
yp=[auxvar1p,logtilvp_tilvss,logtilup,logtilcp,nlp,logtillambdap,logtilwp,logucp,lognegtilulp,logmnomp,logmdenp,logtilrp,logtilqp,logtilxp,logtilkp,logtilyp,logtilqep,logqfp,tildivp];

symparams=[MUD RHOTHETA THETABAR SDV_THETA SDV_ZA ALPHA LAMBDA_A GAMMA NU PSI BETA DELTA PHI SCALEPARAM LOGTILUSS];
