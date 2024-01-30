% Choose here
do_disaster=1;

% Preferences
NU=1.1;
GAMMA=GAMMA_iii;
hatPSI=.5; 
PSI=1-(1-hatPSI)/(1+NU); % Epstein-Zin 
BETA=0.9834;

% Investment adjustment costs
KAPPA=12; 


% Technology
LAMBDA_A=0.0035;
LAMBDA_MU=0; 
ALPHA=0.32; 
DELTA=.025; 
PHI=0;

% Standard deviations business cycle shocks
SDV_ZA=SDV_ZA_iii;
SDV_ZMU=0; %Shock to growth rate of investment (not activated in our model)
SDV_M=0; %Monetary policy shock (not activated in our model)
RHOXI=0; %Preference shock (not activated in our model)
SDV_XI=0; % Standard deviation of preference shock (not activated in our model)

% Price stickiness and Taylor rule
THETA_P=THETA_P_iii;
CHI= CHI_iii;
EPSILON=EPSILON_iii;
GAMMA_PI=GAMMA_PI_iii;
GAMMA_R= GAMMA_R_iii;
GAMMA_Y= GAMMA_Y_iii;
GAMMA_D=0;
PISS=PISS_iii;
GAMMA_E=GAMMA_E_iii;

% Disasters
if do_disaster==1
prob_disaster=prob_disaster_iii; 
THETABAR=THETABAR_iii;
else
prob_disaster=1-(1-.000000000001)^.25;
THETABAR=-log(1-.00000000000001);  
end


MUD=prob_disaster; 
SDV_THETA=SDV_THETA_iii;
RHOTHETA=RHOTHETA_iii; 
DUMMYTFP=DUMMYTFP_iii;
RHOAT=0.71;
logAT_ss=0;
OOMEGA=OOMEGA_iii; 
ZZETA=ZZETA_iii;
% Welfare
LOSS=0;


RHOSOEPISTAR=RHOSOEPISTAR_iii;
RHOSOERSTAR=RHOSOERSTAR_iii;
RHOSOEYSTAR=RHOSOEYSTAR_iii;
SDV_SOEPISTAR=SDV_SOEPISTAR_iii;
SDV_SOERSTAR=SDV_SOERSTAR_iii;
SDV_SOEYSTAR=SDV_SOEYSTAR_iii;
PISTARSS=PISTARSS_iii;
SOEPSIZERO=1.0084;
SOEPSIONE=0.001;
SOECHIC=SOECHIC_iii;
SOEVARPHISTAR=1; 
SOECHICSTAR=SOECHICSTAR_iii;
EXPY=EXPY_iii; 
IMPY=IMPY_iii; 

DISYSTAR=DISYSTAR_iii;

% From steady state
SteadyState; 
LAMBDA_X=hatzss;
RSS=PISS/exp(logmnomss-logmdenss);
LAMBDA_Y=loghatzss;
xiss=0;

% Steady state risk-free rate
Rf_ss=exp(-logqfss);
Rf_ss_Ann=100*(Rf_ss^4-1);
RSS_Ann=100*(RSS^4-1);
PISS_Ann=100*(PISS^4-1);
RSS_Ann_real=RSS_Ann-PISS_Ann;


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
