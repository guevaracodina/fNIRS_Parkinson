% Computes statistics about the following HRF metrics on a channel-by-channel
% basis: peak value, time-to-peak, AUC, mean value, slope
%% Load channel by channel data
clear; close all; clc
check_homer_path
Folder = 'C:\Edgar\Dropbox\Matlab\shadedErrorBar';
if ~ismember(Folder, strsplit(path, pathsep))
    addpath(genpath(Folder))
end
load ('..\fNIRS_Data\channelData.mat')

%% General plotting settings
printFigs = false;
myFontSize = 24;
myMarkerSize = 6;
nChannels = size(longChannelsIdx,1);
nS   = sqrt(nChannels);
nCol = ceil(nS);
nRow = nCol - (nCol * nCol - nChannels > nCol - 1);
% Initialize structure
P(nChannels).peakHbOL = nan;
H(nChannels).peakHbOL = nan;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Peak amplitude Peak_HbO condition L
% Colors
controlColor = [1 0 1];
PDcolor = [1 0 0];
myYLabel = '\Delta HbO (\muM\cdotmm)';
figureName = '..\figures\HbO_L_peak.png';
data = 1e6*HbOchannels.LmaxVal;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).peakHbOL] = currentP.P;
[H(:).peakHbOL] = currentH.H;

%% Peak amplitude Peak_HbO condition R
figureName = '..\figures\HbO_R_peak.png';
data = 1e6*HbOchannels.RmaxVal;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).peakHbOR] = currentP.P;
[H(:).peakHbOR] = currentH.H;

%% Peak amplitude Peak_HbR condition L
controlColor = [0 1 1];
PDcolor = [0 0 1];
myYLabel = '\Delta HbR (\muM\cdotmm)';
figureName = '..\figures\HbR_L_peak.png';
data = 1e6*HbRchannels.LmaxVal;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).peakHbRL] = currentP.P;
[H(:).peakHbRL] = currentH.H;

%% Peak amplitude Peak_HbR condition R
figureName = '..\figures\HbR_R_peak.png';
data = 1e6*HbRchannels.RmaxVal;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).peakHbRR] = currentP.P;
[H(:).peakHbRR] = currentH.H;

%% Peak amplitude Peak_HbT condition L
controlColor = [0.00787401574803150,0.412505789717462,0.284113015284854];
PDcolor = [0 1 0];
myYLabel = '\Delta HbT (\muM\cdotmm)';
figureName = '..\figures\HbT_L_peak.png';
data = 1e6*HbTchannels.LmaxVal;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).peakHbTL] = currentP.P;
[H(:).peakHbTL] = currentH.H;

%% Peak amplitude Peak_HbT condition R
figureName = '..\figures\HbT_R_peak.png';
data = 1e6*HbTchannels.RmaxVal;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).peakHbTR] = currentP.P;
[H(:).peakHbTR] = currentH.H;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Peak latency HbO condition L
% Colors
controlColor = [1 0 1];
PDcolor = [1 0 0];
myYLabel = 'HbO Time-to-peak(s)';
figureName = '..\figures\HbO_L_latency.png';
data = HbOchannels.LtimeToMax;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).latencyHbOL] = currentP.P;
[H(:).latencyHbOL] = currentH.H;

%% Peak latency HbO condition R
figureName = '..\figures\HbO_R_latency.png';
data = HbOchannels.RtimeToMax;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).latencyHbOR] = currentP.P;
[H(:).latencyHbOR] = currentH.H;

%% Peak latency HbR condition L
controlColor = [0 1 1];
PDcolor = [0 0 1];
myYLabel = 'HbR Time-to-peak(s)';
figureName = '..\figures\HbR_L_latency.png';
data = HbRchannels.LtimeToMax;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).latencyHbRL] = currentP.P;
[H(:).latencyHbRL] = currentH.H;

%% Peak latency HbR condition R
figureName = '..\figures\HbR_R_latency.png';
data = HbRchannels.RtimeToMax;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).latencyHbRR] = currentP.P;
[H(:).latencyHbRR] = currentH.H;

%% Peak latency HbT condition L
controlColor = [0.00787401574803150,0.412505789717462,0.284113015284854];
PDcolor = [0 1 0];
myYLabel = 'HbT Time-to-peak (s)';
figureName = '..\figures\HbT_L_latency.png';
data = HbTchannels.LtimeToMax;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).latencyHbTL] = currentP.P;
[H(:).latencyHbTL] = currentH.H;

