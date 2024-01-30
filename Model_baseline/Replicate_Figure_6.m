plot_welfare_baseline; %baseline welfare

plot_welfare_no_disasters; % welfare no disasters

plot_welfare_higherdamage; % welfare larger damages

plot_welfare_higherdisfeq; % welfare higher frequency



f=figure(1)
f.Position = [100 100 1200 500];
subplot (1,3,1)
plot(parameter_vector_GAMMA_PI, welf_vector_GAMMA_PI_baseline,'-k','LineWidth',2), hold on
plot(parameter_vector_GAMMA_PI, welf_vector_GAMMA_PI_no_disasters,'--r','LineWidth',2), hold on
plot(parameter_vector_GAMMA_PI, welf_vector_GAMMA_PI_higherdamage,':b','LineWidth',2), hold on
plot(parameter_vector_GAMMA_PI, welf_vector_GAMMA_PI_higherdisfeq,'-.g','LineWidth',2), hold on
axis tight
xlabel('Resp. to inflation, \gamma_{\pi}')
ylabel('Welfare level')
subplot (1,3,2)
plot(parameter_vector_GAMMA_Y, welf_vector_GAMMA_Y_baseline,'-k','LineWidth',2), hold on
plot(parameter_vector_GAMMA_Y, welf_vector_GAMMA_Y_no_disasters,'--r','LineWidth',2), hold on
plot(parameter_vector_GAMMA_Y, welf_vector_GAMMA_Y_higherdamage,':b','LineWidth',2), hold on
plot(parameter_vector_GAMMA_Y, welf_vector_GAMMA_Y_higherdisfeq,'-.g','LineWidth',2), hold on
axis tight
xlabel('Resp. to output, \gamma_y')
ylabel('Welfare level')
subplot (1,3,3)
plot(parameter_vector_GAMMA_E, welf_vector_GAMMA_E_baseline,'-k','LineWidth',2), hold on
plot(parameter_vector_GAMMA_E, welf_vector_GAMMA_E_no_disasters,'--r','LineWidth',2), hold on
plot(parameter_vector_GAMMA_E, welf_vector_GAMMA_E_higherdamage,':b','LineWidth',2), hold on
plot(parameter_vector_GAMMA_E, welf_vector_GAMMA_E_higherdisfeq,'-.g','LineWidth',2), hold on
axis tight
xlabel('Resp. to exchange rate, \gamma_e')
ylabel('Welfare level')
legend('Baseline', 'No disasters', 'Larger damages (1.5x)', 'Higher frequency (1.5x)', 'No impact on exp. dem.', 'Orientation', 'Horizontal')




