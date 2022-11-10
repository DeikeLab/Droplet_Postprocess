%%Note the input should be:
%wes = [2,3,4,5,6,7,8,9,10];
% mus = [0.01,0.1,1,10,50,100,150];
% ts = [80,90,100,110,120,130,140,150,160,170];

%if you gives wes=[3], the actual output is just we = 2 case

function plot_size_dist(i_folder,Folder_sufs,wes,mus,ts)
    %% Display info
    disp("This is the folder that we are working on:")
    disp(Folder_sufs{i_folder})

    %% Size info of the mother drop
    d0 =16;     %diameter of the bubble
    V0 = 4 * pi/ 3 * d0^3 /8;

    %% Load data
    Output_Dat = append('./Data/sizes',Folder_sufs{i_folder},'.mat');
    load(Output_Dat);
    calculate_mode = 1;
    plot_mode = 1;
    
    i_num = numel(wes);
    j_num = numel(mus);
    k_num = numel(ts);
    num_break = sum(break_bool,3);
    size_total = cell(i_num, j_num);

    
    
    if calculate_mode == 1
        for i = 1:i_num
            for j = 1:j_num
                size_total{i,j}=[];
                for k = 1:k_num
                    if ~isempty(sizes{i,j,k})
                        size_total{i,j}=[size_total{i,j};sizes{i,j,k}];     
                    end
                end
            end
        end

    end
    
    
    
    if plot_mode == 1
        lineshape = {'k-','b-','r-','g-','c-','m-','y-'};
        close
        for i = 1:i_num
            for j = 1:j_num
                close
                his = histogram( (size_total{i,j}./V0).^(1/3));
                his
                his.BinEdges =  0:0.05:1
 
            %legend('$\mu_r=0.01$','$\mu_r=0.1$','$\mu_r=1$', ...
            %'$\mu_r=10$','$\mu_r=50$','$\mu_r=100$', '$\mu_r=500$',...
            %'Interpreter','latex','Location','northeastoutside')
        
%             xlabel('t/t_c','Interpreter','tex');
%             ylabel('N','Interpreter','tex');
             title(strcat('We=',num2str(wes(i)),' Mu=',num2str(mus(j))))
                set(gcf,'Color','w');
%             set(gca,'FontSize',16);
%             set(gcf,'units','centimeters');
% %             set(gcf,'position',[5,5,20,12])
             legend(append('number of break cases: ',num2str(num_break(i,j))),'Location','northoutside')
            imagename = append('./Images/',Folder_sufs{i_folder},'We',num2str(wes(i)),'Mu',num2str(mus(j)),'dist_d','.jpg');
            saveas(gcf, imagename);
            pause
            end
        end
    end

end