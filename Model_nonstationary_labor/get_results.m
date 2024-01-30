% This file replicates all the results reported in Fernandez-Villaverde and
% Levintal (2017): "Solution Methods for Models with Rare Disasters".

% do_all_solutions=1; % do all solutions - this option may take about 30 hours
do_all_solutions=0; % do only cheap solutions - this option takes about 3 hours.

start_tic=tic;

save('options','do_all_solutions','start_tic');

% clear
clc

% preliminary step to prepare codes and data
% prepare_all_models;

% solve the model for all parameterizations (including the robustness tests)
do_solve; 

% solve at the stochastic steady state
% do_solve_stochastic_ss;

% compute accuracy measures and simulation moments for all parameterizations. 
accuracy_and_simulation; 
% make_Figure_II_SOE;
% compute accuracy measures for Taylor projection solutions that were obtained at the
% stochastic steady state.
% accuracy_stochastic_ss;

% Robustness test: the ergodic set is approximated by a Smolyak solution of
% level 3 (instead of Taylor projection of order 3) for T=10,000 periods.
% accuracy_robustness;

% Tables 2-12, 18-25
% present the results (including robustness tests)
% present_tables;

% Table 26 
% present results for solutions at the stochastic steady state
% present_tables_stochastic_ss;

% Tables 14-15 (to get Tables 16-17 increase T to 100,000 in accuracy_robustness.m).
% present results for robustness test - ergodic set is approximated by a
% Smolyak solution.
% present_tables_robustness;

% Table 13
% present sparsity
% sparsity;

% Figures
load('options')
if do_all_solutions==1
    make_Figure_I;
    make_Figure_II;
    make_Figure_III;
    make_Figure_IV;
end

load('options');

time=toc(start_tic);
save('time','time');

% clear all
