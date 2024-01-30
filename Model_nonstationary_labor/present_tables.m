% This file presents the results

% clear,
% clc, 
close all
load('models')
% models=models(2); % take a specific model
main_folder=pwd;

all_versions=[1]; % do disaster parameterizaion
% all_versions=[0]; % do no-disaster parameterization
% all_versions=[0,1]; % do both
% all_versions=[0,1,2,3,4]; % do both and robustness tests

% all solutions:
% names={'pert1','pert2','pert3','pert4','pert5','tp1','tp2','tp3','smol1','smol2','smol3'};
names={'tp3'};

% only cheap solutions

if exist('options.mat','file')~=0
    load('options');
else
    do_all_solutions=1;
end

if do_all_solutions==0
%     names={'pert1','pert2','pert3','tp1','tp2','tp3','smol1','smol2'};
%     names={'pert1','pert2','pert3','tp1','tp2','tp3'};
    names={'tp3'};

end

for veri=all_versions

    version=['ver' num2str(veri)];


    n_models=length(models);
    n_methods=length(names);
    smol3_grid_expansion=zeros(n_models,1);

    maxEE=zeros(n_models,n_methods);
    meanEE=zeros(n_models,n_methods);
    runtime=zeros(n_models,n_methods);
    RoE_mean=zeros(n_models,n_methods); 
    RoE_std=zeros(n_models,n_methods); 
    Rf_mean=zeros(n_models,n_methods); 
    Rf_std=zeros(n_models,n_methods); 
    tily_mean=zeros(n_models,n_methods);
    tilc_mean=zeros(n_models,n_methods);
    tilx_mean=zeros(n_models,n_methods);
    inflation_mean=zeros(n_models,n_methods);
    policyrate_mean=zeros(n_models,n_methods);
    consumption_fall=zeros(n_models,n_methods);
    Rfnominal_mean=zeros(n_models,n_methods);
     
    for modeli=1:length(models)

        load(['performance/' version '/' models{modeli} '/accuracy_and_runtime'],'pert*','tp*','smol*','shocks','T')

        % Euler Errors - max and mean
        t_start=100; t_end=T; % take a sample from t_start to t_end

        for j=1:n_methods
           eval(['solution=' names{j} '_r;'])
           maxEE(modeli,j)=max(log10(max(abs(solution(:,t_start:t_end)))));
           if ~isreal(maxEE(modeli,j))
               maxEE(modeli,j)=Inf;
           end
           meanEE(modeli,j)=mean(log10(max(abs(solution(:,t_start:t_end))))); % mean across simulation points of max error across equations.
           if ~isreal(meanEE(modeli,j))
               meanEE(modeli,j)=Inf;
           end
        end

        % runtime
        for i=1:length(names)
            eval(['runtime(modeli,i)=' names{i} '_time;']);
        end

        % Simulation moments

        load([main_folder '/performance/' version '/' models{modeli} '/simulation'],'results_*','x_tp*','x_pert*','x_smol*','nu_*')

        for i=1:length(names)
%             load([main_folder '/files_for_smolyak/' models{modeli} '/order1/model'],'subsvars','y','x')
            load([main_folder '/files_for_TaylorProjection/' models{modeli} '/order2/model'],'subsvars','y','x')
            eval(['results=results_' names{i} '(:,t_start:t_end);'])
            eval(['x_simul=x_' names{i} '(:,t_start:t_end);'])
            eval(['nu=nu_' names{i} '(:,t_start:t_end);'])

            tildiv=nu(logical(subsvars==sym('tildiv')),:);
            loghatz=nu(logical(subsvars==sym('loghatz')),:);
            logtilqe=results(logical(y==sym('logtilqe')),:);
            logqf=results(logical(y==sym('logqf')),:);
            logtheta=x_simul(logical(x==sym('logtheta')),:);
            logtilxback=x_simul(logical(x==sym('logtilxback')),:);
            
            tily=nu(logical(subsvars==sym('tily')),:);
            tilc=nu(logical(subsvars==sym('tilc')),:);
            tilx=nu(logical(subsvars==sym('tilx')),:);
            logtilk=nu(logical(subsvars==sym('logtilk')),:);
            tilk=exp(logtilk);
            
            labor=(nu(logical(subsvars==sym('l')),:));
            logtilv_tilvss=(nu(logical(subsvars==sym('logtilv_tilvss')),:));
            
            inflation=100*nu(logical(subsvars==sym('logpi')),:);
            grossinfl=exp(inflation);
            Agrossinflation=(grossinfl.^4);
            Ainflation=100*log(Agrossinflation);
            
            inflationagg=nu(logical(subsvars==sym('logpiagg')),:);
            grossinflagg=exp(inflationagg);
            Agrossinflationagg=(grossinflagg.^4);
            Ainflationagg=100*log(Agrossinflationagg);
            
            policyrate=nu(logical(subsvars==sym('logR')),:);
