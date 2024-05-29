%% Load channel by channel data
clear; close all; clc
check_homer_path
Folder = 'C:\Edgar\Dropbox\Matlab\shadedErrorBar';
if ~ismember(Folder, strsplit(path, pathsep))
    addpath(genpath(Folder))
end
% load ('..\fNIRS_Data\channelData.mat')
load ('..\fNIRS_Data\channelData_5sec.mat')
load('C:\Edgar\Dropbox\Shared folders\fNIRS\software\fNIRS_Data\demographicsData.mat')
load('..\data\onsetSidePD.mat', 'onsetSideFull', 'onsetSide')
% If we wish to label the strength of the association, for absolute values
% of r, 0-0.19 is regarded as very weak, 0.2-0.39 as weak, 0.40-0.59 as
% moderate, 0.6-0.79 as strong and 0.8-1 as very strong correlation
printFigures = false;

%% Extract variables
% Y = data{:, {'MoCA','diseaseDuration','UPDRS','FOGQ','LEDD','HY'}};
Y = table2array(allDemographics(:, 10:15));
Y = Y(isPD, :);
% X = data{:, {'RmaxVal','RtimeToMax','RAUC','RmeanVal','Rslope','LmaxVal','LtimeToMax','LAUC','LmeanVal','Lslope'}};
% All 5 HRF features for each condition L/R
X = [
    HbOchannels.RmaxVal(:,5) HbOchannels.RtimeToMax(:,5) HbOchannels.RAUC(:,5)...
    HbOchannels.RmeanVal(:,5) HbOchannels.Rslope(:,5) HbOchannels.LmaxVal(:,9)  ...
    HbOchannels.LtimeToMax(:,9) HbOchannels.LAUC(:,9) HbOchannels.LmeanVal(:,9)  ...
    HbOchannels.Lslope(:,9)];
X = X(isPD, :);
% control variables
controls = [age education];
controls = controls(isPD, :);

%% HbO
[hFigHbO, R_LHbO, R_RHbO, adjusted_p_LHbO, adjusted_p_RHbO] = partial_correlations_compute(X,Y,controls,onsetSide);
set(hFigHbO, 'Name', 'HbO')
if printFigures
    print(hFigHbO, '-dpng', '..\figures\correlations\partial_corr_HbO.png', sprintf('-r%d',300));
end

%% HbR
X = [
    HbRchannels.RmaxVal(:,5) HbRchannels.RtimeToMax(:,5) HbRchannels.RAUC(:,5)...
    HbRchannels.RmeanVal(:,5) HbRchannels.Rslope(:,5) HbRchannels.LmaxVal(:,9)  ...
    HbRchannels.LtimeToMax(:,9) HbRchannels.LAUC(:,9) HbRchannels.LmeanVal(:,9)  ...
    HbRchannels.Lslope(:,9)];
X = X(isPD, :);
hFigHbR = partial_correlations_compute(X,Y,controls,onsetSide);
set(hFigHbR, 'Name', 'HbR')
if printFigures
    print(hFigHbR, '-dpng', '..\figures\correlations\partial_corr_HbR.png', sprintf('-r%d',300));
end


%% HbT
X = [
    HbTchannels.RmaxVal(:,5) HbTchannels.RtimeToMax(:,5) HbTchannels.RAUC(:,5)...
    HbTchannels.RmeanVal(:,5) HbTchannels.Rslope(:,5) HbTchannels.LmaxVal(:,9)  ...
    HbTchannels.LtimeToMax(:,9) HbTchannels.LAUC(:,9) HbTchannels.LmeanVal(:,9)  ...
    HbTchannels.Lslope(:,9)];
X = X(isPD, :);
hFigHbT = partial_correlations_compute(X,Y,controls,onsetSide);
set(hFigHbT, 'Name', 'HbT')
if printFigures
    print(hFigHbT, '-dpng', '..\figures\correlations\partial_corr_HbT.png', sprintf('-r%d',300));
end


%% Plot significant correlations
close all
X_temp = 1e6*HbOchannels.RAUC(isParkinson,5);
Y_temp = Y(:, end);
RightColor = [1 0 1];
LeftColor = [1 0 0];
myMarkerSize = 10;
myLineWidth = 2;
% AUC
hFigAUC = my_partial_corr_plot(X_temp, Y_temp, onsetSide, LeftColor, RightColor, myMarkerSize, myLineWidth);
legend({'' '' 'Left-side onset' '' '' 'Right-side onset'})
xlabel('AUC/Right finger-tapping(\muM\cdotmm\cdots)', 'Interpreter','tex')
ylabel('HY')
title('')
if printFigures
    print(hFigAUC, '-dpng', '..\figures\correlations\partial_corr_AUC_HY_HbO.png', sprintf('-r%d',300));
end

% Mean value
X_temp2 = 1e6*HbOchannels.RmeanVal(isParkinson,5);
hFigMean = my_partial_corr_plot(X_temp2, Y_temp, onsetSide, LeftColor, RightColor, myMarkerSize, myLineWidth);
legend({'' '' 'Left-side onset' '' '' 'Right-side onset'})
xlabel('Mean/Right finger-tapping(\muM\cdotmm)', 'Interpreter','tex')
ylabel('HY')
title('')

if printFigures
    print(hFigMean, '-dpng', '..\figures\correlations\partial_corr_mean_HY_HbO.png', sprintf('-r%d',300));
end
% EOF