% Parameter values
doEA=1; %=1 EA, =0 USA (Fernandez-Villaverde and Levintal)

if doEA==1

NU=1.55;%1.93; % Leisure preference
GAMMA=3.8;  % Risk aversion
hatPSI=2;%.5; % inverse IES
PSI=1-(1-hatPSI)/(1+NU); % Epstein-Zin
% PSI=GAMMA; hatPSI=1-(1-PSI)*(1+NU); % Expected Utility Assumption

% From Fernandez-Villaverde et al (Journal of Econometrics 2015)
LAMBDA_A=0.005;%.0028;
LAMBDA_MU=0;
BETA=.9984 ; %set to .99643 to get ann. risk-free rate of 1.48% in the stoch ss. Set it to .9977 to get the ann. risk-free rate of 1% in the stoch ss (BArroetall).  Set it to .99779 to get the ann. risk-free rate of 0.91% in the stoch ss (Gerali-Neri average 2001-2007).
            % set to .9707 with gamma=10 to get ann. risk free rate 1.48%
            % set it to .98543 with gamma=7.6 to get ann. risk free rate 1.48%
ALPHA=.30;%0.21;
DELTA=.025;
PHI=0;


else
    
NU=2.33; % Leisure preference
GAMMA=3.8;  % Risk aversion
hatPSI=.5; % inverse IES
PSI=1-(1-hatPSI)/(1+NU); % Epstein-Zin
% PSI=GAMMA; hatPSI=1-(1-PSI)*(1+NU); % Expected Utility Assumption

% From Fernandez-Villaverde et al (Journal of Econometrics 2015)
LAMBDA_A=.0028;%0.005;%
LAMBDA_MU=0;
BETA=.99; 
ALPHA=0.21;
DELTA=.025;
PHI=0;


end

SDV_ZA=0.0064/10;%.01 ; % from Gourio (2012) 

% Disaster Probability: from the Working paper version of Gourio (2010),
% which is based on Barro (2006)
prob_disaster=1-(1-.01)^.25; % disaster probability (quareterly)  1-(1-.017)^.25

MUD=prob_disaster;
THETABAR=-log(1-.157); % mean disaster impact -log(1-.4) .3855
SDV_THETA=0.025; % standrad deviation of disaster impact.
RHOTHETA=0.9; % persistence of disaster impact


% Define eta as in Schmitt-Grohe and Uribe (2004). 
eta_mat=[0,0,0;
         1,0,0;
         0,SDV_THETA,0;
         0,0,SDV_ZA];