%             policyrate=x_simul(logical(x==sym('logRback')),:);
            policyrate=exp(policyrate);
            policyrate=100*(policyrate.^4-1);%annualized
            
            logtily=nu(logical(subsvars==sym('logtily')),:);
            logtilc=nu(logical(subsvars==sym('logtilc')),:);
            loghatz=nu(logical(subsvars==sym('loghatz')),:);
            dlogy=logtily(2:end)-logtily(1:end-1);%+loghatz(2:end);
            Growth=exp(100*dlogy)-1;
            dlogc=logtilc(2:end)-logtilc(1:end-1)+loghatz(2:end);
            CGrowth=exp(400*dlogc)-1;
            
            
            RoE=exp(loghatz(2:end)).*(tildiv(2:end)+exp(logtilqe(2:end))).*exp(-logtilqe(1:end-1));
            RoE=100*(RoE.^4-1); %annualized
            Rf=exp(-logqf);
            Rf=100*(Rf.^4-1);%annualized
            
            Rfnominal=exp(-logqf+inflation);
            Rfnominal=100*(Rfnominal.^4-1);%annualized
            
            RoE_mean(modeli,i)=mean(RoE);
            if ~isreal(RoE_mean(modeli,i))
                RoE_mean(modeli,i)=Inf;
            end
            RoE_std(modeli,i)=std(RoE);
            Rf_mean(modeli,i)=mean(Rf);
            if ~isreal(Rf_mean(modeli,i))
                Rf_mean(modeli,i)=Inf;
            end
            Rf_std(modeli,i)=std(Rf);
            
            logtilw=results(logical(y==sym('logtilw')),:);
            tilw=exp(logtilw);

            
            logtilwelf=results(logical(y==sym('logtilwelf')),:);
            tilwelfare=exp(logtilwelf);
            tilwelfare_mean(modeli,i)=mean(tilwelfare);
            loghatz=nu(logical(subsvars==sym('loghatz')),:);
            loghata=nu(logical(subsvars==sym('loghata')),:);
            logz=cumsum(loghatz);            
            welfare=exp(logtilwelf+logz);
            welfare_mean(modeli,i)=mean(welfare);
            
            tily_mean(modeli,i)=mean(tily);
            tilc_mean(modeli,i)=mean(tilc);
            tilx_mean(modeli,i)=mean(tilx);
            tilk_mean(modeli,i)=mean(tilk);
            inflation_mean(modeli,i)=mean(Ainflation);
            inflationagg_mean(modeli,i)=mean(Ainflationagg);
            policyrate_mean(modeli,i)=mean(policyrate);
            Rfnominal_mean(modeli,i)=mean(Rfnominal);
            labor_mean(modeli,i)=mean(labor);
            logtilv_tilvss_mean(modeli,i)=mean(logtilv_tilvss);
            Growth_mean(modeli,i)=mean(Growth);
            tilw_mean(modeli,i)=mean(tilw);
            
            tily_std(modeli,i)=std(tily);
            tilc_std(modeli,i)=std(tilc);
            tilx_std(modeli,i)=std(tilx);
            tilk_std(modeli,i)=std(tilk);
            inflation_std(modeli,i)=std(inflation);
            inflationagg_std(modeli,i)=std(inflationagg);
            labor_std(modeli,i)=std(labor);
            Growth_std(modeli,i)=std(Growth);
            policyrate_std(modeli,i)=std(policyrate);
            tilw_std(modeli,i)=std(tilw);
            CGrowth_std(modeli,i)=std(CGrowth);
            
           tilv=exp(nu(logical(subsvars==sym('logtilv')),:));
           tilv_mean(modeli,i)=mean(tilv);
        end
        
        save(['present_' version '_' models{modeli}])
    end
    % present tables
    if veri==0
        disp('no-disaster parametrization')
        disp(names)
        meanEE
        disp(names)
        maxEE
    elseif veri==1
        disp('disaster parametrization')
%         disp(names)
%         meanEE
%         disp(names)
%         maxEE
%         disp(names)
%         Rf_mean
%         disp(names)
%         RoE_mean
%         disp(names)
%         tilx_mean
%         disp(names)
%         tilk_mean
%         disp(names)
%         tilx_std
%         disp(names)
%         inflation_mean
%         disp(names)
%         tilk_std
%         disp(names)
%         runtime
% disp(names)
% welfare_mean
% disp(names)
% tilwelfare_mean

%         vector_means=[tily_mean tilc_mean tilx_mean Rfnominal_mean policyrate_mean inflation_mean Rf_mean]'
%         vector_means=[inflation_mean policyrate_mean Rf_mean tily_mean tilc_mean tilx_mean]'
%         vector_std=[inflation_std policyrate_std Rf_std tily_std tilc_std tilx_std]'
%        
%           vector_std=[inflation_std tily_std tilc_std labor_std policyrate_std tilw_std CGrowth_std Growth_std]'
% [inflation_std  Growth_std]'

% tily_annual = mean(reshape(tily(1:900),4,[]));
% ar_tily_annual = autocorr(tily_annual);
% ar_tily_annual_one_lag = ar_tily_annual(2)
% 
% std_tily = std(tily_annual)

    else
        if veri==2
            disp('Robustness test: Gamma = 5');
        elseif veri==3
            disp('Disaster probability = 0.0086');
        elseif veri==4
            disp('Sigma_theta = 0.05');
        end
%         disp(names)
%         meanEE
%         disp(names)
%         maxEE
%         disp(names)
%         Rf_mean
%         disp(names)
%         RoE_mean        
        
        
    end
end


