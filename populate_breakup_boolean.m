% To calculate the break-up time
% Break-up criterion: produce a droplet larger than 4dx^3 or 8dx^3

%Data structure in every dat file
%Computational step// Physical time// Droplet id// 
%Droplet volume//  Mass center position x,y,z//  Droplet area//
%Note that there is no order in the subdroplets 


% clear;
function populate_breakup_boolean(i_folder,Folder_sufs,wes,mus,ts)


    %% small one line function for filename
    Filename = @(we,mu,t) sprintf('We_%g_Mu_%g_t_%g*.dat',we,mu,t);

    %% Test mode
    Test_mode = 0; % 1 -- Run the simulation for a single case 0 -- Loop for all cases
    
    %% Folder that we are working on
    Folder = Foldername(i_folder, Folder_sufs);
    Output_File = append(Folder_sufs{i_folder},'.xlsx');
    Output_Dat = append(Folder_sufs{i_folder},'.mat');
    disp(Folder)
    %% Physical parameter
    epsilon = 10;   %turbulence dissipation rate
    rho =1;     %density ratio 
    d0 =16;     %diameter of the bubble
    te = d0^(2/3) * epsilon^(-1/3); %eddy turover time at the bubble scale
    
    %% Criterion for break-up size
    dxL8m4 = 120/2^8 * 4;
    dxL9m4 = 120/2^9 * 4;
    % dxL8m8 = 120/2^8 * 8;
    % dxL9m8 = 120/2^9 * 8;
    
    if ~contains(Folder,'L9')
        dxc = dxL8m4;  %4 grid spacing L8
    else
        dxc = dxL9m4;  %4 grid spacing L9
    end
    Vc = dxc^3 * pi /6.0; %volume of sphere of dia of 4 grid spacing
    
    
    %% Loop index
    if Test_mode == 1
        i_index = 4; %we=3
        j_index = 5; %mu=0.1
        k_index = 5; %t=80    
    else
        i_index = 1:length(wes);
        j_index = 1:length(mus);
        k_index = 1:length(ts);
    end
    
    %% Output varibles initialization
    i_num = length(i_index); j_num=length(j_index); k_num=length(k_index);
    tend = zeros(i_num, j_num, k_num); %The end time of the simulation
    break_bool = tend; %the break up boolean
    break_time = tend; %the break up time
    wel = tend; mul = tend; tl = tend;
    num_bubbles = cell(i_num,j_num,k_num);
    num_t = cell(i_num,j_num,k_num);
    
    %% Do the loop
    %% Case info
    for i = i_index
        for j = j_index
            for k = k_index
                we = wes(i); mu = mus(j); t = ts(k);
                disp([we,mu,t])
                wel(i,j,k)=we; mul(i,j,k)=mu; tl(i,j,k)=t;
                file = strcat(Folder, Filename(we, mu , t));
                files = dir(file);
                if (length(files)==0 || ~exist(append(Folder,files(1).name),"file"))
                    tend(i,j,k)=-1;
                    break_bool(i,j,k) =-1;
                    break_time(i,j,k) =-1;
                    continue
                end
                
                data = [];
                for fi =1:length(files)
                    temp = importdata(append(Folder,files(fi).name));
                    if fi == 1
                        Is=1;
                    else
                        Is = max(min(find(temp(:,1)>data(end,1))),min(find(temp(:,2)>data(end,2))));
                    end
  
                    data = [data; temp(Is:end-1,:)] ;
                end
                step_comp = data(:,1);
                [v, w] = unique( step_comp, 'stable' );
                tend(i,j,k) = (data(end-1,2) - t)/te; 
                if w(end) ~= numel(step_comp) %Final step more than one droplet
                    w(end+1) = numel(step_comp)+1;
                end
    
                %Note that when there are multiple droplets, their data will be
                %output with the same computational step in dat file
                number = zeros(1,(numel(w)-1)); number_t = number;
                for nw = 1: (numel(w)-1) %Jump between different computational step
                        droplet_sizes = data(w(nw) : (w(nw+1)-1),4);
                        number(nw) = length(find(droplet_sizes>Vc));
                        number_t(nw) = (data(w(nw),2)-t)/te;
                    if w(nw+1) - w(nw) > 1 %more than one droplet
                        if length(find(droplet_sizes>Vc))>=2 && break_bool(i,j,k)==0 %more than 2 droplets large enough
                            break_bool(i,j,k) = 1;
                            break_time(i,j,k) = (data(nw,2) - t)/te;
                        end
                    end
                end
                num_bubbles{i,j,k} = number;
                num_t{i,j,k} = number_t;
    
    
    
            end
        end
    end

     output_xlsx(break_bool,break_time,tend,wel,mul,tl,Folder_sufs,i_folder,Output_File)
save(Output_Dat,'break_bool','break_time','tend','wel','mul','tl','Folder_sufs','num_bubbles','num_t')
    %% Statistics info
    break_bool_probability = mean(break_bool,3);
    [mugrid, wegrid] = meshgrid(mus,wes);
    % clf
    % contourf(mugrid,wegrid,break_bool_probability,'EdgeColor','none');
    % colormap cool;
    % c = colorbar;
    % c.Label.String = 'Breakup Probability';
    % hold on;
    
    probability_color = []; probability_alpha = []; stdev_breakup_time = [];
    mean_breakup_time = [];
    muvec = []; wevec = [];
    for i=1:numel(wes)
        for j=1:numel(mus)
            muvec = [muvec; mus(j)];
            wevec = [wevec; wes(i)];
            probability_alpha = [probability_alpha; break_bool_probability(i,j) ];
            probability_color = [probability_color; break_bool_probability(i,j),0.5,0.5];
            mean_breakup_time = [mean_breakup_time; mean(nonzeros(break_time(i,j,:)))];
            stdev_breakup_time = [stdev_breakup_time; std(nonzeros(break_time(i,j,:)))];
        end
    end

   T = table(muvec,wevec,probability_alpha,mean_breakup_time,stdev_breakup_time);
   
    writetable(T,Output_File,'Sheet',strcat(Folder_sufs{i_folder},'_mean_stats'),'Range','A1')
   

end




