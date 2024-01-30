% This file produces impulse response functions of a disaster shock.

% clear,clc, close all
load('models') %,models=models(1);
main_folder=pwd;
addpath(main_folder)

all_versions={'ver1'}; % choose disaster parameterization
% models=models(2); % take model 8

for veri=1:length(all_versions);
    version=all_versions{veri};
    load(version)

    for modeli=1:length(models)
        % Take the model equations for accuracy tests from this path:
        addpath([main_folder '/files_for_TaylorProjection/' models{modeli} '/order3/files']);

        load([main_folder '/all_models/' models{modeli} '/TaylorProjection/choose']);

        % load some parameters
        load([main_folder '/' pert_folder '/' models{modeli} '/order3/perturbation'],'eta_mat','nyss','nxss','params','P1','nep1','n_e','prob_disaster','MUD')
        nep=nep1;P=P1;
        load([main_folder '/files_for_TaylorProjection/' models{modeli} '/order3/model'],'model','y','x','subsvars','symparams');
        model0=model;

        n_y=model0.n_y;
        n_x1=model0.n_x1;
        n_x=model0.n_x;
        n_f=model0.n_f;
        for k=2:5
            [U,W]=create_UW(n_x,k);
            model.U{k}=U;
            model.W{k}=W;
        end

        c0=nxss;
        eta=eta_mat;
        
        % load solutions
        load([main_folder '/performance/' version '/' models{modeli} '/accuracy_and_runtime'],'pert*','tp*','smol*','shocks','T')

        %Impulse response functions
        impulse=1;

        if impulse==1
            % define a disaster shock in period 100 and simulate to period 120
            ir_shocks=[zeros(size(shocks,1),120)];
            ir_shocks(1,:)=-MUD;
            ir_shocks(1,100)=1-MUD;

            % Taylor projection
            poly.type='power';
            
            coeffs=tp1(:); order=1;
            [ results,nu ] = fun_simulation( nxss,ir_shocks,coeffs,c0,order,n_y,n_x,n_f,model,params,eta );
            ir_tp1=results;
            nu_tp1=nu;
            tp1_EE=eval_eqs(coeffs,results(n_y+1:end,100),model,params,eta,c0,nep,P,order,poly);

            coeffs=tp2(:); order=2;
            [ results,nu ] = fun_simulation( nxss,ir_shocks,coeffs,c0,order,n_y,n_x,n_f,model,params,eta );
            ir_tp2=results;
            nu_tp2=nu;
            tp2_EE=eval_eqs(coeffs,results(n_y+1:end,100),model,params,eta,c0,nep,P,order,poly);

            coeffs=tp3(:); order=3;
            [ results,nu ] = fun_simulation( nxss,ir_shocks,coeffs,c0,order,n_y,n_x,n_f,model,params,eta );
            ir_tp3=results;
            nu_tp3=nu;
            tp3_EE=eval_eqs(coeffs,results(n_y+1:end,100),model,params,eta,c0,nep,P,order,poly);


        % perturbation
            coeffs=pert1(:); order=1;
            [ results,nu ] = fun_simulation( nxss,ir_shocks,coeffs,c0,order,n_y,n_x,n_f,model,params,eta );
            ir_pert1=results;
            nu_pert1=nu;
            pert1_EE=eval_eqs(coeffs,results(n_y+1:end,100),model,params,eta,c0,nep,P,order,poly);

            coeffs=pert2(:); order=2;
            [ results,nu ] = fun_simulation( nxss,ir_shocks,coeffs,c0,order,n_y,n_x,n_f,model,params,eta );
            ir_pert2=results;
            nu_pert2=nu;
            pert2_EE=eval_eqs(coeffs,results(n_y+1:end,100),model,params,eta,c0,nep,P,order,poly);

            coeffs=pert3(:); order=3;
            [ results,nu ] = fun_simulation( nxss,ir_shocks,coeffs,c0,order,n_y,n_x,n_f,model,params,eta );
            ir_pert3=results;
            nu_pert3=nu;
            pert3_EE=eval_eqs(coeffs,results(n_y+1:end,100),model,params,eta,c0,nep,P,order,poly);

