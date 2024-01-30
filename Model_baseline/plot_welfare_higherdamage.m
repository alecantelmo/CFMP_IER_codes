% Run simulation?
run_simulations =1;

if run_simulations==1
% prepare_all_models

% 1. Response to inflation

%Baseline parameter values
baseline_calibration
THETABAR_iii      =-log(1-0.0516);

% Define parameter vector
parameter_vector = 1.05:0.025:2;

[rrr,ccc] = size(parameter_vector);

% Welfare vector
welf_vector =zeros(1,ccc);


for hhh = 1:1:ccc

    GAMMA_PI_iii =parameter_vector(1,hhh);
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
    
    % Compute welfare
    welf_vector(1,hhh)=tilv_mean;
end


parameter_vector_GAMMA_PI=parameter_vector;
welf_vector_GAMMA_PI_higherdamage=welf_vector;
save('welfare_GAMMA_PI_higherdamage.mat', 'parameter_vector_GAMMA_PI', 'welf_vector_GAMMA_PI_higherdamage')

% 2. Response to output

%Baseline parameter values
baseline_calibration
THETABAR_iii      =-log(1-0.0516);

% Define parameter vector
parameter_vector = 0:0.025:0.5;

[rrr,ccc] = size(parameter_vector);

% Welfare vector
welf_vector =zeros(1,ccc);


for hhh = 1:1:ccc

    GAMMA_Y_iii =parameter_vector(1,hhh);
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
    
    % Compute welfare
    welf_vector(1,hhh)=tilv_mean;
     
end


parameter_vector_GAMMA_Y=parameter_vector;
welf_vector_GAMMA_Y_higherdamage=welf_vector;
save('welfare_GAMMA_Y_higherdamage.mat', 'parameter_vector_GAMMA_Y', 'welf_vector_GAMMA_Y_higherdamage')

% 3. Response to the exchange rate

%Baseline parameter values
baseline_calibration
THETABAR_iii      =-log(1-0.0516);

% Define parameter vector
parameter_vector =  0:0.025:0.5;

[rrr,ccc] = size(parameter_vector);

% Welfare vector
welf_vector =zeros(1,ccc);


for hhh = 1:1:ccc

    GAMMA_E_iii =parameter_vector(1,hhh);
    do_all_solutions=0;
    do_solve; 
    accuracy_and_simulation;
    present_tables;
    
    % Compute welfare
    welf_vector(1,hhh)=tilv_mean;
     
end


parameter_vector_GAMMA_E=parameter_vector;
welf_vector_GAMMA_E_higherdamage=welf_vector;
save('welfare_GAMMA_E_higherdamage.mat', 'parameter_vector_GAMMA_E', 'welf_vector_GAMMA_E_higherdamage')


end



