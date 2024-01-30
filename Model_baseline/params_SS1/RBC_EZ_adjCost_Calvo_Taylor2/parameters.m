home4=pwd;

cd ../;
cd RBC_EZ_adjCost_Calvo_Taylor1

parameters;

GAMMA_R=0.85;%0.5;%0.62;%0.9;% smoothing parameter in the Taylor rule

eta_mat=[0,0,0;
         0,0,0;
         0,0,0;
         0,0,0;
         0,0,0;
         0,0,0;
         1,0,0;
         0,SDV_THETA,0;
         0,0,SDV_ZA];


cd(home4);