%


% clear;
function plot_breakup_nums(T,col,mar,sz,fcol,i_folder,Folder_sufs,cl,plotscatter,mul,ls)
    filename = append(Folder_sufs{i_folder},'num.png');
    figure(1)
    %clf
    muvec = T(:,1); wevec = T(:,2); probability_alpha = T(:,3);
    mean_breakup_time = T(:,4); std_breakup_time = T(:,5);
  d0 = 16; epsilon = 10; rhod=1; rhoc=1;
  sigma = (2*rhoc*d0^(5/3)*epsilon^(2/3))./wevec;
c8=1.5; c9=0.5;
    ohvec = muvec.*mul./(sigma.*d0*rhod).^0.5;
    vivec = (rhoc/rhod)^0.5*muvec.*mul.*(d0)^(1/3).*epsilon^(1/3)./sigma;
    pbrvec = exp(-c8*(1+c9.*vivec)./wevec);

    kk=1;
    
 for i=1:9
        for j=1:7
            muvecg(i,j) = muvec(kk);
            ohvecg(i,j) = ohvec(kk);
            wevecg(i,j) = wevec(kk);
            vivecg(i,j) = vivec(kk);
            pbrvecg(i,j) = pbrvec(kk);
            if probability_alpha(kk)<0
                probability_alpha(kk) = (i_folder~=6);
                disp("Mu    We")
                disp([muvec(kk),wevec(kk)])

            end
            pgrid(i,j) = probability_alpha(kk);
            
            kk = kk + 1;
            
        end
 end
%  muvecg(end+1,:) = muvecg(end,:);
%  ohvecg(end+1,:) = ohvecg(end,:);
%  wevecg = [2*ones(1,numel(wevecg(1,:)));wevecg];
%  pgrid = [-1*ones(1,numel(pgrid(1,:)));pgrid];

contour(muvecg,wevecg,pgrid,[0.5 0.5],'Color',cl,'LineWidth',2,'LineStyle',ls); hold on;

% contour(vivecg,wevecg,pgrid,[0.5 0.5],'Color',cl,'LineWidth',2,'LineStyle',ls); hold on;
% contour(vivecg,wevecg,pbrvecg,[0.5 0.5],'Color','r','LineWidth',2); hold on;

% colormap jet;
if (plotscatter)
   
    s = scatter(muvec,wevec,sz,'filled','Marker',mar, ...
        'MarkerFaceColor',fcol,'MarkerEdgeColor',col,'MarkerEdgeAlpha',1);

  
    s.AlphaData = probability_alpha';
    s.MarkerFaceAlpha = 'flat';
%     s.MarkerEdgeAlpha = 'flat';
    
    gscale = 1:-0.01:0;
    mapcustom = [gscale', gscale',gscale'];
    colormap(mapcustom);
    c = colorbar;
    caxis([0, 1]);
    c.Label.String = 'Breakage Probability';
end
%     s.AlphaData = 1;
% legend('Re 55 L8','Location','northeast');

legend(append(Folder_sufs{i_folder},' '),'Location','northeast');
% legend('Re 150 L9','Location','northeast');

xlabel('$\mu_r$','Interpreter','latex');
% xlabel('Oh','Interpreter','latex');
% xlabel('Vi','Interpreter','latex');

ylabel('We');
set(gcf,'Color','w');
set(gca,'FontSize',20);
axis([0 300 0 12]);
set(gcf,'Position',[318    82   782   732]);
  set(gca,'XScale','log');
% filename = sprintf('Re38L8.png');
export_fig(filename);
end




