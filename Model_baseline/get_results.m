do_all_solutions=0;

start_tic=tic;

save('options','do_all_solutions','start_tic');

clc

% preliminary step to prepare codes and data
prepare_all_models;

% solve the model 
do_solve; 


% compute accuracy measures and simulation moments for all parameterizations. 
accuracy_and_simulation; 

time=toc(start_tic);
save('time','time');


