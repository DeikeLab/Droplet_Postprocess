%% This is the function to create diameter trees
%% Todo: revise this function to read multiple files
%% Store the image outside

%clear
wec=0; muc =0; tc=0; d0=16; epsilon = 10;
te = d0^(2/3)*epsilon^(-1/3);


%change weber number
webers = 1:10;
mus = [0.01,0.1,1,10,50,100,150]; %7
ts = 80:10:170; %10
minvolL8 = 8*(120/2^8)^3;
% figure(1)
% clf
% figure(2)
% clf
for we = webers
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
            we
            mu
            t
            tc = tc + 1;
            filenameL8 = sprintf('We_%g_Mu_%g_t_%g*.dat',we,mu,t);
            files = dir(append(foldernameL8, filenameL8));
            if isempty(files)
                continue;
            end
            dataL8 = [];
            for fi =1:length(files)
                temp = importdata(append(foldernameL8,files(fi).name));
                dataL8 = [dataL8; temp(1:end-1,:)] ;
            end
            filestepL8 = dataL8(:,1);
            timeL8 = (dataL8(:,2)-t)/te;
            drop_idL8 = dataL8(:,3);
            drop_volL8 = dataL8(:,4);
            drop_diaL8bydh = (6*drop_volL8/pi).^(1/3)/dh;

            filenameL9 = sprintf('We_%g_Mu_%g_t_%g*.dat',we,mu,t);
            files = dir(append(foldernameL9, filenameL9));
            if isempty(files)
                continue;
            end
            dataL9 = [];
            for fi =1:length(files)
                temp = importdata(append(foldernameL9,files(fi).name));
                dataL9 = [dataL9; temp(1:end-1,:)] ;
            end
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

%export_fig(filenameL8L9);
