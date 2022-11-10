%% Add path for the export_fig function and small functions
addpath('.\FigureExport_GithubRepo')
addpath('.\SmallFunctions\')

%% Task
task = 3.5;

%% Foldername
Folder_sufs = {'Re38L8','Re38L9','Re55L8','Re55L9','Re77L8','Re77L9','Re150L9'};

%% Parameter space
wes = [2,3,4,5,6,7,8,9,10];
mus = [0.01,0.1,1,10,50,100,150];
ts = [80,90,100,110,120,130,140,150,160,170];

%% Task1: a Occurence for Oh number for all
if task == 1
close all
cls = {'k','k','b','b','r','r','m'};
lines = {'--','-','--','-','--','-','-'};
for i_folder = 1:numel(Folder_sufs)
data = readtable(append('.\Data\',Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
T = table2array(data);
plot_breakup_boolean(T,'k','o',200,'k',i_folder,Folder_sufs,cls{i_folder},0,1.8,lines{i_folder});
end
legend(Folder_sufs)
end

%% Task1: b Occurence for Oh number for each case
if task == 1.5
cls = {'k','k','b','b','r','r','m'};
lines = {'--','-','--','-','--','-','-'};
for i_folder = 1:numel(Folder_sufs)
    close all
    data = readtable(append('.\Data\',Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
    T = table2array(data);
    plot_breakup_boolean(T,'k','o',200,'k',i_folder,Folder_sufs,'k',1,1.8,'-');
end
legend(Folder_sufs)
end


%% Task2: a plot tb vs we with different Re
if task == 2
for mu = [1, 4, 5]
    close all
    for i_folder = 1:numel(Folder_sufs)
    data = readtable(append('.\Data\',Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
    T = table2array(data);
    plot_breakup_time(T,'k','o',200,'k','nothing','-',mu,i_folder)
    end
    filename = append('.\Images\tblinear',num2str(mu),'.png');
    legend(Folder_sufs)
    export_fig(filename)
end

end

%%  Task2: b plot tb vs mu at we=10 with different Re
if task == 2.5
    close all
    for i_folder = 1:numel(Folder_sufs)
    data = readtable(append('.\Data\',Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
    T = table2array(data);
    Colors={[1,0,0],[0,1,0],[0,0,1],[1,0.3,0],[1,0.5,0],[1,0.7,0],[1,0.9,0]};
    mu = T(end-6:end,1); we = T(end-6:end,2); tb = T(end-6:end,4); std = T(end-6:end,5);
    disp(we')
    errorbar(mu,tb,std,'Color',Colors{i_folder},'LineWidth',2,'LineStyle','-'); hold on;
    end
    filename = append('.\Images\tbmulog_we',num2str(10),'.png');
    legend(Folder_sufs,'Location','northeastoutside','Interpreter','latex')
    xlabel('$\mu_r$','Interpreter','latex');
    ylabel('$t_b/t_c$','Interpreter','latex');
    set(gcf,'Color','w');
    set(gca,'FontSize',20);
    axis([0.005 160 -5 40]);
%     set(gca,'XScale','log');
%     set(gca,'YScale','log');
%     set(gca,'YTick',[1,2,3,10,30]);
%     set(gca,'XTick',10.^(-2:1:2));
    set(gcf,'Position',[1015         294         782         529]);
    export_fig(filename)
end


%%Task3: child size distribution
%a. calculation
if task == 3
i_folder = 6;
wes = [4 8];
mus = [0.01 10 150];
ts = 60:3:168;
populate_breakup_boolean(i_folder,Folder_sufs,wes,mus,ts)
end

%b. hist.
if task == 3.5
i_folder = 6;
wes = [4 8];
mus = [0.01 10 150];
ts = 60:3:168;
plot_size_dist(i_folder,Folder_sufs,wes,mus,ts)
end















%% Populate Excel for breakupinfo
%% Normal folder
% for i_folder = 6
% populate_breakup_boolean(i_folder,Folder_sufs,wes,mus,ts)
% end


%% Size folder
% i_folder = 6;
% wes=4;
% mus = [0.01 10];
% ts = 60:3:168;
% populate_breakup_boolean(i_folder,Folder_sufs,wes,mus,ts)

% data = readtable(append(Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
% T = table2array(data);
% plot_breakup_boolean(T,'k','o',200,'k',i_folder,Folder_sufs,'k',1,1.8,'-');

%% Plot the breakup boolean for mur and oh
% close all
% cls = {'k','k','b','b','r','r','m'};
% lines = {'--','-','--','-','--','-','-'};
% for i_folder = 1:numel(Folder_sufs)
% data = readtable(append(Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
% T = table2array(data);
% plot_breakup_boolean(T,'k','o',200,'k',i_folder,Folder_sufs,cls{i_folder},0,1.8,lines{i_folder});
% end
% legend(Folder_sufs)


%% Plot the breakup time
%% Separate L8 and L9
% for i_folder = 6
%     close all
% data = readtable(append(Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
% T = table2array(data);
% plot_breakup_time(T,'k','o',200,'k', ...
%     append(Folder_sufs{i_folder},'_tb.png'),'-',1:7);
% end


%% Compare L8 and L9
% for i_folder = 5:6
% cl = '-';
% if mod(i_folder, 2) == 1
% close
% cl = '--';
% end
% data = readtable(append(Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
% T = table2array(data);
% Imu=[1,4,5];
% plot_breakup_time(T,'k','o',200,'k', ...
%     append(Folder_sufs{i_folder},'_tbL8L9.png'),cl,Imu);
% end

%% Diameter tree



%% Droplet number
%% Create droplet number data
% for i_folder = 2:numel(Folder_sufs)
% populate_breakup_boolean(i_folder,Folder_sufs,wes,mus,ts)
% end

