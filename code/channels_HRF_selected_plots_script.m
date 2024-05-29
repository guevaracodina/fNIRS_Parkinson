%% Load channel by channel data
clear; close all; clc
check_homer_path
Folder = 'C:\Edgar\Dropbox\Matlab\shadedErrorBar';
if ~ismember(Folder, strsplit(path, pathsep))
    addpath(genpath(Folder))
end
load ('..\fNIRS_Data\channelData.mat')

myFontSize = 24;
myMarkerSize = 6;
printFigs = true;
nChannels = size(longChannelsIdx,1);
nS   = sqrt(nChannels);
nCol = ceil(nS);
nRow = nCol - (nCol * nCol - nChannels > nCol - 1);
stderror = @(x) std(x)./sqrt(size(x,1));

%% Plot group-averaged hemodynamic response (HbO L condition)
% Colors
% controlColor = [0.00787401574803150,0.412505789717462,0.284113015284854];
controlColor = [1 0 1];
% PDcolor = [0.807843137254902,0.0666666666666667,0.149019607843137];
PDcolor = [1 0 0];
hHbOL=figure; set(hHbOL, 'color', 'w', 'Name', 'Left finger-tapping')
myYlims = [-20 85];
for iChannels=9
%     subplot(nRow, nCol, iChannels)
    hold on
    if iChannels<=nChannels
    % Spectra (mean +- s.d.) are offset for clarity
    % stdErr = @(x) std(x)./numel(x);
    hCtl = shadedErrorBar(timeVector, 1e6*squeeze(HbOchannels.L(~isParkinson,iChannels,:)),{@mean, stderror},':', 1);
    hCtl.mainLine.Color = controlColor;
    hCtl.edge(1).Color = controlColor;
    hCtl.edge(2).Color = controlColor;
    hCtl.patch.FaceColor = controlColor;
    hCtl.mainLine.LineWidth = 2;
    hPD = shadedErrorBar(timeVector, 1e6*squeeze(HbOchannels.L(isParkinson,iChannels,:)),{@mean,stderror},'-', 1);
    hPD.mainLine.Color = PDcolor;
    hPD.edge(1).Color = PDcolor;
    hPD.edge(2).Color = PDcolor;
    hPD.patch.FaceColor = PDcolor;
    hPD.mainLine.LineWidth = 2;
    if iChannels == nChannels
        xlabel('Time (s)', 'FontSize', myFontSize)
    end
    if iChannels == 5
        ylabel('\Delta HbO (\muM\cdotmm)', 'FontSize', myFontSize)
    end
    title('L finger-tapping')
    else
        plot([0 0],[1 1], '-', 'Color', PDcolor, 'LineWidth', 2)
        hold on
        plot([0 0],[1 1], ':', 'Color', controlColor, 'LineWidth', 2)
        legend({'PD' 'Control'}, 'Location', 'WestOutside')
        axis off
    end
    set(gca,'FontSize',myFontSize-1)
    axis tight;
    ylim(myYlims);
end
% Specify window units
set(hHbOL, 'units', 'inches')
% Change figure and paper size
set(hHbOL, 'Position', [0.1 0.1 20 11])
set(hHbOL, 'PaperPosition', [0.1 0.1 20 11])
% if printFigs
%     print(hHbOL, '-dpng', '..\figures\HbO_L_group_avg.png', sprintf('-r%d',300));
% end

%% Plot group-averaged hemodynamic response (HbR L condition)
controlColor = [0 1 1];
PDcolor = [0 0 1];
% hHbRL=figure; set(hHbRL, 'color', 'w', 'Name', 'HbR L condition')
% myYlims = [-25 20];
for iChannels=9
%     subplot(nRow, nCol, iChannels)
    hold on
    if iChannels<=nChannels
    % Spectra (mean +- s.d.) are offset for clarity
    % stdErr = @(x) std(x)./numel(x);
    hCtl = shadedErrorBar(timeVector, 1e6*squeeze(HbRchannels.L(~isParkinson,iChannels,:)),{@mean, stderror},':', 1);
    hCtl.mainLine.Color = controlColor;
    hCtl.edge(1).Color = controlColor;
    hCtl.edge(2).Color = controlColor;
    hCtl.patch.FaceColor = controlColor;
    hCtl.mainLine.LineWidth = 2;
    hPD = shadedErrorBar(timeVector, 1e6*squeeze(HbRchannels.L(isParkinson,iChannels,:)),{@mean,stderror},'-', 1);
    hPD.mainLine.Color = PDcolor;
    hPD.edge(1).Color = PDcolor;
    hPD.edge(2).Color = PDcolor;
    hPD.patch.FaceColor = PDcolor;
    hPD.mainLine.LineWidth = 2;
