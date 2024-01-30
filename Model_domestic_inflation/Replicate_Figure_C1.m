

%DIT
baseline_calibration
get_results
IRFs_SOE_disaster_BGP
close all

logy_dev_case2             = logy_devbgp_tp3;
logc_dev_case2             = logc_devbgp_tp3;
logx_dev_case2             = logx_devbgp_tp3;
logsoeexpz_dev_case2       = logsoeexpz_devbgp_tp3;
logsoeimpz_dev_case2       = logsoeimpz_devbgp_tp3;
lognetexpz_dev_case2        = lognetexpz_devbgp_tp3;
logsoebstarbackz_dev_case2 = logsoebstarbackz_devbgp_tp3;
logsoes_dev_case2          = logsoes_dev_tp3;
logdeltae_dev_case2        = logdeltae_dev_tp3;
Ainflation_dev_case2       = Ainflation_dev_tp3;
Ainflationagg_dev_case2    = Ainflationagg_dev_tp3;
Apolicyrate_dev_case2      = Apolicyrate_dev_tp3;

% load baseline results after replicating Figure 4 of baseline model
load Simulations_baseline

logy_dev_case1             = logy_devbgp_tp3;
logc_dev_case1             = logc_devbgp_tp3;
logx_dev_case1             = logx_devbgp_tp3;
logsoeexpz_dev_case1       = logsoeexpz_devbgp_tp3;
logsoeimpz_dev_case1       = logsoeimpz_devbgp_tp3;
lognetexpz_dev_case1        = lognetexpz_devbgp_tp3;
logsoebstarbackz_dev_case1 = logsoebstarbackz_devbgp_tp3;
logsoes_dev_case1          = logsoes_dev_tp3;
logdeltae_dev_case1        = logdeltae_dev_tp3;
Ainflation_dev_case1       = Ainflation_dev_tp3;
Ainflationagg_dev_case1    = Ainflationagg_dev_tp3;
Apolicyrate_dev_case1      = Apolicyrate_dev_tp3;


nrows=4;
nclos=3;

f=figure(1)
f.Position = [100 100 1200 500];
        
        subplot(nrows,ncols,1);
        plot(timetoplot,logy_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logy_dev_case2(1,5:25),'--r','LineWidth',2)
        title('Output','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,2)
        plot(timetoplot,logc_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logc_dev_case2(1,5:25),'--r','LineWidth',2)
        title('Consumption','Fontsize',20)
        xlim([0 20])
    
        subplot(nrows,ncols,3)
        plot(timetoplot,logx_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logx_dev_case2(1,5:25),'--r','LineWidth',2)
        title('Investment','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,4);
        plot(timetoplot,logsoeexpz_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logsoeexpz_dev_case2(1,5:25),'--r','LineWidth',2);
        title('Exports','Fontsize',20)
        xlim([0 20]) 
        
        subplot(nrows,ncols,5);
        plot(timetoplot,logsoeimpz_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logsoeimpz_dev_case2(1,5:25),'--r','LineWidth',2);
        title('Imports','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,6);
        plot(timetoplot,lognetexpz_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,lognetexpz_dev_case2(1,5:25),'--r','LineWidth',2);
        title('Net exports','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,7)
        plot(timetoplot,logsoebstarbackz_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logsoebstarbackz_dev_case2(1,5:25),'--r','LineWidth',2);
        title('Net foreign assets','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,8);
        plot(timetoplot,logsoes_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logsoes_dev_case2(1,5:25),'--r','LineWidth',2);
        title('Real exchange rate (level)','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,9)
        plot(timetoplot,logdeltae_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logdeltae_dev_case2(1,5:25),'--r','LineWidth',2);
        title('Nom. exchange rate (ann. growth rate)','Fontsize',20)
        xlim([0 20])
        
        subplot(nrows,ncols,10);
        plot(timetoplot,Ainflation_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,Ainflation_dev_case2(1,5:25),'--r','LineWidth',2);
        title('Domestic good inflation (ann.)','Fontsize',20)
        xlim([0 20])

        subplot(nrows,ncols,11);
        plot(timetoplot,Ainflationagg_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,Ainflationagg_dev_case2(1,5:25),'--r','LineWidth',2);
        title('CPI inflation (ann.)','Fontsize',20)
        xlim([0 20])

        subplot(nrows,ncols,12)
        plot(timetoplot,Apolicyrate_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,Apolicyrate_dev_case2(1,5:25),'--r','LineWidth',2);
        title('Monetary policy rate (ann.)','Fontsize',20)
        xlim([0 20])
        
        legend('Baseline','Domestic inflation targeting','Location','Best', 'Orientation', 'horizontal','Fontsize',14)
