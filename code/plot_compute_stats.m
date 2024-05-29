function [Pstruct,Hstruct] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idx, printFigs, figureName, data)
% Plots and computes statistics of a certain metric given by data
hFig = figure;
set(hFig, 'Name', figureName, 'color', 'w')
labels = categorical(isParkinson);
labels(isParkinson) = "PD";
labels(~isParkinson) = "Control";
for iChannels=1:nChannels+1
    subplot(nRow, nCol, iChannels)
    if iChannels<=nChannels
        controlData = data(~isParkinson,iChannels);
        PDdata = data(isParkinson,iChannels);
        % idx2include = [3 4 6 10 12 13 15 17 18 19];
        idx2include = 1:20;
        PDdata = PDdata(idx2include);
        % labels = labels([1:9 end-5:end]);
        boxplot([PDdata; controlData], labels,  'Colors', [PDcolor; controlColor]);
        hold on;
        x1 = 2*ones([sum(labels=="Control") 1]);
        x2 = ones([sum(labels=="PD") 1]);
        h1 = scatter(x1,controlData,'filled','MarkerFaceAlpha',0.6','jitter','on','jitterAmount',0.15);
        h1.CData = controlColor;
        h2 = scatter(x2,PDdata,'filled','MarkerFaceAlpha',0.6','jitter','on','jitterAmount',0.15);
        h2.CData = PDcolor;
        [Pstruct(iChannels).P,Hstruct(iChannels).H] = ranksum(controlData, PDdata);
%         if iChannels == 5
%             ylabel(myYLabel, 'FontSize', myFontSize)
%         end
        title(sprintf('ch%d p=%0.3f', idx(iChannels),Pstruct(iChannels).P))
    else
        plot([0 0],[1 1], '-', 'Color', PDcolor, 'LineWidth', 2)
        hold on
        plot([0 0],[1 1], ':', 'Color', controlColor, 'LineWidth', 2)
        legend({'PD' 'Control'}, 'Location', 'EastOutside')
%         axis off
        ylabel(myYLabel, 'FontSize', myFontSize)
        set(gca, 'XTick', [], 'YTick', [])
    end
    set(gca,'FontSize', myFontSize)
end
% Specify window units
set(hFig, 'units', 'inches')
% Change figure and paper size
set(hFig, 'Position', [0.1 0.1 15 10])
set(hFig, 'PaperPosition', [0.1 0.1 15 10])
if printFigs
    print(hFig, '-dpng', figureName, sprintf('-r%d',300));
    close(hFig)
end
end

% EOF