%     if iChannels == nChannels
        xlabel('Time (s)', 'FontSize', myFontSize)
%     end
%     if iChannels == 5
        ylabel('\DeltaHb (\muM\cdotmm)', 'FontSize', myFontSize)
%     end
    
%     else
%         plot([0 0],[1 1], '-', 'Color', PDcolor, 'LineWidth', 2)
%         hold on
%         plot([0 0],[1 1], ':', 'Color', controlColor, 'LineWidth', 2)
        legend({'' '' '' 'PD HbO' '' '' '' 'Control HbO' '' '' '' 'PD HbR' '' '' '' 'Control HbR'}, 'Location', 'EastOutside')
%         axis off
    end
    set(gca,'FontSize',myFontSize-1)
    axis tight;
    ylim(myYlims);
end
% Specify window units
% set(hHbRL, 'units', 'inches')
% Change figure and paper size
% set(hHbRL, 'Position', [0.1 0.1 15 10])
% set(hHbRL, 'PaperPosition', [0.1 0.1 15 10])
if printFigs
    print(hHbOL, '-dpng', '..\figures\HRF_L_condition.png', sprintf('-r%d',300));
end

if false
%% Plot group-averaged hemodynamic response (HbT L condition)
controlColor = [0.00787401574803150,0.412505789717462,0.284113015284854];
% controlColor = [0.25 0.25 0.25];
% PDcolor = [0 0 0];
PDcolor = [0 1 0];
% hHbTL=figure; set(hHbTL, 'color', 'w', 'Name', 'HbT L condition')
% myYlims = [-30 60];
for iChannels=9
%     subplot(nRow, nCol, iChannels)
    hold on
    if iChannels<=nChannels
    % Spectra (mean +- s.d.) are offset for clarity
    % stdErr = @(x) std(x)./numel(x);
    hCtl = shadedErrorBar(timeVector, 1e6*squeeze(HbTchannels.L(~isParkinson,iChannels,:)),{@mean, stderror},':', 1);
    hCtl.mainLine.Color = controlColor;
    hCtl.edge(1).Color = controlColor;
    hCtl.edge(2).Color = controlColor;
    hCtl.patch.FaceColor = controlColor;
    hCtl.mainLine.LineWidth = 2;
    hPD = shadedErrorBar(timeVector, 1e6*squeeze(HbTchannels.L(isParkinson,iChannels,:)),{@mean,stderror},'-', 1);
    hPD.mainLine.Color = PDcolor;
    hPD.edge(1).Color = PDcolor;
    hPD.edge(2).Color = PDcolor;
    hPD.patch.FaceColor = PDcolor;
    hPD.mainLine.LineWidth = 2;
    if iChannels == nChannels
        xlabel('Time (s)', 'FontSize', myFontSize)
    end
    if iChannels == 5
        ylabel('\Delta HbT (\muM\cdotmm)', 'FontSize', myFontSize)
    end
%     title(sprintf('Ch %d', idxR(iChannels)))
    else
        plot([0 0],[1 1], '-', 'Color', PDcolor, 'LineWidth', 2)
        hold on
        plot([0 0],[1 1], ':', 'Color', controlColor, 'LineWidth', 2)
        legend({'PD' 'Control'}, 'Location', 'WestOutside')
        axis off
    end
    set(gca,'FontSize',myFontSize-1)
    axis tight;
    ylim(myYlims);