%% Peak latency HbT condition R
figureName = '..\figures\HbT_R_latency.png';
data = HbTchannels.RtimeToMax;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).latencyHbTR] = currentP.P;
[H(:).latencyHbTR] = currentH.H;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AUC HbO condition L
% Colors
controlColor = [1 0 1];
PDcolor = [1 0 0];
myYLabel = 'HbO AUC (\muM\cdotmm\cdots)';
figureName = '..\figures\HbO_L_AUC.png';
data = HbOchannels.LAUC;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).AUCHbOL] = currentP.P;
[H(:).AUCHbOL] = currentH.H;

%% AUC HbO condition R
figureName = '..\figures\HbO_R_AUC.png';
data = HbOchannels.RAUC;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).AUCHbOR] = currentP.P;
[H(:).AUCHbOR] = currentH.H;

%% AUC HbR condition L
controlColor = [0 1 1];
PDcolor = [0 0 1];
myYLabel = 'HbR AUC (\muM\cdotmm\cdots)';
figureName = '..\figures\HbR_L_AUC.png';
data = HbRchannels.LAUC;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).AUCHbRL] = currentP.P;
[H(:).AUCHbRL] = currentH.H;

%% AUC HbR condition R
figureName = '..\figures\HbR_R_AUC.png';
data = HbRchannels.RAUC;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).AUCHbRR] = currentP.P;
[H(:).AUCHbRR] = currentH.H;

%% AUC HbT condition L
controlColor = [0.00787401574803150,0.412505789717462,0.284113015284854];
PDcolor = [0 1 0];
myYLabel = 'HbT AUC (\muM\cdotmm\cdots)';
figureName = '..\figures\HbT_L_AUC.png';
data = HbTchannels.LAUC;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).AUCHbTL] = currentP.P;
[H(:).AUCHbTL] = currentH.H;

%% AUC HbT condition R
figureName = '..\figures\HbT_R_AUC.png';
data = HbTchannels.RAUC;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).AUCHbTR] = currentP.P;
[H(:).AUCHbTR] = currentH.H;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Mean HbO condition L
% Colors
controlColor = [1 0 1];
PDcolor = [1 0 0];
myYLabel = 'HbO mean (\muM\cdotmm)';
figureName = '..\figures\HbO_L_meanVal.png';
data = 1e6*HbOchannels.LmeanVal;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).meanValHbOL] = currentP.P;
[H(:).meanValHbOL] = currentH.H;

%% Mean HbO condition R
figureName = '..\figures\HbO_R_meanVal.png';
data = 1e6*HbOchannels.RmeanVal;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).meanValHbOR] = currentP.P;
[H(:).meanValHbOR] = currentH.H;

%% Mean HbR condition L
controlColor = [0 1 1];
PDcolor = [0 0 1];
myYLabel = 'HbR mean (\muM\cdotmm)';
figureName = '..\figures\HbR_L_meanVal.png';
data = 1e6*HbRchannels.LmeanVal;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).meanValHbRL] = currentP.P;
[H(:).meanValHbRL] = currentH.H;

%% Mean HbR condition R
controlColor = [0 1 1];
PDcolor = [0 0 1];
myYLabel = 'HbR mean (\muM\cdotmm)';
figureName = '..\figures\HbR_R_meanVal.png';
data = 1e6*HbRchannels.RmeanVal;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).meanValHbRR] = currentP.P;
[H(:).meanValHbRR] = currentH.H;

%% Mean HbT condition L
controlColor = [0.00787401574803150,0.412505789717462,0.284113015284854];
PDcolor = [0 1 0];
myYLabel = 'HbT mean (\muM\cdotmm)';
figureName = '..\figures\HbT_L_meanVal.png';
data = 1e6*HbTchannels.LmeanVal;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).meanValHbTL] = currentP.P;
[H(:).meanValHbTL] = currentH.H;

%% Mean HbT condition R
figureName = '..\figures\HbT_R_meanVal.png';
data = 1e6*HbTchannels.RmeanVal;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).meanValHbTR] = currentP.P;
[H(:).meanValHbTR] = currentH.H;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HbO Slope condition L
% Colors
controlColor = [1 0 1];
PDcolor = [1 0 0];
myYLabel = 'HbO slope (\muM\cdotmm/s)';
figureName = '..\figures\HbO_L_slope.png';
data = 1e6*HbOchannels.Lslope;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).slopeHbOL] = currentP.P;
[H(:).slopeHbOL] = currentH.H;

%% HbO Slope condition R
figureName = '..\figures\HbO_R_slope.png';
data = 1e6*HbOchannels.Rslope;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).slopeHbOR] = currentP.P;
[H(:).slopeHbOR] = currentH.H;

