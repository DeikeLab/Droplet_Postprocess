%% To plot the breakup ratio
%This is a function to call other plotter functions



clear;
figure(1)
clf;
figure(2)
clf;
% plot(NaN,NaN,'k--'); hold on;
% plot(NaN,NaN,'k-');

%% Folder that we are working on
i_folder = 5;
Folder_sufs = {'Re38L8','Re38L9','Re55L8','Re55L9','Re77L8','Re77L9','Re150L9'};

% populate_breakup_boolean(i_folder,Folder_sufs,[2,3,4,5,6,7,8,9,10], ...
%     [0.01,0.1,1,10,50,100,150], ...
%     [80,90,100,110,120,130,140,150,160,170]);


% data = readtable('Re55L8.xlsx','Sheet',2);
% T = table2array(data);
% plot_breakup_boolean(T,'r','d',300,'r'); hold on;
i_folder =1; mul = 7;
data = readtable(append(Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
T = table2array(data);
plot_breakup_boolean(T,'k','o',200,'k',i_folder,Folder_sufs,'k',1,1.8,'-');
plot_breakup_time(T,'k','o',200,'k', ...
    append(Folder_sufs{i_folder},'_tb.png'),'-');
i_folder =3; mul = 7;
data = readtable(append(Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
T = table2array(data);
plot_breakup_boolean(T,'k','o',200,'k',i_folder,Folder_sufs,'k',0,0.9,'-');
% plot_breakup_time(T,'k','o',200,'k', ...
%     append(Folder_sufs{i_folder},'_tb.png'),'-');
i_folder =4;
data = readtable(append(Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
T = table2array(data);
plot_breakup_boolean(T,'k','o',200,'k',i_folder,Folder_sufs,'r',0,0.45,'-');
% plot_breakup_time(T,'r','o',200,'k', ...
%     append(Folder_sufs{i_folder},'_REtb.png'),'-');
% % plot_breakup_time(T,'r','o',200,'k', ...
% %     append(Folder_sufs{i_folder},'_tb.png'),'-');
% i_folder =4;
% data = readtable(append(Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
% T = table2array(data);
% plot_breakup_boolean(T,'k','o',200,'k',i_folder,Folder_sufs,'b',0,0.45,'-');
% plot_breakup_time_reynolds(T,'b','o',200,'k', ...
%     append(Folder_sufs{i_folder},'_REtb.png'),'-',mul);
% i_folder =4;
% data = readtable(append(Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
% T = table2array(data);
% plot_breakup_boolean(T,'k','o',200,'k',i_folder,Folder_sufs,'k',1);
% plot_breakup_time(T,'k','o',200,'k',append(Folder_sufs{i_folder},'_tb.png'),'-');

figure(1)
% yline(3,'Color',[0.7,0.3,0.5],'LineStyle','--','LineWidth',2);
% legend('Re=38 L8','Re=38 L9','Re=55 L8','Re=77 L8','We = 3','Location','northwest');
legend('Re=38 L8','Michal Model'); %,'Re=77 L8','Location','northeast');

export_fig('Re38L8L9_pp.png');

figure(2)
legend('Re=38 L8','Re=55 L8','Re=77 L8','Location','northeast');
title('$\mu_r = 150$','Interpreter','latex');
export_fig('tb_mur_150.png');