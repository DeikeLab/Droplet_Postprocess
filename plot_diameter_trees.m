%% Purpose: plot diameter trees

function plot_diameter_trees(i_folder,Folder_sufs,wes,mus,ts)
    %% Check the input
    if mod(i_folder, 2) ~= 1
        disp("Please input a odd i_folder number for this function")
    end

    %% Prepare working folders
    foldernameL8 = Foldername(i_folder, Folder_sufs);
    foldernameL9 = Foldername(i_folder+1, Folder_sufs);
    disp('folders that we are working on:')
    disp(foldernameL8);
    disp(foldernameL9);

    %% Initialize parameters
    wec=0; muc =0; tc=0; %count for the we, mu and t
    d0=16; epsilon = 10; 
    te = d0^(2/3)*epsilon^(-1/3);
    %minvolL8 = 8*(120/2^8)^3;

    %% Do the loop
    for we = wes
        wec = wec + 1 ;
        muc = 0; tc = 0;
        %Calculate dh here, is function of gamma(We)
        %dh is the Hinze scale. 
        % See Eq. 1.2 in Rivere et. al.2021
        %critical We,density of outside, viscous diss
        wecr = 3; rhow = 1; 
        gamma = 2*rhow*epsilon^(2/3)*d0^(5/3)/we;
        dh = (wecr/2)^(3/5)*(gamma/rhow)^(3/5)*epsilon^(-2/5);
        for mu = mus
            muc = muc + 1 ;
            tc = 0;
            for t = ts
                tc = tc + 1;
                filenameL8 = sprintf('We_%g_Mu_%g_t_%g*.dat',we,mu,t);
                files = dir(append(foldernameL8, filenameL8));
                if isempty(files)
                    continue;
                    disp([we, mu, t]);
                end
                dataL8 = read_files(foldernameL8, files);
                filestepL8 = dataL8(:,1);
                timeL8 = (dataL8(:,2)-t)/te;
                drop_idL8 = dataL8(:,3);
                drop_volL8 = dataL8(:,4);
                drop_diaL8bydh = (6*drop_volL8/pi).^(1/3)/dh;
    
                filenameL9 = sprintf('We_%g_Mu_%g_t_%g*.dat',we,mu,t);
                files = dir(append(foldernameL9, filenameL9));
                if isempty(files)
                    continue;
                    disp([we, mu, t]);
                end
                dataL9 = read_files(foldernameL9, files);
                filestepL9 = dataL9(:,1);
                timeL9 = (dataL9(:,2)-t)/te;
                drop_idL9 = dataL9(:,3);
                drop_volL9 = dataL9(:,4);
                drop_diaL9bydh = (6*drop_volL9/pi).^(1/3)/dh;
                filenameL8L9 = sprintf('d_by_dh_L8L9_We_%g_Mu_%g_t_%g.png',we,mu,t);
    
                hold off
                plot(timeL8,drop_diaL8bydh,'ko'); hold on
                plot(timeL9,drop_diaL9bydh,'ro'); hold on
                dxL8m4 = 120/2^8 * 4/dh;
                dxL8m8 = 120/2^8 * 8/dh;
                dxL9m4 = 120/2^9 * 4/dh;
                dxL9m8 = 120/2^9 * 8/dh;
                yline(dxL8m4,'k--');
                yline(dxL8m8,'k');
                yline(dxL9m4,'r--');
                yline(dxL9m8,'r');
                xlabel('$t/t_c$','Interpreter','latex');
                ylabel('$d/d_h$','Interpreter','latex','rotation',90);
                legend('L8','L9','4\Delta x L8','8\Delta x L8', ...
                    '4\Delta x L9','8\Delta x L9','location','northeastoutside')
                
                set(gcf,'Color','w');
                set(gca,'FontSize',15);
                set(gca,'Position',[0.1029    0.1443    0.6135    0.7807]);
                mkdir(append(foldernameL8,'trees'));
                saveas(gcf,append(foldernameL8,'trees/',filenameL8L9))
                disp(append(filenameL8L9,'saved'));
    
            end
        end
    end
    


end