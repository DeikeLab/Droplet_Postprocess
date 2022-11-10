% To calculate the bubble number increasing with time
% If the time is different from different initial conditions
% I will use the liner interpolation to calculate the bubble numbers
% at the time of the inital condition corresponding for the shorstes running time 


Folder_sufs = {'Re38L8','Re38L9','Re55L8','Re55L9','Re77L8','Re77L9','Re150L9'};
i_folder = 5;
wes = [2,3,4,5,6,7,8,9,10];
mus = [0.01,0.1,1,10,50,100,150];
ts = [80,90,100,110,120,130,140,150,160,170];


disp(Folder_sufs{i_folder})
Output_Dat = append(Folder_sufs{i_folder},'.mat');
calculate_mode = 1;
plot_mode = 1;
load(Output_Dat)

[i_num,j_num,k_num] = size(wel);
tp = cell(i_num,j_num);
nump = cell(i_num, j_num, k_num);
nump_averaged = cell(i_num,j_num);


if calculate_mode == 1
    load(Output_Dat)
    break_time_mean = zeros(i_num, j_num);
    break_time_std = break_time_mean;
    break_bool_mean = mean(break_bool, 3) > 0.5; 
    break_bool_ratio = mean(break_bool, 3);
    for i = 1:i_num
        for j = 1:j_num
            we = wes(i); mu = mus(j);  
            [tend_min, k_min] = min(tend(i,j,:)-break_time(i,j,:));
            t_min = num_t{i,j,k_min}-break_time(i,j,k_min);
            tp{i,j} = t_min;
            num_min = zeros(k_num, numel(t_min));
            for k = 1:k_num
                if numel(num_t{i,j,k}) > 0
                [Nb, Ib] = find(num_bubbles{i,j,k}>2);
                num_min(k,:) = interp1(num_t{i,j,k}-break_time(i,j,k),num_bubbles{i,j,k},t_min);
                nump{i,j,k} = num_min(k, :);
                else
                disp([we,mu,k])
                end
            end
            nump_averaged{i,j} = mean(num_min,1);
        end
    end
    save(Output_Dat,'nump','tp','nump_averaged','-append')
end



if plot_mode == 1
    lineshape = {'k-','b-','r-','g-','c-','m-','y-'};
    close
    for i = 1:i_num
        close
        for j = 1:j_num
        plot(tp{i,j},nump_averaged{i,j},lineshape{j},'LineWidth',2);hold on;
        end
        %legend('$\mu_r=0.01$','$\mu_r=0.1$','$\mu_r=1$', ...
        %'$\mu_r=10$','$\mu_r=50$','$\mu_r=100$', '$\mu_r=500$',...
        %'Interpreter','latex','Location','northeastoutside')
    
        xlabel('t/t_c','Interpreter','tex');
        ylabel('N','Interpreter','tex');
        title(strcat('We=',num2str(wes(i))))
        set(gcf,'Color','w');
        set(gca,'FontSize',16);
        set(gcf,'units','centimeters');
        set(gcf,'position',[5,5,20,12])
        imagename = append(Folder_sufs{i_folder},'We',num2str(wes(i)),'num','.jpg');
        saveas(gcf, imagename);
    end
end