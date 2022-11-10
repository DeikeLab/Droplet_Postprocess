% This is a script to test funcitons
module = 3;
%% Test disp module
if module ==1
disp('This is the folder that we are working on:');
disp('a');
end

%% Test populate boolean excel function
if module ==2
Folder_sufs = {'Re38L8','Re38L9','Re55L8','Re55L9','Re77L8','Re77L9','Re150L9'};
i_folder = 1;
wes = [2,3,4,5,6,7,8,9,10];
mus = [0.01,0.1,1,10,50,100,150];
ts = [80,90,100,110,120,130,140,150,160,170];
populate_breakup_boolean(i_folder,Folder_sufs,wes,mus,ts)
end

%% Test diameter trees
if module == 3
Folder_sufs = {'Re38L8','Re38L9','Re55L8','Re55L9','Re77L8','Re77L9','Re150L9'};
i_folder = 1;
wes = [2];
mus = [0.01];
ts = [80,90,100,110,120,130,140,150,160,170];
plot_diameter_trees(i_folder,Folder_sufs,wes,mus,ts)
end

%%
