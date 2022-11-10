function plot_breakup_time(T,col,mar,sz,fcol,filename,ls,Imu)

figure(2)
%     clf
%     T(1:end,4) = T(1:end,4)./T(1:end,1).^(1/3);
%       T(1:end,5) = T(1:end,5)./T(1:end,1).^(1/3);

    Colors={[1,0,0],[0,1,0],[0,0,1],[1,0.3,0],[1,0.5,0],[1,0.7,0],[1,0.9,0]}
    for I=Imu
    mu = T(I:7:end,1); we = T(I:7:end,2); tb = T(I:7:end,4); std = T(I:7:end,5);
    errorbar(we,tb,std,'Color',Colors{I},'LineWidth',2,'LineStyle',ls); hold on;
    end
    
%     mu = T(2:7:end,1); we = T(2:7:end,2); tb = T(2:7:end,4); std = T(2:7:end,5);
%     errorbar(we,tb,std,'Color',[0,1,0],'LineWidth',2,'LineStyle',ls); hold on;
%     
%     mu = T(3:7:end,1); we = T(3:7:end,2); tb = T(3:7:end,4); std = T(3:7:end,5);
%     errorbar(we,tb,std,'Color',[0,0,1],'LineWidth',2,'LineStyle',ls); hold on;
% %     
%     mu = T(4:7:end,1); we = T(4:7:end,2); tb = T(4:7:end,4); std = T(4:7:end,5);
%     errorbar(we,tb,std,'Color',[1,0.3,0],'LineWidth',2,'LineStyle',ls); hold on;
%     
%     mu = T(5:7:end,1); we = T(5:7:end,2); tb = T(5:7:end,4); std = T(5:7:end,5);
%     errorbar(we,tb,std,'Color',[1,0.5,0],'LineWidth',2,'LineStyle',ls); hold on;
%     
%     mu = T(6:7:end,1); we = T(6:7:end,2); tb = T(6:7:end,4); std = T(6:7:end,5);
%     errorbar(we,tb,std,'Color',[1,0.7,0],'LineWidth',2,'LineStyle',ls); hold on;
%      mu = T(7:7:end,1); we = T(7:7:end,2); tb = T(7:7:end,4); std = T(7:7:end,5);
%     errorbar(we,tb,std,'Color',[1,0.9,0],'LineWidth',2,'LineStyle',ls); hold on;

    legends = {'$\mu=0.01$','$\mu=0.1$','$\mu=1$','$\mu=10$','$\mu=50$','$\mu=100$','$\mu=150$'};
    legend(legends{Imu},'Location','northeastoutside','Interpreter','latex');
    % legend('Re 150 L9','Location','northeast');
    
    xlabel('We','Interpreter','latex');
    
%     ylabel('$t_b/(t_c \mu_d^{(1/3)})$','Interpreter','latex');
  ylabel('$t_b/t_c$','Interpreter','latex');
    % yline(1,'k');
    set(gcf,'Color','w');
    set(gca,'XScale','log');
    set(gca,'YScale','log');
    
    set(gca,'FontSize',20);
    set(gca,'YTick',[1,2,3,10,30]);
    axis([2 12 0.3 100]);
    set(gcf,'Position',[1015         294         782         529]);
    % filename = sprintf(append(Folder_sufs{i_folder},'.xlsx'), '_tb.png'));
    export_fig(filename);

end