%% This is a function to read multiple files
function data = read_files(Folder,files)
        data = [];
        for fi =1:length(files)
            temp = importdata(append(Folder,files(fi).name));
            if fi == 1 %If first *.dat file, start from the first line
                Is=1;
            else % if not, find the line that has both larger computational step and physical time than the end of data
                Is = max(find(temp(:,1)>data(end,1),1),find(temp(:,2)>data(end,2),1));
            end
            data = [data; temp(Is:end-1,:)]; % Put all these data together
        end
end
