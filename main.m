%% Add path for the export_fig function
addpath('.\FigureExport_GithubRepo')

%% Foldername
Folder_sufs = {'Re38L8','Re38L9','Re55L8','Re55L9','Re77L8','Re77L9','Re150L9'};
i_folder = 6;

%% Parameter space
wes = [2,3,4,5,6,7,8,9,10];
mus = [0.01,0.1,1,10,50,100,150];
ts = [80,90,100,110,120,130,140,150,160,170];

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
for i_folder = 5:6
cl = '-';
if mod(i_folder, 2) == 1
close
cl = '--';
end
data = readtable(append(Folder_sufs{i_folder},'.xlsx'),'Sheet',2);
T = table2array(data);
Imu=[1,4,5];
plot_breakup_time(T,'k','o',200,'k', ...
    append(Folder_sufs{i_folder},'_tbL8L9.png'),cl,Imu);
end

%% Diameter tree



%% Droplet number
%% Create droplet number data
% for i_folder = 2:numel(Folder_sufs)
% populate_breakup_boolean(i_folder,Folder_sufs,wes,mus,ts)
% end

