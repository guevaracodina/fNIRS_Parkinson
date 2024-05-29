% HRF fNIRS Black & White Art
% Inspired by Jonathan A. Michaels @JonAMichaels I never get sick of looking at motor units.
clear; close all; clc;
load('..\fNIRS_Data\channelData.mat')

%% Right finger-tapping
% h = figure;
% set(h, 'Color', 'k')
% hold on
% plot(squeeze(mean(HbOchannels.R,2)).', 'Color', [0.5 0.5 0.5]);
% set(gca,'Color','k')
% plot(mean(squeeze(mean(HbOchannels.R,2)).',2), 'w-', 'LineWidth', 4);
% axis tight
% axis off
% set(h,'InvertHardcopy','off')
% % Specify window units
% set(h, 'units', 'inches')
% % Change figure and paper size
% set(h, 'Position', [0.1 0.1 10 10])
% set(h, 'PaperPosition', [0.1 0.1 10 10])

%% Left finger-tapping
% h = figure;
% set(h, 'Color', 'k')
% hold on
% plot(squeeze(mean(HbOchannels.L,2)).', 'Color', [0.5 0.5 0.5]);
% set(gca,'Color','k')
% plot(mean(squeeze(mean(HbOchannels.L,2)).',2), 'w-', 'LineWidth', 4);
% axis tight
% axis off
% set(h,'InvertHardcopy','off')
% % Specify window units
% set(h, 'units', 'inches')
% % Change figure and paper size
% set(h, 'Position', [0.1 0.1 10 10])
% set(h, 'PaperPosition', [0.1 0.1 10 10])

%% All finger tapping
HbOAll = cat(1, HbOchannels.R, HbOchannels.L);
HbRAll = cat(1, HbRchannels.R, HbRchannels.L);
h = figure;
set(h, 'Color', 'k')
hold on
set(gca,'Color','k')
% HbO
plot(squeeze(mean(HbOAll,2)).', 'Color', 0.7* [1 1 1]);
plot(mean(squeeze(mean(HbOAll,2)),1), 'w-', 'LineWidth', 4);
% HbR
% plot(squeeze(mean(HbRAll,2)).', 'LineStyle', '--', 'Color', 0.7* [1 1 1]));
% plot(mean(squeeze(mean(HbRAll,2)),1), 'w--', 'LineWidth', 4);
axis tight
% ylim(1.0e-03 * [-0.012    0.052])
axis off
set(h,'InvertHardcopy','off')
% Specify window units
set(h, 'units', 'inches')
% Change figure and paper size
set(h, 'Position', [0.1 0.1 10 10])
set(h, 'PaperPosition', [0.1 0.1 10 10])
print(h, '-dpng', '..\figures\HRF_BW_art.png', sprintf('-r%d',300));
% EOF
