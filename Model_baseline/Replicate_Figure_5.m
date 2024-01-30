% Baseline (Inflation targeting)
baseline_calibration
get_results
IRFs_SOE_disaster_BGP
close all

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


% Strict IT 
baseline_calibration
GAMMA_PI_iii=10;
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



% Hard Peg 
baseline_calibration
GAMMA_PI_iii=0;
GAMMA_E_iii=20;
get_results
IRFs_SOE_disaster_BGP
close all

logy_dev_case3             = logy_devbgp_tp3;
logc_dev_case3             = logc_devbgp_tp3;
logx_dev_case3             = logx_devbgp_tp3;
logsoeexpz_dev_case3       = logsoeexpz_devbgp_tp3;
logsoeimpz_dev_case3       = logsoeimpz_devbgp_tp3;
lognetexpz_dev_case3        = lognetexpz_devbgp_tp3;
logsoebstarbackz_dev_case3 = logsoebstarbackz_devbgp_tp3;
logsoes_dev_case3          = logsoes_dev_tp3;
logdeltae_dev_case3        = logdeltae_dev_tp3;
Ainflation_dev_case3       = Ainflation_dev_tp3;
Ainflationagg_dev_case3    = Ainflationagg_dev_tp3;
Apolicyrate_dev_case3      = Apolicyrate_dev_tp3;



% Augmented Taylor rule
baseline_calibration
GAMMA_E_iii=0.5;
GAMMA_Y_iii=0.5;
get_results
IRFs_SOE_disaster_BGP
close all

logy_dev_case4             = logy_devbgp_tp3;
logc_dev_case4             = logc_devbgp_tp3;
logx_dev_case4             = logx_devbgp_tp3;
logsoeexpz_dev_case4       = logsoeexpz_devbgp_tp3;
logsoeimpz_dev_case4       = logsoeimpz_devbgp_tp3;
lognetexpz_dev_case4        = lognetexpz_devbgp_tp3;
logsoebstarbackz_dev_case4 = logsoebstarbackz_devbgp_tp3;
logsoes_dev_case4          = logsoes_dev_tp3;
logdeltae_dev_case4        = logdeltae_dev_tp3;
Ainflation_dev_case4       = Ainflation_dev_tp3;
Ainflationagg_dev_case4    = Ainflationagg_dev_tp3;
Apolicyrate_dev_case4      = Apolicyrate_dev_tp3;


% Taylor rule
baseline_calibration
GAMMA_Y_iii=0.5;
get_results
IRFs_SOE_disaster_BGP
close all

logy_dev_case5             = logy_devbgp_tp3;
logc_dev_case5             = logc_devbgp_tp3;
logx_dev_case5             = logx_devbgp_tp3;
logsoeexpz_dev_case5       = logsoeexpz_devbgp_tp3;
logsoeimpz_dev_case5       = logsoeimpz_devbgp_tp3;
lognetexpz_dev_case5        = lognetexpz_devbgp_tp3;
logsoebstarbackz_dev_case5 = logsoebstarbackz_devbgp_tp3;
logsoes_dev_case5          = logsoes_dev_tp3;
logdeltae_dev_case5        = logdeltae_dev_tp3;
Ainflation_dev_case5       = Ainflation_dev_tp3;
Ainflationagg_dev_case5    = Ainflationagg_dev_tp3;
Apolicyrate_dev_case5      = Apolicyrate_dev_tp3;

save Simulations_TR

nrows=2;
ncols=2;


        
f=figure(1) 
f.Position = [100 100 1200 500];
        
        subplot(nrows,ncols,1);
        plot(timetoplot,logy_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logy_dev_case2(1,5:25),'--r','LineWidth',2), hold on
        plot(timetoplot,logy_dev_case3(1,5:25),':k','LineWidth',2)
        title('Output','Fontsize',30)
        xlim([0 20])
        
    
        
        subplot(nrows,ncols,2)
        plot(timetoplot,logdeltae_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logdeltae_dev_case2(1,5:25),'--r','LineWidth',2), hold on
        plot(timetoplot,logdeltae_dev_case3(1,5:25),':k','LineWidth',2)
        title('Nom. exchange rate (ann. growth rate)','Fontsize',30)
        xlim([0 20])
        

        subplot(nrows,ncols,3);
        plot(timetoplot,Ainflationagg_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,Ainflationagg_dev_case2(1,5:25),'--r','LineWidth',2), hold on
        plot(timetoplot,Ainflationagg_dev_case3(1,5:25),':k','LineWidth',2)
        title('CPI inflation (ann.)','Fontsize',30)
        xlim([0 20])

        subplot(nrows,ncols,4)
        plot(timetoplot,Apolicyrate_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,Apolicyrate_dev_case2(1,5:25),'--r','LineWidth',2), hold on
        plot(timetoplot,Apolicyrate_dev_case3(1,5:25),':k','LineWidth',2)
        title('Monetary policy rate (ann.)','Fontsize',30)
        xlim([0 20])
        

        
        legend('Baseline, \gamma_{\pi}=1.5, \gamma_y=0, \gamma_e=0','Strict IT,  \gamma_{\pi}=\infty, \gamma_y=0, \gamma_e=0', 'Hard peg,  \gamma_{\pi}=0, \gamma_y=0, \gamma_e=\infty','Location','Best', 'Orientation', 'horizontal','Fontsize',20)

f=figure(2) 
f.Position = [100 100 1200 500];
        
        subplot(nrows,ncols,1);
        plot(timetoplot,logy_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logy_dev_case5(1,5:25),'--r','LineWidth',2), hold on
        plot(timetoplot,logy_dev_case4(1,5:25),':k','LineWidth',2)
        title('Output','Fontsize',30)
        xlim([0 20])
        
    
        
        subplot(nrows,ncols,2)
        plot(timetoplot,logdeltae_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logdeltae_dev_case5(1,5:25),'--r','LineWidth',2), hold on
        plot(timetoplot,logdeltae_dev_case4(1,5:25),':k','LineWidth',2)
        title('Nom. exchange rate (ann. growth rate)','Fontsize',30)
        xlim([0 20])
        

        subplot(nrows,ncols,3);
        plot(timetoplot,Ainflationagg_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,Ainflationagg_dev_case5(1,5:25),'--r','LineWidth',2), hold on
        plot(timetoplot,Ainflationagg_dev_case4(1,5:25),':k','LineWidth',2)
        title('CPI inflation (ann.)','Fontsize',30)
        xlim([0 20])

        subplot(nrows,ncols,4)
        plot(timetoplot,Apolicyrate_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,Apolicyrate_dev_case5(1,5:25),'--r','LineWidth',2), hold on
        plot(timetoplot,Apolicyrate_dev_case4(1,5:25),':k','LineWidth',2)
        title('Monetary policy rate (ann.)','Fontsize',30)
        xlim([0 20])
        

        
        legend('Baseline, \gamma_{\pi}=1.5, \gamma_y=0, \gamma_e=0','Taylor rule,  \gamma_{\pi}=1.5, \gamma_y=0.5, \gamma_e=0', 'Augmented Taylor rule,  \gamma_{\pi}=1.5, \gamma_y=0.5, \gamma_e=0.5','Location','Best', 'Orientation', 'horizontal','Fontsize',20)

