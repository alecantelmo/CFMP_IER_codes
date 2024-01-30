home2=pwd;

cd ../;
cd RBC_EZ_adjCost

parameters;


do_sticky_prices=1;


if do_sticky_prices==1
    THETA_P=0.905;%0.8139;  %from Fernandez-Vaillaverde et al (2015)
    CHI=0.472;%;0.6186 %from Fernandez-Vaillaverde et al (2015)
    EPSILON=6;%10; %from Fernandez-Vaillaverde et al (2015)
    GAMMA_PI=1.69;%1.3;%1.9; % Inflation coefficient in Taylor rule.

else
    THETA_P=0;  %from Fernandez-Vaillaverde et al (2015)
    CHI=0; %from Fernandez-Vaillaverde et al (2015)
    EPSILON=6; %from Fernandez-Vaillaverde et al (2015)
    GAMMA_PI=20;%1.69;%1.3;%1.9; % Inflation coefficient in Taylor rule.

end



PISS=1.019^0.25; % Inflation target of 2 percent annually

SteadyState;
RSS=PISS/exp(logmnomss-logmdenss);

eta_mat=[0,0,0;
         0,0,0;
         0,0,0;
         0,0,0;
         1,0,0;
         0,SDV_THETA,0;
         0,0,SDV_ZA];


cd(home2);