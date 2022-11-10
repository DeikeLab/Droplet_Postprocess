function plot_breakup_time_reynolds(T,col,mar,sz,fcol,filename,ls,mul)

figure(2)
%     clf
    
    mu = T(mul:7:end,1); we = T(mul:7:end,2); tb = T(mul:7:end,4); std = T(mul:7:end,5);
    errorbar(we,tb,std,'Color',col,'LineWidth',2,'LineStyle',ls); hold on;
% figure(3)    
%     mu = T(2:7:end,1); we = T(2:7:end,2); tb = T(2:7:end,4); std = T(2:7:end,5);
%     errorbar(we,tb,std,'Color',col,'LineWidth',2,'LineStyle',ls); hold on;
%  figure(4)   
%     mu = T(3:7:end,1); we = T(3:7:end,2); tb = T(3:7:end,4); std = T(3:7:end,5);
%     errorbar(we,tb,std,'Color',col,'LineWidth',2,'LineStyle',ls); hold on;
%  figure(5)   
%     mu = T(4:7:end,1); we = T(4:7:end,2); tb = T(4:7:end,4); std = T(4:7:end,5);
%     errorbar(we,tb,std,'Color',col,'LineWidth',2,'LineStyle',ls); hold on;
%  figure(6)   
%     mu = T(5:7:end,1); we = T(5:7:end,2); tb = T(5:7:end,4); std = T(5:7:end,5);
%     errorbar(we,tb,std,'Color',col,'LineWidth',2,'LineStyle',ls); hold on;
%  figure(7)   
%     mu = T(6:7:end,1); we = T(6:7:end,2); tb = T(6:7:end,4); std = T(6:7:end,5);
%     errorbar(we,tb,std,'Color',col,'LineWidth',2,'LineStyle',ls); hold on;
%  figure(8)
%     mu = T(7:7:end,1); we = T(7:7:end,2); tb = T(7:7:end,4); std = T(7:7:end,5);
%     errorbar(we,tb,std,'Color',col,'LineWidth',2,'LineStyle',ls); hold on;

%     legend('$\mu=0.01$','$\mu=0.1$','$\mu=1$','$\mu=10$','$\mu=50$','$\mu=100$','$\mu=150$', ...
%         'Location','northeastoutside','Interpreter','latex');
    % legend('Re 150 L9','Location','northeast');
    
    xlabel('We','Interpreter','latex');
    
    ylabel('$t_b/t_c$','Interpreter','latex');
    % yline(1,'k');
    set(gcf,'Color','w');
    set(gca,'XScale','log');
    set(gca,'YScale','log');
    
    set(gca,'FontSize',20);
    set(gca,'YTick',[1,2,3,10,30]);
    axis([2 12 0.3 30]);
    set(gcf,'Position',[1015         294         782         529]);
    % filename = sprintf(append(Folder_sufs{i_folder},'.xlsx'), '_tb.png'));
%     export_fig(filename);

end