%% HbR Slope condition L
controlColor = [0 1 1];
PDcolor = [0 0 1];
myYLabel = 'HbR slope (\muM\cdotmm/s)';
figureName = '..\figures\HbR_L_slope.png';
data = 1e6*HbRchannels.Lslope;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).slopeHbRL] = currentP.P;
[H(:).slopeHbRL] = currentH.H;

%% HbR Slope condition R
figureName = '..\figures\HbR_R_slope.png';
data = 1e6*HbRchannels.Rslope;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).slopeHbRR] = currentP.P;
[H(:).slopeHbRR] = currentH.H;

%% HbT Slope condition L
controlColor = [0.00787401574803150,0.412505789717462,0.284113015284854];
PDcolor = [0 1 0];
myYLabel = 'HbT slope (\muM\cdotmm/s)';
figureName = '..\figures\HbT_L_slope.png';
data = 1e6*HbTchannels.Lslope;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxR, printFigs, figureName, data);
[P(:).slopeHbTL] = currentP.P;
[H(:).slopeHbTL] = currentH.H;

%% HbT Slope condition R
figureName = '..\figures\HbT_R_slope.png';
data = 1e6*HbTchannels.Rslope;
[currentP, currentH] = plot_compute_stats(controlColor, PDcolor, isParkinson, nChannels, ...
    nCol, nRow, myFontSize, myYLabel, idxL, printFigs, figureName, data);
[P(:).slopeHbTR] = currentP.P;
[H(:).slopeHbTR] = currentH.H;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Print and create tables
%% TO DO!!!! //EGC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% condition L
fprintf('HbO_L Peak \t Latency\t AUC \t Mean \t Slope\n')
disp([P(:).peakHbOL; P(:).latencyHbOL; P(:).AUCHbOL; P(:).meanValHbOL; P(:).slopeHbOL]')
fprintf('HbR_L Peak \t Latency\t AUC \t Mean \t Slope\n')
disp([P(:).peakHbRL; P(:).latencyHbRL; P(:).AUCHbRL; P(:).meanValHbRL; P(:).slopeHbRL]')
fprintf('HbT_L Peak \t Latency\t AUC \t Mean \t Slope\n')
disp([P(:).peakHbTL; P(:).latencyHbTL; P(:).AUCHbTL; P(:).meanValHbTL; P(:).slopeHbTL]')
% condition R
fprintf('HbO_R Peak \t Latency\t AUC \t Mean \t Slope\n')
disp([P(:).peakHbOR; P(:).latencyHbOR; P(:).AUCHbOR; P(:).meanValHbOR; P(:).slopeHbOR]')
fprintf('HbR_R Peak \t Latency\t AUC \t Mean \t Slope\n')
disp([P(:).peakHbRR; P(:).latencyHbRR; P(:).AUCHbRR; P(:).meanValHbRR; P(:).slopeHbRR]')
fprintf('HbT_R Peak \t Latency\t AUC \t Mean \t Slope\n')
disp([P(:).peakHbTR; P(:).latencyHbTR; P(:).AUCHbTR; P(:).meanValHbTR; P(:).slopeHbTR]')

L_condition_stats = ...
    [P(:).peakHbOL; P(:).peakHbRL; P(:).peakHbTL; P(:).latencyHbOL; P(:).latencyHbRL; P(:).latencyHbTL;...
    P(:).AUCHbOL; P(:).AUCHbRL; P(:).AUCHbTL; P(:).meanValHbOL; P(:).meanValHbRL; P(:).meanValHbTL; ...
    P(:).slopeHbOL; P(:).slopeHbRL;  P(:).slopeHbTL]';

R_condition_stats = ...
    [P(:).peakHbOR; P(:).peakHbRR; P(:).peakHbTR; P(:).latencyHbOR; P(:).latencyHbRR; P(:).latencyHbTR;...
    P(:).AUCHbOR; P(:).AUCHbRR; P(:).AUCHbTR; P(:).meanValHbOR; P(:).meanValHbRR; P(:).meanValHbTR; ...
    P(:).slopeHbOR; P(:).slopeHbRR;  P(:).slopeHbTR]';

%% FDR correction
nStats = size(L_condition_stats,2);
L_condition_stats_FDR = nan(size(L_condition_stats));
R_condition_stats_FDR = L_condition_stats_FDR ;
for iStats=1:nStats
    L_condition_stats_FDR(:,iStats) = ioi_fdr(L_condition_stats(:,iStats));
    R_condition_stats_FDR(:,iStats) = ioi_fdr(R_condition_stats(:,iStats));
end

%% Active channels
% TO DO!!!!!!!!!
%% Save statistics
save ('..\fNIRS_Data\channelStats.mat')
disp('channel-by-channel stats done!')
% EOF