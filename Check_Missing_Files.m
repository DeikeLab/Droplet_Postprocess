%To check the files exists or not for (We, mu, tst) for different Re, L8/L9

Folder_sufs = {'Re55L8sweep','Re38L9','55','55L9','Re77L8sphericity','Re77L9','150','150L9'};
Num_folder = length(Folder_sufs);

%% Check folder exists or not
for i = 1: Num_folder
    Folder = Foldername(i,Folder_sufs);
    assert(exist(Folder,"dir"),strcat('Missing Folder ',Folder));
end
disp("All folders exist");

%% Number of files
wes = [3,4,5,6,7,8,9,10];
mus = [0.01,0.1,1,10,50,100,150];
ts = [80,90,100,110,120,130,140,150,160,170];

%% Check file exists
filename = 'MissingFiles.xlsx';
for i = 1: Num_folder
    Folder = Foldername(i,Folder_sufs);
    we_list = [];
    mu_list = [];
    t_list = [];
    exist_list=[];
    for we = wes
        for mu = mus
            for t =ts
                file = strcat(Folder,Filename(we, mu, t));
                we_list(end+1,1) = we;
                mu_list(end+1,1) = mu;
                t_list(end+1,1) = t;
                if exist(file,"file")
                    exist_list(end+1,1) = 1;
                else
                    exist_list(end+1,1) = 0;
                end
            end
        end
    end
    T = table(we_list,mu_list,t_list,exist_list);
    writetable(T,filename,'Sheet',Folder_sufs{i},'Range','A1')
end




%% Access folders
function foldername = Foldername(i,Folder_sufs)
    Directory = 'G:\.shortcut-targets-by-id\1yy0LEVWRsT1lGxOaqULoHgajAkevh3h0\BASF\';
    Folder_pre = 'dist_';
    foldername = strcat(Directory,Folder_pre,Folder_sufs{i},'\');
end

%% File name producer
function filename = Filename(we,mu,t)
filename = sprintf('We_%g_Mu_%g_t_%g.dat',we,mu,t);
end