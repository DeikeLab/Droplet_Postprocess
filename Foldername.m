%% Access folders
function foldername = Foldername(i,Folder_sufs)
    Directory = 'G:\.shortcut-targets-by-id\1yy0LEVWRsT1lGxOaqULoHgajAkevh3h0\BASF\';
    Folder_pre = 'dist_';
    foldername = strcat(Directory,Folder_pre,Folder_sufs{i},'\');
end