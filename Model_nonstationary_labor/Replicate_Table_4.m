%Baseline
baseline_calibration
ZZETA_iii=0.25;
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
    welfare_inftarg=tilv_mean;
    results_vec_fit=[tily_std inflation_std inflationagg_std welfare_inftarg];
    
% SIT
baseline_calibration
ZZETA_iii=0.25;
GAMMA_PI_iii=10;
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
welfare_sit=tilv_mean;
welfare_cyclical_sit=exp(logtilv_tilvss_mean);
results_vec=[tily_std inflation_std inflationagg_std welfare_sit];

%Hard peg
baseline_calibration
ZZETA_iii=0.25;
GAMMA_PI_iii=0;
GAMMA_E_iii=30;
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
welfare_peg=tilv_mean;
results_vec_peg=[tily_std inflation_std inflationagg_std welfare_peg];


%Taylor rule
baseline_calibration
ZZETA_iii=0.25;
GAMMA_Y_iii=0.5;
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
welfare_tr=tilv_mean;
results_vec_tr=[tily_std inflation_std inflationagg_std welfare_tr];

%ER augmented Taylor rule
baseline_calibration
ZZETA_iii=0.25;
GAMMA_Y_iii=0.5;
GAMMA_E_iii=0.5;
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
welfare_atr=tilv_mean;
results_vec_atr=[tily_std inflation_std inflationagg_std welfare_atr];




disp('Inflation targeting')
[welfare_inftarg ]
disp('Strict Inflation targeting')
[welfare_inftarg ]
disp('Hard peg')
[welfare_peg ]
disp('Taylor rule')
[welfare_tr ]
disp('Augmented Taylor rule')
[welfare_atr ]





