%% Clear space
clear; close all; clc
%% Motor cortex template
% Brite 2x10 + 2SSC (Homer)
channelsList = [    " HRF HbO,1,1"      %  1
    " HRF HbO,3,1"      %  2
    " HRF HbO,2,1"      %  3 (SSC)
    " HRF HbO,1,2"      %  4
    " HRF HbO,3,2"      %  5
    " HRF HbO,4,2"      %  6
    " HRF HbO,4,3"      %  7
    " HRF HbO,5,3"      %  8
    " HRF HbO,3,4"      %  9
    " HRF HbO,4,4"      % 10
    " HRF HbO,5,4"      % 11
    " HRF HbO,8,5"      % 12
    " HRF HbO,6,5"      % 13
    " HRF HbO,7,5"      % 14 (SSC)
    " HRF HbO,9,6"      % 15
    " HRF HbO,8,6"      % 16
    " HRF HbO,6,6"      % 17
    "HRF HbO,10,7"      % 18
    " HRF HbO,9,7"      % 19
    " HRF HbO,8,7"      % 20
    "HRF HbO,10,8"      % 21
    " HRF HbO,9,8"];    % 22
channelsIdx = [     1 13
    2 12
    3 14        % SSC
    4 17
    5 16
    6 15
    7 22
    8 21
    9 20
    10 19
    11 18];

%% Finger Tapping ROI
% condition L
% " HRF HbO,4,3"      %  7
% " HRF HbO,5,3"      %  8
% " HRF HbO,4,4"      % 10
% " HRF HbO,5,4"      % 11
idxL = [7,8,10,11];
% condition R
% " HRF HbO,9,6"      % 15
% " HRF HbO,8,6"      % 16
% " HRF HbO,9,7"      % 19
% " HRF HbO,8,7"      % 20
idxR = [15,16,19,20];

%% List of files with the subject-specific HRF
fileList{1} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD01\PD01.mat';
fileList{2} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD02\PD02.mat';
fileList{3} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD03\PD03.mat';
fileList{4} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD04\PD04.mat';
fileList{5} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD05\PD05.mat';
fileList{6} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD06\PD06.mat';
fileList{7} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD07\PD07.mat';
fileList{8} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD08\PD08.mat';
fileList{9} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD09\PD09.mat';
fileList{10} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD10\PD10.mat';
fileList{11} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD11\PD11.mat';
fileList{12} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD12\PD12.mat';
fileList{13} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD13\PD13.mat';
fileList{14} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD14\PD14.mat';
fileList{15} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD15\PD15.mat';
fileList{16} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD16\PD16.mat';
fileList{17} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD17\PD17.mat';
fileList{18} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD18\PD18.mat';
fileList{19} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD19\PD19.mat';
fileList{20} = '..\fNIRS_Data\Parkinson\PD\homerOutput\PD20\PD20.mat';
fileList{21} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control01\Control01.mat';
fileList{22} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control02\Control02.mat';
fileList{23} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control03\Control03.mat';
fileList{24} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control04\Control04.mat';
fileList{25} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control05\Control05.mat';
fileList{26} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control06\Control06.mat';
fileList{27} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control07\Control07.mat';
fileList{28} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control08\Control08.mat';
fileList{29} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control09\Control09.mat';
fileList{30} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control10\Control10.mat';
fileList{31} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control11\Control11.mat';
fileList{32} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control12\Control12.mat';
fileList{33} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control13\Control13.mat';
fileList{34} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control14\Control14.mat';
fileList{34} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control14\Control15.mat';
fileList{34} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control14\Control16.mat';
fileList{34} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control14\Control17.mat';
fileList{34} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control14\Control18.mat';
fileList{34} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control14\Control19.mat';
fileList{34} = '..\fNIRS_Data\Parkinson\Control\homerOutput\Control14\Control20.mat';

isParkinson = [true([20 1]); false([20 1])];
nFiles = numel(fileList);

%% Extract HbO ROI
offSet = 1;         % OffSet = 1 for HbO, 2 for HbR & 3 for HbT
for iFiles = 1: nFiles
    load(fileList{iFiles});
    if iFiles==1
        ROI.L = nan([nFiles,  676]);
        ROI.R = nan([nFiles,  676]);
    end
    if size(output.dcAvg.dataTimeSeries,1) ~= 676
        resamplingFactor = round(size(output.dcAvg.dataTimeSeries,1)/676);
        ROIdata = resample(output.dcAvg.dataTimeSeries,1,resamplingFactor);
    else
        ROIdata = output.dcAvg.dataTimeSeries;
        timeVector = output.dcAvg.time;
    end
    if isParkinson(iFiles)
        % condition L
        ROI.L(iFiles,:) = nanmean(ROIdata(:,66+(idxL-1)*3+offSet).');
        % condition R
        ROI.R(iFiles,:) = nanmean(ROIdata(:,132+(idxR-1)*3+offSet).');
    else
        % condition L
        ROI.L(iFiles,:) = nanmean(ROIdata(:,(idxL-1)*3+offSet).');
        % condition R
        ROI.R(iFiles,:) = nanmean(ROIdata(:,66+(idxR-1)*3+offSet).');
    end
end

% Control03 2026 samples
% Control01 1351 samples
% PD01  1351 samples
% The rest 676 samples

%% Compute HRF metrics: maxVal, timeToMax, meanVal and AUC
timeRange = [5 25];
idxRange = find(timeVector>=timeRange(1), 1):find(timeVector>=timeRange(2), 1);
for iFiles = 1:nFiles
    % condition L
    [ROI.LmaxVal(iFiles,:), idx] = max(ROI.L(iFiles,idxRange));
    ROI.LtimeToMax(iFiles,:) = timeVector(idx+idxRange(1));
    ROI.LmeanVal(iFiles,:) = mean(ROI.L(iFiles,idxRange));
    ROI.LAUC(iFiles,:) = trapz(ROI.L(iFiles,idxRange));
    % condition R
    [ROI.RmaxVal(iFiles,:), idx] = max(ROI.R(iFiles,idxRange));
    ROI.RtimeToMax(iFiles,:) = timeVector(idx+idxRange(1));
    ROI.RmeanVal(iFiles,:) = mean(ROI.R(iFiles,idxRange));
    ROI.RAUC(iFiles,:) = trapz(ROI.R(iFiles,idxRange));
end
HbOdata.L = [ROI.LmaxVal ROI.LtimeToMax ROI.LmeanVal ROI.LAUC];
HbOdata.R = [ROI.RmaxVal ROI.RtimeToMax ROI.RmeanVal ROI.RAUC];
save ('..\fNIRS_Data\ROIdataHbO.mat')
disp('ROI metrics computed!')
% EOF