end
% Specify window units
% set(hHbTL, 'units', 'inches')
% % Change figure and paper size
% set(hHbTL, 'Position', [0.1 0.1 15 10])
% set(hHbTL, 'PaperPosition', [0.1 0.1 15 10])
% if printFigs
%     print(hHbTL, '-dpng', '..\figures\HbT_L_group_avg.png', sprintf('-r%d',300));
% end
end

%% Plot group-averaged hemodynamic response (HbO R condition)
% Colors
% controlColor = [0.00787401574803150,0.412505789717462,0.284113015284854];
controlColor = [1 0 1];
% PDcolor = [0.807843137254902,0.0666666666666667,0.149019607843137];
PDcolor = [1 0 0];
hHbOR=figure; set(hHbOR, 'color', 'w', 'Name', 'Right finger-tapping')
for iChannels=10
%     subplot(nRow, nCol, iChannels)
    hold on
    if iChannels<=nChannels
    % Spectra (mean +- s.d.) are offset for clarity
    % stdErr = @(x) std(x)./numel(x);
    hCtl = shadedErrorBar(timeVector, 1e6*squeeze(HbOchannels.R(~isParkinson,iChannels,:)),{@mean, stderror},':', 1);
    hCtl.mainLine.Color = controlColor;
    hCtl.edge(1).Color = controlColor;
    hCtl.edge(2).Color = controlColor;
    hCtl.patch.FaceColor = controlColor;
    hCtl.mainLine.LineWidth = 2;
    hPD = shadedErrorBar(timeVector, 1e6*squeeze(HbOchannels.R(isParkinson,iChannels,:)),{@mean,stderror},'-', 1);
    hPD.mainLine.Color = PDcolor;
    hPD.edge(1).Color = PDcolor;
    hPD.edge(2).Color = PDcolor;
    hPD.patch.FaceColor = PDcolor;
    hPD.mainLine.LineWidth = 2;
%     if iChannels == nChannels
        xlabel('Time (s)', 'FontSize', myFontSize)
%     end
%     if iChannels == 5
        ylabel('\Delta HbO (\muM\cdotmm)', 'FontSize', myFontSize)
%     end
    title('R finger-tapping')
%     title(sprintf('Ch %d', idxL(iChannels)))
%     else
%         plot([0 0],[1 1], '-', 'Color', PDcolor, 'LineWidth', 2)
%         hold on
%         plot([0 0],[1 1], ':', 'Color', controlColor, 'LineWidth', 2)
%         legend({'PD' 'Control'}, 'Location', 'Best')
%         axis off
    end
    set(gca,'FontSize',myFontSize-1)
    axis tight;
    ylim(myYlims);
end
% Specify window units
set(hHbOR, 'units', 'inches')
% Change figure and paper size
set(hHbOR, 'Position', [0.1 0.1 20 11])
set(hHbOR, 'PaperPosition', [0.1 0.1 20 11])
% if printFigs
%     print(hHbOR, '-dpng', '..\figures\HbO_R_group_avg.png', sprintf('-r%d',300));
% end

%% Plot group-averaged hemodynamic response (HbR R condition)
% hHbRR=figure; set(hHbRR, 'color', 'w', 'Name', 'HbR R condition')
controlColor = [0 1 1];
PDcolor = [0 0 1];
for iChannels=10
%     subplot(nRow, nCol, iChannels)
    hold on
    if iChannels<=nChannels
    % Spectra (mean +- s.d.) are offset for clarity
    % stdErr = @(x) std(x)./numel(x);
    hCtl = shadedErrorBar(timeVector, 1e6*squeeze(HbRchannels.R(~isParkinson,iChannels,:)),{@mean, stderror},':', 1);
    hCtl.mainLine.Color = controlColor;
    hCtl.edge(1).Color = controlColor;
    hCtl.edge(2).Color = controlColor;
    hCtl.patch.FaceColor = controlColor;
    hCtl.mainLine.LineWidth = 2;
    hPD = shadedErrorBar(timeVector, 1e6*squeeze(HbRchannels.R(isParkinson,iChannels,:)),{@mean,stderror},'-', 1);
    hPD.mainLine.Color = PDcolor;
    hPD.edge(1).Color = PDcolor;
    hPD.edge(2).Color = PDcolor;
    hPD.patch.FaceColor = PDcolor;
    hPD.mainLine.LineWidth = 2;
