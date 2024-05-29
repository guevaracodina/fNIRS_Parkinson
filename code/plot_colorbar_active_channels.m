%% Clear workspace
clear; close all;clc
printFigs = true;

%% HbO
hFig = figure;
set(hFig, 'color', 'w')
pHbOcondL = [   0.0470
                0.0358
                0.0358
                0.0358
                0.0358
                0.0452
                0.0429]; % PD
pHbOcondR = [   0.0367
                0.0473
                0.0367
                0.0473
                0.0473
                0.0473
                0.0002]; %PD

channHbOL = [   5
                6
                9
                10
                11
                16
                19]; % PD
channHbOR = [   5
                12
                13
                16
                19
                22
                1]; %PD

minVal = min([pHbOcondL; pHbOcondR]);
maxVal = 0.05;
imagesc([pHbOcondL; pHbOcondR], [minVal maxVal]);
set(gca, 'YTick', 1:numel([pHbOcondL; pHbOcondR]), 'XTick', [], 'YTickLabel', num2str([channHbOL; channHbOR]))
colormap(ioi_get_colormap('redmap'))
colorbar
set(gca, 'FontSize', 14)
% Specify window units
set(hFig, 'units', 'inches')
% Change figure and paper size
set(hFig, 'Position', [0.1 0.1 4 10])
set(hFig, 'PaperPosition', [0.1 0.1 4 10])
if printFigs
    print(hFig, '-dpng', '..\figures\colorbar_active_HbO.png', sprintf('-r%d',300));
    close(hFig)
end

%% HbR
hFig = figure;
set(hFig, 'color', 'w')
pHbRcondL = [  0.0395]; % PD
pHbRcondR = [   0.0117
                0.0130 %PD
                0.0130 %PD
                0.0235]; %PD

channHbRL = [   15]; % PD
channHbRR = [   8
                8
                18
                19]; %PD

minVal = min([pHbRcondL; pHbRcondR]);
maxVal = 0.05;
imagesc([pHbRcondL; pHbRcondR], [minVal maxVal]);
set(gca, 'YTick', 1:numel([pHbRcondL; pHbRcondR]), 'XTick', [], 'YTickLabel', num2str([channHbRL; channHbRR]))
colormap(ioi_get_colormap('bluemap'))
colorbar
set(gca, 'FontSize', 14)
% Specify window units
set(hFig, 'units', 'inches')
% Change figure and paper size
set(hFig, 'Position', [0.1 0.1 4 10])
set(hFig, 'PaperPosition', [0.1 0.1 4 10])
if printFigs
    print(hFig, '-dpng', '..\figures\colorbar_active_HbR.png', sprintf('-r%d',300));
    close(hFig)
end

%% HbT
hFig = figure;
set(hFig, 'color', 'w')
pHbTcondL = [   ]; % PD
pHbTcondR = [   0.0146
                0.0152
                0.0013]; %PD

channHbTL = [   ]; % PD
channHbTR = [   5
                13
                1 ]; %PD

minVal = min([pHbTcondL; pHbTcondR]);
maxVal = 0.05;
imagesc([pHbTcondL; pHbTcondR], [minVal maxVal]);
set(gca, 'YTick', 1:numel([pHbTcondL; pHbTcondR]), 'XTick', [], 'YTickLabel', num2str([channHbTL; channHbTR]))
colormap(ioi_get_colormap('greenmap'))
colorbar
set(gca, 'FontSize', 14)
% Specify window units
set(hFig, 'units', 'inches')
% Change figure and paper size
set(hFig, 'Position', [0.1 0.1 4 10])
set(hFig, 'PaperPosition', [0.1 0.1 4 10])
if printFigs
    print(hFig, '-dpng', '..\figures\colorbar_active_HbT.png', sprintf('-r%d',300));
    close(hFig)
end

%% HbO Group Differences
hFig = figure;
set(hFig, 'color', 'w')
pHbOgroupDiffL = [ 0.0450204104457744 ]; 
pHbOgroupDiffR = [ 0.00473115739819175  ];

channHbOL = [ 10  ]; 
channHbOR = [ 15  ];

minVal = min([pHbOgroupDiffL; pHbOgroupDiffR]);
maxVal = 0.05;
imagesc([pHbOgroupDiffL; pHbOgroupDiffR], [minVal maxVal]);
set(gca, 'YTick', 1:numel([pHbOgroupDiffL; pHbOgroupDiffR]), 'XTick', [], 'YTickLabel', num2str([channHbOL; channHbOR]))
colormap(ioi_get_colormap('redmap'))
colorbar
set(gca, 'FontSize', 14)
% Specify window units
set(hFig, 'units', 'inches')
% Change figure and paper size
set(hFig, 'Position', [0.1 0.1 4 10])
set(hFig, 'PaperPosition', [0.1 0.1 4 10])
if printFigs
    print(hFig, '-dpng', '..\figures\colorbar_active_HbO_group_diff.png', sprintf('-r%d',300));
    close(hFig)
end

% EOF