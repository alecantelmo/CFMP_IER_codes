% preliminary step to prepare codes and data
prepare_all_models;


%Baseline
baseline_calibration
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
    welfare_inftarg=tilv_mean;
    results_vec_fit=[tily_std inflation_std inflationagg_std welfare_inftarg];
    

%NGDP targeting
baseline_calibration
GAMMA_Y_iii=10;
GAMMA_PI_iii=10;
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
welfare_ngt=tilv_mean;
CE_loss_ngt=100*(welfare_ngt/welfare_inftarg-1);
results_vec=[tily_std inflation_std inflationagg_std welfare_sit CE_loss_ngt];



disp('Inflation targeting')
[welfare_inftarg ]
disp('Nominal GDP targeting')
[welfare_ngt ]





