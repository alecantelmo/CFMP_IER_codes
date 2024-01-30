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
results_vec_ngt=[tily_std inflation_std inflationagg_std welfare_ngt];



disp('Inflation targeting')
[welfare_inftarg ]
disp('Nominal GDP targeting')
[welfare_ngt ]





