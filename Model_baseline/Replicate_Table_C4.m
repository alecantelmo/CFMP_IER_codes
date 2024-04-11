% Choose here which modeling assumption modify
do_CRRA             = 1;
do_omega_high       = 0;
do__omega_low       = 0;
do_TR_inertia       = 0;
do_high_foreign_ela = 0;
do_no_disasters_tfp = 0;

% preliminary step to prepare codes and data
prepare_all_models;


%Baseline
baseline_calibration
    if      do_CRRA == 1
            GAMMA_iii=0.5;
    elseif do_omega_high ==1
            OOMEGA_iii=0.75;
    elseif do__omega_low ==1
            OOMEGA_iii=0.25;
    elseif do_TR_inertia ==1
            GAMMA_R_iii=0.80;
   elseif do_high_foreign_ela ==1
            SOECHIC_iii=1.2;
   elseif do_no_disasters_tfp ==1  
            DUMMYTFP_iii=0;
    end 
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
    welfare_inftarg=tilv_mean;
    results_vec_fit=[tily_std inflation_std inflationagg_std welfare_inftarg];
    
% SIT
baseline_calibration
    if      do_CRRA == 1
            GAMMA_iii=0.5;
    elseif do_omega_high ==1
            OOMEGA_iii=0.75;
    elseif do__omega_low ==1
            OOMEGA_iii=0.25;
    elseif do_TR_inertia ==1
            GAMMA_R_iii=0.80;
   elseif do_high_foreign_ela ==1
            SOECHIC_iii=1.2;
   elseif do_no_disasters_tfp ==1  
            DUMMYTFP_iii=0;
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
    if      do_CRRA == 1
            GAMMA_iii=0.5;
    elseif do_omega_high ==1
            OOMEGA_iii=0.75;
    elseif do__omega_low ==1
            OOMEGA_iii=0.25;
    elseif do_TR_inertia ==1
            GAMMA_R_iii=0.80;
   elseif do_high_foreign_ela ==1
            SOECHIC_iii=1.2;
   elseif do_no_disasters_tfp ==1  
            DUMMYTFP_iii=0;
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
    if      do_CRRA == 1
            GAMMA_iii=0.5;
    elseif do_omega_high ==1
            OOMEGA_iii=0.75;
    elseif do__omega_low ==1
            OOMEGA_iii=0.25;
    elseif do_TR_inertia ==1
            GAMMA_R_iii=0.80;
   elseif do_high_foreign_ela ==1
            SOECHIC_iii=1.2;
   elseif do_no_disasters_tfp ==1  
            DUMMYTFP_iii=0;
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
    if      do_CRRA == 1
            GAMMA_iii=0.5;
    elseif do_omega_high ==1
            OOMEGA_iii=0.75;
    elseif do__omega_low ==1
            OOMEGA_iii=0.25;
    elseif do_TR_inertia ==1
            GAMMA_R_iii=0.80;
   elseif do_high_foreign_ela ==1
            SOECHIC_iii=1.2;
   elseif do_no_disasters_tfp ==1  
            DUMMYTFP_iii=0;
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





