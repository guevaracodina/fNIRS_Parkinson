%% Clear workspace
clear; close all;clc
printFigs = true;

%% HbO
hFig = figure;
set(hFig, 'color', 'w')
pHbOcondL = [   0.03772299
                0.044120175
                0.039189279
                0.014955166
                0.034661311]; % PD & Control
pHbOcondR = [  ]; %PD & Control

channHbOL = [19 20 21 22 22]'; % PD & Control
channHbOR = [ ]; %PD & Control

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
    print(hFig, '-dpng', '..\figures\colorbar_active_HbO_walk.png', sprintf('-r%d',300));
    close(hFig)
end


% EOF