% To calculate the break-up time
% Break-up criterion: produce a droplet larger than 4dx^3 or 8dx^3
% Problem solved: inconsistency between break-up time and diameter tree

%Date:10/12/2022
%Coder: Zehua Liu
%Revised based on mu_ratio_loop77L9.m by Palas(https://drive.google.com/file/d/1WaAh1hZZ2KA9jLIE7tbjY9czPxhsATrP/view?usp=sharing)

%Data structure in every dat file
%Computational step// Physical time// Droplet id// 
%Droplet volume//  Mass center position x,y,z//  Droplet area//
%Note that there is no order in the subdroplets 
clear;
%% Test mode
Test_mode = 0; % 1 -- Run the simulation for a single case 0 -- Loop for all cases

%% Folder that we are working on
% i_folder =5;

populate_breakup_boolean(5,[3,4,5,6,7,8,9,10], ...
    [0.01,0.1,1,10,50,100,150], ...
    [80,90,100,110,120,130,140,150,160,170]);

% plot_breakup_boolean(i_folder);

xlabel('$\mu_r$','Interpreter','latex');

ylabel('We');
set(gcf,'Color','w');
set(gca,'FontSize',16);
axis([0.001 400 0 12]);
filename = sprintf('We_vs_murm.png');
% disp(tend)
% disp(break_bool)
% disp(break_time)
%% Output xlsx
% output_xlsx(break_bool,break_time,tend,wel,mul,tl,Folder_sufs,i_folder,Output_File)











%% File name producer
