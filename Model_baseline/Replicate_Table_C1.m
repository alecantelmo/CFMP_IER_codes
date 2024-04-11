% Choose here which shock exclude
do_no_foreign_inflation = 1;
do_no_foreign_intrate   = 0;
do_no_foreign_demand    = 0;
do_no_tfp               = 0;

% preliminary step to prepare codes and data
prepare_all_models;

%Baseline
baseline_calibration
    if      do_no_foreign_inflation == 1
            SDV_SOEPISTAR_iii=0;
    elseif do_no_foreign_intrate ==1
            SDV_SOERSTAR_iii=0;
    elseif do_no_foreign_demand ==1
            SDV_SOEYSTAR_iii=0;
    elseif do_no_tfp ==1
            SDV_ZA_iii=0;
    end 
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
    welfare_inftarg=tilv_mean;
    results_vec_fit=[tily_std inflation_std inflationagg_std welfare_inftarg];
    
% SIT
baseline_calibration
    if      do_no_foreign_inflation == 1
            SDV_SOEPISTAR_iii=0;
    elseif do_no_foreign_intrate ==1
            SDV_SOERSTAR_iii=0;
    elseif do_no_foreign_demand ==1
            SDV_SOEYSTAR_iii=0;
    elseif do_no_tfp ==1
            SDV_ZA_iii=0;
    end 
GAMMA_PI_iii=10;
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
welfare_sit=tilv_mean;
CE_loss_sit=100*(welfare_sit/welfare_inftarg-1);
results_vec=[tily_std inflation_std inflationagg_std welfare_sit CE_loss_sit];

%Hard peg
baseline_calibration
    if      do_no_foreign_inflation == 1
            SDV_SOEPISTAR_iii=0;
    elseif do_no_foreign_intrate ==1
            SDV_SOERSTAR_iii=0;
    elseif do_no_foreign_demand ==1
            SDV_SOEYSTAR_iii=0;
    elseif do_no_tfp ==1
            SDV_ZA_iii=0;
    end 
GAMMA_PI_iii=0;
GAMMA_E_iii=30;
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
welfare_peg=tilv_mean;
CE_loss_peg=100*(welfare_peg/welfare_inftarg-1);
results_vec_peg=[tily_std inflation_std inflationagg_std welfare_peg CE_loss_peg];


%Taylor rule
baseline_calibration
    if      do_no_foreign_inflation == 1
            SDV_SOEPISTAR_iii=0;
    elseif do_no_foreign_intrate ==1
            SDV_SOERSTAR_iii=0;
    elseif do_no_foreign_demand ==1
            SDV_SOEYSTAR_iii=0;
    elseif do_no_tfp ==1
            SDV_ZA_iii=0;
    end 
GAMMA_Y_iii=0.5;
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
welfare_tr=tilv_mean;
CE_loss_tr=100*(welfare_tr/welfare_inftarg-1);
results_vec_tr=[tily_std inflation_std inflationagg_std welfare_tr CE_loss_tr];

%ER augmented Taylor rule
baseline_calibration
    if      do_no_foreign_inflation == 1
            SDV_SOEPISTAR_iii=0;
    elseif do_no_foreign_intrate ==1
            SDV_SOERSTAR_iii=0;
    elseif do_no_foreign_demand ==1
            SDV_SOEYSTAR_iii=0;
    elseif do_no_tfp ==1
            SDV_ZA_iii=0;
    end 
GAMMA_Y_iii=0.5;
GAMMA_E_iii=0.5;
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
welfare_atr=tilv_mean;
CE_loss_atr=100*(welfare_atr/welfare_inftarg-1);
results_vec_atr=[tily_std inflation_std inflationagg_std welfare_atr CE_loss_atr];




disp('CE gain w.r.t. FIT')

disp('Strict Inflation targeting')
[CE_loss_sit]
disp('Hard peg')
[CE_loss_peg ]
disp('Taylor rule')
[CE_loss_tr ]
disp('Augmented Taylor rule')
[CE_loss_atr ]




