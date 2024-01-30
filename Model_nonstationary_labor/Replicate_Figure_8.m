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
labor_case1                = labor_tp3;
labor_dev_case1            = labor_devbgp_tp3;
logwage_dev_case1          = logw_devbgp_tp3;


save Simulations_baseline_IT_nolabor
% 
% Inflation targeting + labor supply shock 
baseline_calibration
ZZETA_iii=0.25;
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
labor_case2                = labor_tp3;
labor_dev_case2            = labor_devbgp_tp3;
logwage_dev_case2          = logw_devbgp_tp3;


save Simulations_IT_labor_nonstationary

close all
clear
clc

load Simulations_baseline_IT_nolabor
close all
logtilwage_dev_case1=zeros(size(logy_dev_case1));
for iii=1:26
   logtilwage_dev_case1(1,iii)=100*(logtilw(1,94+iii)-logtilw(1,99));
end

load Simulations_IT_labor_nonstationary
close all
logtilwage_dev_case2=zeros(size(logy_dev_case2));
for iii=1:26
   logtilwage_dev_case2(1,iii)=100*(logtilw(1,94+iii)-logtilw(1,99));
end


nrows=3;
ncols=2;


        
f=figure(1)
f.Position = [100 100 1200 500];

        subplot(nrows,ncols,1)
        plot(timetoplot,labor_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,labor_dev_case2(1,5:25),'--r','LineWidth',2);
        title('Labor supply','Fontsize',16)
        xlim([0 20])
        
        subplot(nrows,ncols,2)
        plot(timetoplot,logtilwage_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logtilwage_dev_case2(1,5:25),'--r','LineWidth',2)
        title('Real Wage','Fontsize',16)
        xlim([0 20])

        subplot(nrows,ncols,3);
        plot(timetoplot,logy_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logy_dev_case2(1,5:25),'--r','LineWidth',2)
        title('Output','Fontsize',16)
        xlim([0 20])
        
        subplot(nrows,ncols,4)
        plot(timetoplot,logdeltae_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,logdeltae_dev_case2(1,5:25),'--r','LineWidth',2);
        title('Nom. exchange rate (ann. growth rate)','Fontsize',16)
        xlim([0 20])

        subplot(nrows,ncols,5);
        plot(timetoplot,Ainflationagg_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,Ainflationagg_dev_case2(1,5:25),'--r','LineWidth',2);
        title('CPI inflation (ann.)','Fontsize',16)
        xlim([0 20])

        subplot(nrows,ncols,6)
        plot(timetoplot,Apolicyrate_dev_case1(1,5:25),'-b','LineWidth',2), hold on
        plot(timetoplot,Apolicyrate_dev_case2(1,5:25),'--r','LineWidth',2);
        title('Monetary policy rate (ann.)','Fontsize',16)
        xlim([0 20])
        
        legend('Baseline','Labor supply shock','Location','Best', 'Orientation', 'horizontal','Fontsize',14)