%     if iChannels == nChannels
        xlabel('Time (s)', 'FontSize', myFontSize)
%     end
%     if iChannels == 5
        ylabel('\DeltaHb (\muM\cdotmm)', 'FontSize', myFontSize)
%     end
%     title(sprintf('Ch %d', idxL(iChannels)))
%     else
%         plot([0 0],[1 1], '-', 'Color', PDcolor, 'LineWidth', 2)
%         hold on
%         plot([0 0],[1 1], ':', 'Color', controlColor, 'LineWidth', 2)
        legend({'' '' '' 'PD HbO' '' '' '' 'Control HbO' '' '' '' 'PD HbR' '' '' '' 'Control HbR'}, 'Location', 'EastOutside')
%         axis off
    end
    set(gca,'FontSize',myFontSize-1)
    axis tight;
    ylim(myYlims);
end
% % Specify window units
% set(hHbRR, 'units', 'inches')
% % Change figure and paper size
% set(hHbRR, 'Position', [0.1 0.1 15 10])
% set(hHbRR, 'PaperPosition', [0.1 0.1 15 10])
if printFigs
    print(hHbOR, '-dpng', '..\figures\HRF_R_condition.png', sprintf('-r%d',300));
end



if false
%% Plot group-averaged hemodynamic response (HbT R condition)
% hHbTR=figure; set(hHbTR, 'color', 'w', 'Name', 'HbT R condition')
controlColor = [0.00787401574803150,0.412505789717462,0.284113015284854];
% controlColor = [0.25 0.25 0.25];
% PDcolor = [0 0 0];
PDcolor = [0 1 0];
for iChannels=10
%     subplot(nRow, nCol, iChannels)
    hold on
    if iChannels<=nChannels
    % Spectra (mean +- s.d.) are offset for clarity
    % stdErr = @(x) std(x)./numel(x);
    hCtl = shadedErrorBar(timeVector, 1e6*squeeze(HbTchannels.R(~isParkinson,iChannels,:)),{@mean, stderror},':', 1);
    hCtl.mainLine.Color = controlColor;
    hCtl.edge(1).Color = controlColor;
    hCtl.edge(2).Color = controlColor;
    hCtl.patch.FaceColor = controlColor;
    hCtl.mainLine.LineWidth = 2;
    hPD = shadedErrorBar(timeVector, 1e6*squeeze(HbTchannels.R(isParkinson,iChannels,:)),{@mean,stderror},'-', 1);
    hPD.mainLine.Color = PDcolor;
    hPD.edge(1).Color = PDcolor;
    hPD.edge(2).Color = PDcolor;
    hPD.patch.FaceColor = PDcolor;
    hPD.mainLine.LineWidth = 2;
    if iChannels == nChannels
        xlabel('Time (s)', 'FontSize', myFontSize)
    end
    if iChannels == 5
        ylabel('\Delta HbT (\muM\cdotmm)', 'FontSize', myFontSize)
    end
%     title(sprintf('Ch %d', idxL(iChannels)))
    else
        plot([0 0],[1 1], '-', 'Color', PDcolor, 'LineWidth', 2)
        hold on
        plot([0 0],[1 1], ':', 'Color', controlColor, 'LineWidth', 2)
        legend({'PD' 'Control'}, 'Location', 'WestOutside')
        axis off
    end
    set(gca,'FontSize',myFontSize-1)
    axis tight;
    ylim(myYlims);
end
% % Specify window units
% set(hHbTR, 'units', 'inches')
% % Change figure and paper size
% set(hHbTR, 'Position', [0.1 0.1 15 10])
% set(hHbTR, 'PaperPosition', [0.1 0.1 15 10])
% if printFigs
%     print(hHbTR, '-dpng', '..\figures\HbT_R_group_avg.png', sprintf('-r%d',300));
% end
end

disp('HRF plots done!')
% EOF