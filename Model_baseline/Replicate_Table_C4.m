% Choose here which modeling assumption modify
do_CRRA             = 1;
do_omega_high       = 0;
do__omega_low       = 0;
do_TR_inertia       = 0;
do_high_foreign_ela = 0;
do_no_disasters_tfp = 0;


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
welfare_sit=tilv_mean
welfare_cyclical_sit=exp(logtilv_tilvss_mean);
results_vec=[tily_std inflation_std inflationagg_std welfare_sit];

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
results_vec_peg=[tily_std inflation_std inflationagg_std welfare_peg];


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
results_vec_tr=[tily_std inflation_std inflationagg_std welfare_tr];

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





