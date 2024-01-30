home7=pwd;

cd ../;
cd RBC_EZ_adjCost_Calvo_Taylor2_shock2

SteadyState;

xiss=0;

Rf_ss=exp(-logqfss);
Rf_ss_Ann=100*(Rf_ss^4-1);

cd(home7);