%             coeffs=pert4(:); order=4;
%             [ results,nu ] = fun_simulation( nxss,ir_shocks,coeffs,c0,order,n_y,n_x,n_f,model,params,eta );
%             ir_pert4=results;
%             nu_pert4=nu;
%             pert4_EE=eval_eqs(coeffs,results(n_y+1:end,100),model,params,eta,c0,nep,P,order,poly);
% 
%             coeffs=pert5(:); order=5;
%             [ results,nu ] = fun_simulation( nxss,ir_shocks,coeffs,c0,order,n_y,n_x,n_f,model,params,eta );
%             ir_pert5=results;
%             nu_pert5=nu;
%             pert5_EE=eval_eqs(coeffs,results(n_y+1:end,100),model,params,eta,c0,nep,P,order,poly);

        % Smolyak
%             coeffs=smol1(:); order=1; 
%             smol_c0=smol1_c0;
%             poly.type='smol';
%             poly.DELTA=smol1_DELTA;
%             poly.Tcheb_fun_folder=[main_folder '\files_for_smolyak\' models{modeli} '\order' num2str(order) '\files'];
%             [ results,nu ] = fun_simulation( nxss,ir_shocks,coeffs,smol_c0,order,n_y,n_x,n_f,model,params,eta,poly );
%             ir_smol1=results;
%             nu_smol1=nu;
%             smol1_EE=eval_eqs(coeffs,results(n_y+1:end,100),model,params,eta,smol_c0,nep,P,order,poly);
% 
%             coeffs=smol2(:); order=2; 
%             smol_c0=smol2_c0;
%             poly.type='smol';
%             poly.DELTA=smol2_DELTA;
%             poly.Tcheb_fun_folder=[main_folder '\files_for_smolyak\' models{modeli} '\order' num2str(order) '\files'];
%             [ results,nu ] = fun_simulation( nxss,ir_shocks,coeffs,smol_c0,order,n_y,n_x,n_f,model,params,eta,poly );
%             ir_smol2=results;
%             nu_smol2=nu;
%             smol2_EE=eval_eqs(coeffs,results(n_y+1:end,100),model,params,eta,smol_c0,nep,P,order,poly);
% 
%             coeffs=smol3(:); order=3; 
%             smol_c0=smol3_c0;
%             poly.type='smol';
%             poly.DELTA=smol3_DELTA;
%             poly.Tcheb_fun_folder=[main_folder '\files_for_smolyak\' models{modeli} '\order' num2str(order) '\files'];
%             [ results,nu ] = fun_simulation( nxss,ir_shocks,coeffs,smol_c0,order,n_y,n_x,n_f,model,params,eta,poly );
%             ir_smol3=results;
%             nu_smol3=nu;
%             smol3_EE=eval_eqs(coeffs,results(n_y+1:end,100),model,params,eta,smol_c0,nep,P,order,poly);

            save('ir','ir_*','nu_*')
        else
            load('ir')
        end

        % make the plots
        tvec=95:120; T=length(tvec);
%         names={'pert1','pert2','pert3','pert4','pert5','tp1','tp2','tp3','smol1','smol2','smol3'};
        names={'tp3'};
        for i=1:length(names)
            disp(names{i})
            eval(['results=ir_' names{i} ';'])
            eval(['nu=nu_' names{i} ';'])
            tildiv=nu(logical(subsvars==sym('tildiv')),:);
            loghatz=nu(logical(subsvars==sym('loghatz')),:);
            loghata=nu(logical(subsvars==sym('loghata')),:);
            loghatlabor=nu(logical(subsvars==sym('loghatlabor')),:);
            loglabor=cumsum(loghatlabor);
            logz=cumsum(loghatz+loghatlabor);            
            logtilqe=results(logical(y==sym('logtilqe')),:);
            logqf=results(logical(y==sym('logqf')),:);
            logtily=nu(logical(subsvars==sym('logtily')),:);
            logtilc=nu(logical(subsvars==sym('logtilc')),:);
            logtilx=results(logical(y==sym('logtilx')),:);
%             logtilx=nu(logical(subsvars==sym('logtilx')),:);  % use this
%             to plot investment in RBC mode
            logy=logtily+logz;
            logx=logtilx+logz;
            logc=logtilc+logz;
            RoE=exp(loghatz(2:end)).*(tildiv(2:end)+exp(logtilqe(2:end))).*exp(-logtilqe(1:end-1));
            RoE=100*(RoE.^4-1); %annualized
            Rf=exp(-logqf);
            Rf=100*(Rf.^4-1);%annualized
            dlogy=logtily(2:end)-logtily(1:end-1)+loghatz(2:end);
            Growth=exp(400*dlogy)-1;
            
%             dlogtilc=logtilc(2:end)-logtilc(1:end-1);
            
            
            bgp=zeros(size(logz));
            for iii=1:99
                bgp(1,iii)=logz(1,iii);
            end
            for iii=100:120
                bgp(1,iii)=bgp(1,iii-1)+0.0071;
            end
            
          
            nl=results(logical(y==sym('nl')),:);
            
            riskprem=zeros(1,119);
            for ii=1:119
                riskprem(1,ii)=RoE(1,ii)-Rf(1,ii);
            end
            
            logtilr=nu(logical(subsvars==sym('logtilr')),:);
            grossretcap=exp(logtilr);
            Aretcap=100*(grossretcap.^4-1);
           
            inflation=nu(logical(subsvars==sym('logpi')),:);
            grossinfl=exp(inflation);
            infl_target=1.02;%100*log(1.02);
            Agrossinflation=(grossinfl.^4);
            Ainflation=100*log(Agrossinflation);
            infl_dev=100*log(Agrossinflation/infl_target);
            
                  
            inflationagg=nu(logical(subsvars==sym('logpiagg')),:);
            grossinflagg=exp(inflationagg);
            Agrossinflationagg=(grossinflagg.^4);
            Ainflationagg=100*log(Agrossinflationagg);
     
            policyrate=nu(logical(subsvars==sym('logR')),:); 
            grosspolicyrate=exp(policyrate);
            Apolicyrate=100*(grosspolicyrate.^4-1);%annualized
            %real policy rate
            policyrate_real=policyrate-inflation;
            grosspolicyrate_real=exp(policyrate_real);
            Apolicyrate_real=100*(grosspolicyrate_real.^4-1);%annualized 
            
%             logRstar=results(logical(y==sym('logRstar')),:);
%             grossRstar=exp(logRstar);
%             Rstar_ann=100*(grossRstar.^4-1);
            
            naturalrate_nominal=ir_tp2(16,2:end);
            grossnaturalrate_nominal=exp(naturalrate_nominal);
            Anaturalrate_nominal=100*(grossnaturalrate_nominal.^4-1);
            naturalrate_real=zeros(1,119);
            for iii=1:119
                naturalrate_real(1,iii)=naturalrate_nominal(1,iii)-inflation(1,iii);
            end
            grossnaturalrate_real=exp(naturalrate_real);
            Anaturalrate_real=100*(grossnaturalrate_real.^4-1);
            
             Rfnominal=exp(-logqf+inflation);
             Rfnominal=100*(Rfnominal.^4-1);%annualized
            
            logtilw=results(logical(y==sym('logtilw')),:);
            logw=logtilw+logz;
            labor=log(nu(logical(subsvars==sym('l')),:));
            labortrend=labor+loglabor;%logz;
            
                        
            logtilk=nu(logical(subsvars==sym('logtilk')),:);
            tilk=exp(logtilk);
            logk=logtilk+logz;

            logmnom=nu(logical(subsvars==sym('logmnom')),:);
            logmden=nu(logical(subsvars==sym('logmden')),:);
            
            logtilwelf=results(logical(y==sym('logtilwelf')),:);
            tilwelfare=exp(logtilwelf);
            logwelfare=logtilwelf+logz;
            welfare=exp(logwelfare);
            
            loghata=nu(logical(subsvars==sym('loghata')),:);
            loga=cumsum(loghata);
            logAT=ir_tp2(17,2:end);
            TFPlevel=zeros(1,119);
            logTFP=zeros(1,119);
            for iii=1:119
            logTFP(1,iii)=logz(1,iii)+logAT(1,iii);
            TFPlevel=exp(logTFP);
            end
            TFPGrowthAgg=zeros(1,118);
            for iii=1:118
                TFPGrowthAgg(1,iii)=100*(logTFP(1,iii+1)-logTFP(1,iii));
            end
            
            logsoes=results(logical(y==sym('logsoes')),:);
            logsoeimp=nu(logical(subsvars==sym('logsoeimp')),:);
            logsoeimpz=logsoeimp+logz;
            logsoeexp=results(logical(y==sym('logsoeexp')),:);
            logsoeexpz=logsoeexp+logz;
            logsoebstarback=results(logical(x==sym('logsoebstarback')),:);
            logsoebstarbackz=logsoebstarback+logz;
            logsoepistarback=results(logical(y==sym('logsoepistarback')),:);
            logdeltae=zeros(1,119);
            logsoepsiback=results(logical(x==sym('logsoepsiback')),:);
            logdeltas=zeros(1,119);
            logsoee=zeros(1,119);
            for ii=1:119
            logdeltae(1,ii+1)=logsoes(1,ii+1)-logsoes(1,ii)+inflationagg(1,ii+1)-logsoepistarback(1,ii+1);
            logdeltas(1,ii+1)=logsoes(1,ii+1)-logsoes(1,ii);
            logsoee(1,ii+1)=logsoee(1,ii)+logsoes(1,ii+1)-logsoes(1,ii)+inflationagg(1,ii+1)-logsoepistarback(1,ii+1);
            end
            netexp=exp(logsoeexp)-exp(logsoeimp);
            negnetexp=netexp.*(-1);
            lognegnetexp=log(negnetexp);
            lognetexp=lognegnetexp.*(-1);
            lognetexpz=lognetexp+logz;
            
            
            logCA=zeros(1,119);
            for ii=1:119
                logCA(1,ii+1)=logsoes(1,ii+1)+log(exp(logsoebstarback(1,ii+1))-exp(logsoebstarback(1,ii)-loghatz(1,ii+1)-logsoepistarback(1,ii+1)));
            end
            logCAz=logCA+logz;
            
            % construct variables as fraction of GDP
            logcy=logtilc-logtily;
            logxy=logtilx-logtily;
            lognfay=logsoebstarback-logtily;
            logexpy=logsoeexp-logtily;
            logimpy=logsoeimp-logtily;
            logcay=logCA-logtily;
            logtilv=nu(logical(subsvars==sym('logtilv')),:); 
            tilv=exp(logtilv);
           logvz=logtilv+logz;
           vz=exp(logvz);
           
           % construct variables in deviation from pre-disaster BGP
           logy_nodis=zeros(size(logy));
           logy_nodis(1,1:99)=logy(1,1:99);
           logc_nodis=zeros(size(logc));
           logc_nodis(1,1:99)=logc(1,1:99);
           logx_nodis=zeros(size(logx));
           logx_nodis(1,1:99)=logx(1,1:99);
           logsoeexpz_nodis=zeros(size(logsoeexpz));
           logsoeexpz_nodis(1,1:99)=logsoeexpz(1,1:99);
           logsoeimpz_nodis=zeros(size(logsoeimpz));
           logsoeimpz_nodis(1,1:99)=logsoeimpz(1,1:99);
           lognetexpz_nodis=zeros(size(lognetexpz));
           lognetexpz_nodis(1,1:99)=lognetexpz(1,1:99);
           logsoebstarbackz_nodis=zeros(size(logsoebstarbackz));
           logsoebstarbackz_nodis(1,1:99)=logsoebstarbackz(1,1:99);
           logw_nodis=zeros(size(logw));
           logw_nodis(1,1:99)=logw(1,1:99);
           labortrend_nodis=zeros(size(labortrend));
           labortrend_nodis(1,1:99)=labortrend(1,1:99);

           
            for iii=100:120
            logy_nodis(1,iii)=logy_nodis(1,iii-1)+loghatz(1,99)+loghatlabor(1,99);
            logc_nodis(1,iii)=logc_nodis(1,iii-1)+loghatz(1,99)+loghatlabor(1,99);
            logx_nodis(1,iii)=logx_nodis(1,iii-1)+loghatz(1,99)+loghatlabor(1,99);
            logsoeexpz_nodis(1,iii)=logsoeexpz_nodis(1,iii-1)+loghatz(1,99)+loghatlabor(1,99);
            logsoeimpz_nodis(1,iii)=logsoeimpz_nodis(1,iii-1)+loghatz(1,99)+loghatlabor(1,99);
            lognetexpz_nodis(1,iii)=lognetexpz_nodis(1,iii-1)+loghatz(1,99)+loghatlabor(1,99);
            logsoebstarbackz_nodis(1,iii)=logsoebstarbackz_nodis(1,iii-1)+loghatz(1,99)+loghatlabor(1,99);
            logw_nodis(1,iii)=logw_nodis(1,iii-1)+loghatz(1,99)+loghatlabor(1,99);
            labortrend_nodis(1,iii)=labortrend_nodis(1,iii-1)+loghatlabor(1,99);
            end
            
            
            eval(['RoE_' names{i} '=RoE(tvec(1):end);'])
            eval(['Rf_' names{i} '=Rf(tvec(1):end);'])
            eval(['Growth_' names{i} '=Growth(tvec(1):end);'])
            eval(['logtily_' names{i} '=logtily(tvec(1):end);'])
            eval(['logy_' names{i} '=logy(tvec(1):end);'])
            eval(['logtilx_' names{i} '=logtilx(tvec(1):end);'])
            eval(['logx_' names{i} '=logx(tvec(1):end);'])
            eval(['logtilc_' names{i} '=logtilc(tvec(1):end);'])
            eval(['logc_' names{i} '=logc(tvec(1):end);'])
            eval(['logtilqe_' names{i} '=logtilqe(tvec(1):end);'])
            eval(['inflation_' names{i} '=inflation(tvec(1):end);'])
            eval(['Apolicyrate_' names{i} '=Apolicyrate(tvec(1):end);'])
            eval(['Rfnominal_' names{i} '=Rfnominal(tvec(1):end);'])
            eval(['infl_dev_' names{i} '=infl_dev(tvec(1):end);'])
            eval(['Ainflation_' names{i} '=Ainflation(tvec(1):end);'])
            eval(['logqf_' names{i} '=logqf(tvec(1):end);'])
            eval(['logw_' names{i} '=logw(tvec(1):end);'])
            eval(['labor_' names{i} '=labor(tvec(1):end);'])
            eval(['riskprem_' names{i} '=riskprem(tvec(1):end);'])
            eval(['Apolicyrate_real_' names{i} '=Apolicyrate_real(tvec(1):end);'])
            eval(['logtilk_' names{i} '=logtilk(tvec(1):end);'])
            eval(['logk_' names{i} '=logk(tvec(1):end);'])
            eval(['Anaturalrate_nominal_' names{i} '=Anaturalrate_nominal(tvec(1):end);'])
            eval(['Anaturalrate_real_' names{i} '=Anaturalrate_real(tvec(1):end);'])
            eval(['tilwelfare_' names{i} '=tilwelfare(tvec(1):end);'])
            eval(['welfare_' names{i} '=welfare(tvec(1):end);'])
            eval(['logwelfare_' names{i} '=logwelfare(tvec(1):end);'])
            eval(['TFPlevel_' names{i} '=TFPlevel(tvec(1):end);'])
            eval(['logTFP_' names{i} '=logTFP(tvec(1):end);'])
            eval(['logtilwelf_' names{i} '=logtilwelf(tvec(1):end);'])
            eval(['Ainflationagg_' names{i} '=Ainflationagg(tvec(1):end);'])
            eval(['logsoes_' names{i} '=logsoes(tvec(1):end);'])
            eval(['logsoeimpz_' names{i} '=logsoeimpz(tvec(1):end);'])
            eval(['logsoeexpz_' names{i} '=logsoeexpz(tvec(1):end);'])
            eval(['logsoebstarbackz_' names{i} '=logsoebstarbackz(tvec(1):end);'])
            eval(['logdeltae_' names{i} '=logdeltae(tvec(1):end);'])
            eval(['logdeltas_' names{i} '=logdeltas(tvec(1):end);'])
            eval(['logCAz_' names{i} '=logCAz(tvec(1):end);'])
            eval(['logcy_' names{i} '=logcy(tvec(1):end);'])
            eval(['logxy_' names{i} '=logxy(tvec(1):end);'])
            eval(['lognfay_' names{i} '=lognfay(tvec(1):end);'])
            eval(['logexpy_' names{i} '=logexpy(tvec(1):end);'])
            eval(['logimpy_' names{i} '=logimpy(tvec(1):end);'])
            eval(['logcay_' names{i} '=logcay(tvec(1):end);'])
            eval(['logsoee_' names{i} '=logsoee(tvec(1):end);'])
            eval(['tilv_' names{i} '=tilv(tvec(1):end);'])
            eval(['vz_' names{i} '=vz(tvec(1):end);'])
            eval(['lognetexp_' names{i} '=lognetexp(tvec(1):end);'])
            eval(['lognetexpz_' names{i} '=lognetexpz(tvec(1):end);'])
            
            eval(['logy_nodis_' names{i} '=logy_nodis(tvec(1):end);'])
            eval(['logc_nodis_' names{i} '=logc_nodis(tvec(1):end);'])
            eval(['logx_nodis_' names{i} '=logx_nodis(tvec(1):end);'])
            eval(['logsoeexpz_nodis_' names{i} '=logsoeexpz_nodis(tvec(1):end);'])
            eval(['logsoeimpz_nodis_' names{i} '=logsoeimpz_nodis(tvec(1):end);'])
            eval(['lognetexpz_nodis_' names{i} '=lognetexpz_nodis(tvec(1):end);'])
            eval(['logsoebstarbackz_nodis_' names{i} '=logsoebstarbackz_nodis(tvec(1):end);'])
            eval(['logw_nodis_' names{i} '=logw_nodis(tvec(1):end);'])
            eval(['labortrend_nodis_' names{i} '=labortrend_nodis(tvec(1):end);'])
            eval(['labortrend_' names{i} '=labortrend(tvec(1):end);'])
           
        end
        
        close all
%         tvec2=tvec(1:end-1);
        time=1:length(tvec);
%         time=0:length(tvec)-1;
        
        % construct variables in deviations from the stochastic steady state
        logtily_dev_tp3=zeros(size(logtily_tp3));
        logtilc_dev_tp3=zeros(size(logtilc_tp3));
        logtilx_dev_tp3=zeros(size(logtilx_tp3));
        logy_dev_tp3=zeros(size(logy_tp3));
        logc_dev_tp3=zeros(size(logc_tp3));
        logx_dev_tp3=zeros(size(logx_tp3));
        logw_dev_tp3=zeros(size(logw_tp3));
        labor_dev_tp3=zeros(size(labor_tp3));
        inflation_dev_tp3=zeros(size(inflation_tp3));
        logtilk_dev_tp3=zeros(size(logtilk_tp3));
        logk_dev_tp3=zeros(size(logk_tp3));
        logwelfare_dev_tp3=zeros(size(logwelfare_tp3));
        logTFP_dev_tp3=zeros(size(logTFP_tp3));
        logsoes_dev_tp3=zeros(size(logsoes_tp3));
        logsoeimpz_dev_tp3=zeros(size(logsoeimpz_tp3));
        logsoeexpz_dev_tp3=zeros(size(logsoeexpz_tp3));
        logsoebstarbackz_dev_tp3=zeros(size(logsoebstarbackz_tp3));
        logdeltae_dev_tp3=zeros(size(logdeltae_tp3));
        logCAz_dev_tp3=zeros(size(logCAz_tp3));
        logcy_dev_tp3=zeros(size(logcy_tp3));
        logxy_dev_tp3=zeros(size(logxy_tp3));
        lognfay_dev_tp3=zeros(size(lognfay_tp3));
        logexpy_dev_tp3=zeros(size(logexpy_tp3));
        logimpy_dev_tp3=zeros(size(logimpy_tp3));
        logcay_dev_tp3=zeros(size(logcay_tp3));
        logsoee_dev_tp3=zeros(size(logsoee_tp3));
        Ainflation_dev_tp3=zeros(size(Ainflation_tp3));
        Ainflationagg_dev_tp3=zeros(size(Ainflationagg_tp3));
        Apolicyrate_dev_tp3=zeros(size(Apolicyrate_tp3));
        lognetexp_dev_tp3=zeros(size(lognetexp_tp3));
        
        logy_devbgp_tp3=zeros(size(logy_tp3));
        logc_devbgp_tp3=zeros(size(logy_tp3));
        logx_devbgp_tp3=zeros(size(logy_tp3));
        logsoeexpz_devbgp_tp3=zeros(size(logy_tp3));
        logsoeimpz_devbgp_tp3=zeros(size(logy_tp3));
        lognetexpz_devbgp_tp3=zeros(size(logy_tp3));
        logsoebstarbackz_devbgp_tp3=zeros(size(logy_tp3));
        logw_devbgp_tp3=zeros(size(logw_tp3));
        labor_devbgp_tp3=zeros(size(labortrend_tp3));

               
        for iii=1:size(logtily_tp3,2)
        logtily_dev_tp3(1,iii)=(logtily_tp3(1,iii)-logtily_tp3(1,5))*100;
        logtilc_dev_tp3(1,iii)=(logtilc_tp3(1,iii)-logtilc_tp3(1,5))*100;
        logtilx_dev_tp3(1,iii)=(logtilx_tp3(1,iii)-logtilx_tp3(1,5))*100;
        logy_dev_tp3(1,iii)=(logy_tp3(1,iii)-logy_tp3(1,5))*100;
        logc_dev_tp3(1,iii)=(logc_tp3(1,iii)-logc_tp3(1,5))*100;
        logx_dev_tp3(1,iii)=(logx_tp3(1,iii)-logx_tp3(1,5))*100;
        logw_dev_tp3(1,iii)=(logw_tp3(1,iii)-logw_tp3(1,5))*100;
        labor_dev_tp3(1,iii)=(labor_tp3(1,iii)-labor_tp3(1,5))*100;
        inflation_dev_tp3(1,iii)=(inflation_tp3(1,iii)-inflation_tp3(1,1))*100;        
        logtilk_dev_tp3(1,iii)=(logtilk_tp3(1,iii)-logtilk_tp3(1,5))*100;
        logk_dev_tp3(1,iii)=(logk_tp3(1,iii)-logk_tp3(1,5))*100;
        logwelfare_dev_tp3(1,iii)=(logwelfare_tp3(1,iii)-logwelfare_tp3(1,5))*100;
        logsoes_dev_tp3(1,iii)=(logsoes_tp3(1,iii)-logsoes_tp3(1,5))*100;
        logsoeimpz_dev_tp3(1,iii)=(logsoeimpz_tp3(1,iii)-logsoeimpz_tp3(1,5))*100;
        logsoeexpz_dev_tp3(1,iii)=(logsoeexpz_tp3(1,iii)-logsoeexpz_tp3(1,5))*100;
        logsoebstarbackz_dev_tp3(1,iii)=(logsoebstarbackz_tp3(1,iii)-logsoebstarbackz_tp3(1,5))*100;
        logdeltae_dev_tp3(1,iii)=(logdeltae_tp3(1,iii)-logdeltae_tp3(1,5))*400;
        logCAz_dev_tp3(1,iii)=(logCAz_tp3(1,iii)-logCAz_tp3(1,5))*100;
        logcy_dev_tp3(1,iii)=(logcy_tp3(1,iii)-logcy_tp3(1,5))*100;
        logxy_dev_tp3(1,iii)=(logxy_tp3(1,iii)-logxy_tp3(1,5))*100;
        lognfay_dev_tp3(1,iii)=(lognfay_tp3(1,iii)-lognfay_tp3(1,5))*100;
        logexpy_dev_tp3(1,iii)=(logexpy_tp3(1,iii)-logexpy_tp3(1,5))*100;
        logimpy_dev_tp3(1,iii)=(logimpy_tp3(1,iii)-logimpy_tp3(1,5))*100;
        logcay_dev_tp3(1,iii)=(logcay_tp3(1,iii)-logcay_tp3(1,5))*100;
        logsoee_dev_tp3(1,iii)=(logsoee_tp3(1,iii)-logsoee_tp3(1,5))*100;
        Ainflation_dev_tp3(1,iii)=Ainflation_tp3(1,iii)-Ainflation_tp3(1,5);
        Ainflationagg_dev_tp3(1,iii)=Ainflationagg_tp3(1,iii)-Ainflationagg_tp3(1,5);
        Apolicyrate_dev_tp3(1,iii)=Apolicyrate_tp3(1,iii)-Apolicyrate_tp3(1,5);
        lognetexp_dev_tp3(1,iii)=100*(lognetexp_tp3(1,iii)-lognetexp_tp3(1,5));
        
        logy_devbgp_tp3(1,iii)=100*(logy_tp3(1,iii)-logy_nodis_tp3(1,iii));
        logc_devbgp_tp3(1,iii)=100*(logc_tp3(1,iii)-logc_nodis_tp3(1,iii));
        logx_devbgp_tp3(1,iii)=100*(logx_tp3(1,iii)-logx_nodis_tp3(1,iii));
        logsoeexpz_devbgp_tp3(1,iii)=100*(logsoeexpz_tp3(1,iii)-logsoeexpz_nodis_tp3(1,iii));
        logsoeimpz_devbgp_tp3(1,iii)=100*(logsoeimpz_tp3(1,iii)-logsoeimpz_nodis_tp3(1,iii));
        lognetexpz_devbgp_tp3(1,iii)=100*(lognetexpz_tp3(1,iii)-lognetexpz_nodis_tp3(1,iii));
        logsoebstarbackz_devbgp_tp3(1,iii)=100*(logsoebstarbackz_tp3(1,iii)-logsoebstarbackz_nodis_tp3(1,iii));
        logw_devbgp_tp3(1,iii)=100*(logw_tp3(1,iii)-logw_nodis_tp3(1,iii));
        labor_devbgp_tp3(1,iii)=100*(labortrend_tp3(1,iii)-labortrend_nodis_tp3(1,iii));
        
        end
        for iii=1:25
            logTFP_dev_tp3(1,iii)=(logTFP_tp3(1,iii)-logTFP_tp3(1,5))*100;
        end
        
                

        
        
        set(0, 'defaultFigurePaperPosition',  [0 0 20 21.5]*20);
        h= figure('color', [1 1 1], 'PaperType', 'A4');
        timetoplot=0:20;
        nrows=5;
        ncols=3;
        
        f=figure(2)
        f.Position = [100 100 1200 500];
        
        subplot(nrows,ncols,1);
        plot(timetoplot,logy_devbgp_tp3(1,5:25),'-b','LineWidth',2);
        title('Output','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,2)
        plot(timetoplot,logc_devbgp_tp3(1,5:25),'-b','LineWidth',2);
        title('Consumption','Fontsize',20)
        xlim([0 20])
    
        subplot(nrows,ncols,3)
        plot(timetoplot,logx_devbgp_tp3(1,5:25),'-b','LineWidth',2);
        title('Investment','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,4);
        plot(timetoplot,logsoeexpz_devbgp_tp3(1,5:25),'-b','LineWidth',2);
        title('Exports','Fontsize',20)
        xlim([0 20]) 
        
        subplot(nrows,ncols,5);
        plot(timetoplot,logsoeimpz_devbgp_tp3(1,5:25),'-b','LineWidth',2);
        title('Imports','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,6);
        plot(timetoplot,lognetexpz_devbgp_tp3(1,5:25),'-b','LineWidth',2);
        title('Net exports','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,7)
        plot(timetoplot,logsoebstarbackz_devbgp_tp3(1,5:25),'-b','LineWidth',2);
        title('Net foreign assets','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,8);
        plot(timetoplot,logsoes_dev_tp3(1,5:25),'-b','LineWidth',2);
        title('Real exchange rate (level)','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,9)
        plot(timetoplot,logdeltae_dev_tp3(1,5:25),'-b','LineWidth',2);
        title('Nom. exchange rate (ann. growth rate)','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,10);
        plot(timetoplot,Ainflation_dev_tp3(1,5:25),'-b','LineWidth',2);
        title('Domestic good inflation (ann.)','Fontsize',20)
        xlim([0 20])

        subplot(nrows,ncols,11);
        plot(timetoplot,Ainflationagg_dev_tp3(1,5:25),'-b','LineWidth',2);
        title('CPI inflation (ann.)','Fontsize',20)
        xlim([0 20])

        subplot(nrows,ncols,12)
        plot(timetoplot,Apolicyrate_dev_tp3(1,5:25),'-b','LineWidth',2);
        title('Monetary policy rate (ann.)','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,13);
        plot(timetoplot,labor_devbgp_tp3(1,5:25),'-b','LineWidth',2);
        title('Labor supply','Fontsize',20)
        xlim([0 20])

        subplot(nrows,ncols,14);
        plot(timetoplot,logw_devbgp_tp3(1,5:25),'-b','LineWidth',2);
        title('Real wage','Fontsize',20)
        xlim([0 20])

        

        rmpath([main_folder '/files_for_TaylorProjection/' models{modeli} '/order3/files']);

    end
end

 