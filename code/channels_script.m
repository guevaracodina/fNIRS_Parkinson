%% This script retrieves data from Homer3 structures, organizes it per task and
% computes a given metric from the estimated HRF
%% Clear space
clear; close all; clc
check_homer_path
%% Motor cortex template
% Brite 2x10 + 2SSC (Homer)
channelsList = [
    " HRF HbX,1,1"      %  1
    " HRF HbX,3,1"      %  2
    " HRF HbX,2,1"      %  3 (Right SSC)
    " HRF HbX,1,2"      %  4
    " HRF HbX,3,2"      %  5
    " HRF HbX,4,2"      %  6
    " HRF HbX,4,3"      %  7
    " HRF HbX,5,3"      %  8
    " HRF HbX,3,4"      %  9
    " HRF HbX,4,4"      % 10
    " HRF HbX,5,4"      % 11
    " HRF HbX,8,5"      % 12
    " HRF HbX,6,5"      % 13
    " HRF HbX,7,5"      % 14 (Left SSC)
    " HRF HbX,9,6"      % 15
    " HRF HbX,8,6"      % 16
    " HRF HbX,6,6"      % 17
    "HRF HbX,10,7"      % 18
    " HRF HbX,9,7"      % 19
    " HRF HbX,8,7"      % 20
    "HRF HbX,10,8"      % 21
    " HRF HbX,9,8"];    % 22
channelsIdx = [
    1 13;
    2 12;
    3 14;        % SSC
    4 17;
    5 16;
    6 15;
    7 22;
    8 21;
    9 20;
    10 19;
    11 18];
% Only include long channels (exclude short-separation channels SSC)
longChannelsIdx = channelsIdx([1:2,4:11]',:);

%% Finger Tapping ROI
% condition L (right hemisphere)
% " HRF HbO,4,3"      %  7
% " HRF HbO,5,3"      %  8
% " HRF HbO,4,4"      % 10
% " HRF HbO,5,4"      % 11
idxR = longChannelsIdx(:,1);

% condition R (left hemisphere)
% "HRF HbX,10,7"      % 18
% " HRF HbO,9,7"      % 19
% "HRF HbO,10,8"      % 21
%  " HRF HbO,9,8"];    % 22
idxL = longChannelsIdx(:,2);

%% List of files with the subject-specific HRF
fileList{01} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD01\PD01.mat';
fileList{02} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD02\PD02.mat';
fileList{03} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD03\PD03.mat';
fileList{04} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD04\PD04.mat';
fileList{05} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD05\PD05.mat';
fileList{06} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD06\PD06.mat';
fileList{07} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD07\PD07.mat';
fileList{08} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD08\PD08.mat';
fileList{09} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD09\PD09.mat';
fileList{10} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD10\PD10.mat';
fileList{11} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD11\PD11.mat';
fileList{12} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD12\PD12.mat';
fileList{13} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD13\PD13.mat';
fileList{14} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD14\PD14.mat';
fileList{15} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD15\PD15.mat';
fileList{16} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD16\PD16.mat';
fileList{17} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD17\PD17.mat';
fileList{18} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD18\PD18.mat';
fileList{19} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD19\PD19.mat';
fileList{20} = '..\fNIRS_Data\Parkinson\PD\derivatives\homer\PD20\PD20.mat';
fileList{21} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control01\Control01.mat';
fileList{22} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control02\Control02.mat';
fileList{23} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control03\Control03.mat';
fileList{24} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control04\Control04.mat';
fileList{25} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control05\Control05.mat';
fileList{26} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control06\Control06.mat';
fileList{27} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control07\Control07.mat';
fileList{28} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control08\Control08.mat';
fileList{29} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control09\Control09.mat';
fileList{30} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control10\Control10.mat';
fileList{31} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control11\Control11.mat';
fileList{32} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control12\Control12.mat';
fileList{33} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control13\Control13.mat';
fileList{34} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control14\Control14.mat';
fileList{35} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control15\Control15.mat';
fileList{36} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control16\Control16.mat';
fileList{37} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control17\Control17.mat';
fileList{38} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control18\Control18.mat';
fileList{39} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control19\Control19.mat';
fileList{40} = '..\fNIRS_Data\Parkinson\Control\derivatives\homer\Control20\Control20.mat';

isParkinson = [true([20 1]); false([20 1])];
nFiles = numel(fileList);
nLongChannelsSide = size(longChannelsIdx,1);

%% Extract channels data (HbO/HbR/HbT)
for iFiles = 1: nFiles
    load(fileList{iFiles});
    if iFiles==1
        HbOchannels.L = nan([nFiles,  nLongChannelsSide, 676]);
        HbOchannels.R = nan([nFiles,  nLongChannelsSide, 676]);
        HbRchannels.L = nan([nFiles,  nLongChannelsSide, 676]);
        HbRchannels.R = nan([nFiles,  nLongChannelsSide, 676]);
        HbTchannels.L = nan([nFiles,  nLongChannelsSide, 676]);
        HbTchannels.R = nan([nFiles,  nLongChannelsSide, 676]);
    end
    if size(output.dcAvg.dataTimeSeries,1) ~= 676
        % Control03 2026 samples
        % Control01 1351 samples
        % PD01  1351 samples
        % Are resampled to have the same number as the rest: 676 samples
        resamplingFactor = round(size(output.dcAvg.dataTimeSeries,1)/676);
        channelData = resample(output.dcAvg.dataTimeSeries,1,resamplingFactor);
    else
        channelData = output.dcAvg.dataTimeSeries;
        timeVector = output.dcAvg.time;
    end
    for iChannels=1:nLongChannelsSide
        for offSet = 1:3         % OffSet = 1 for HbO, 2 for HbR & 3 for HbT
            switch offSet
                case 1 % HbO
                    if isParkinson(iFiles)
                        % condition L
                        HbOchannels.L(iFiles,iChannels,:) = channelData(:,66+(idxR(iChannels)-1)*3+offSet).';
                        % condition R
                        HbOchannels.R(iFiles,iChannels,:) = channelData(:,132+(idxL(iChannels)-1)*3+offSet).';
                    else
                        % condition L
                        HbOchannels.L(iFiles,iChannels,:) = channelData(:,(idxR(iChannels)-1)*3+offSet).';
                        % condition R
                        HbOchannels.R(iFiles,iChannels,:) = channelData(:,66+(idxL(iChannels)-1)*3+offSet).';
                    end
                case 2 % HbR
                    if isParkinson(iFiles)
                        % condition L
                        HbRchannels.L(iFiles,iChannels,:) = channelData(:,66+(idxR(iChannels)-1)*3+offSet).';
                        % condition R
                        HbRchannels.R(iFiles,iChannels,:) = channelData(:,132+(idxL(iChannels)-1)*3+offSet).';
                    else
                        % condition L
                        HbRchannels.L(iFiles,iChannels,:) = channelData(:,(idxR(iChannels)-1)*3+offSet).';
                        % condition R
                        HbRchannels.R(iFiles,iChannels,:) = channelData(:,66+(idxL(iChannels)-1)*3+offSet).';
                    end
                case 3 % HbT
                    if isParkinson(iFiles)
                        % condition L
                        HbTchannels.L(iFiles,iChannels,:) = channelData(:,66+(idxR(iChannels)-1)*3+offSet).';
                        % condition R
                        HbTchannels.R(iFiles,iChannels,:) = channelData(:,132+(idxL(iChannels)-1)*3+offSet).';
                    else
                        % condition L
                        HbTchannels.L(iFiles,iChannels,:) = channelData(:,(idxR(iChannels)-1)*3+offSet).';
                        % condition R
                        HbTchannels.R(iFiles,iChannels,:) = channelData(:,66+(idxL(iChannels)-1)*3+offSet).';
                    end
            end
        end
    end
end


% HbXchannels.L or HbXchannels.R contain the average HRF per channel, per
% subject, organized as follows: (nSubjects, nChannelsPerSide, nSamples)

%% Compute HRF metrics: maxVal, timeToMax, meanVal and AUC
timeRange = [5 15];   % Original 0.5-15
% idxRange = find(timeVector>=timeRange(1), 1):find(timeVector>=timeRange(2), 1);
for offSet = 1:3         % OffSet = 1 for HbO, 2 for HbR & 3 for HbT
    for iFiles = 1:nFiles
        for iChannels=1:nLongChannelsSide
            switch offSet
                case 1 % HbO
                    % condition L
                    idxRange = find(timeVector>=timeRange(1), 1):find(timeVector>=timeRange(2), 1);
                    [HbOchannels.LmaxVal(iFiles,iChannels), idx] = max(HbOchannels.L(iFiles,iChannels,idxRange));
                    HbOchannels.LtimeToMax(iFiles,iChannels) = timeVector(idx+idxRange(1));
                    idxRange(2) = idx;
                    HbOchannels.LmeanVal(iFiles,iChannels) = mean(HbOchannels.L(iFiles,iChannels,idxRange));
                    HbOchannels.LAUC(iFiles,iChannels) = trapz(HbOchannels.L(iFiles,iChannels,idxRange));
                    HbOchannels.Lslope(iFiles,iChannels) = HbOchannels.LmaxVal(iFiles,iChannels)/HbOchannels.LtimeToMax(iFiles,iChannels);
                    % condition R
                    idxRange = find(timeVector>=timeRange(1), 1):find(timeVector>=timeRange(2), 1);
                    [HbOchannels.RmaxVal(iFiles,iChannels), idx] = max(HbOchannels.R(iFiles,iChannels,idxRange));
                    HbOchannels.RtimeToMax(iFiles,iChannels) = timeVector(idx+idxRange(1));
                    idxRange(2) = idx;
                    HbOchannels.RmeanVal(iFiles,iChannels) = mean(HbOchannels.R(iFiles,iChannels,idxRange));
                    HbOchannels.RAUC(iFiles,iChannels) = trapz(HbOchannels.R(iFiles,iChannels,idxRange));
                    HbOchannels.Rslope(iFiles,iChannels) = HbOchannels.RmaxVal(iFiles,iChannels)/HbOchannels.RtimeToMax(iFiles,iChannels);
                case 2 % HbR
                    % condition L
                    idxRange = find(timeVector>=timeRange(1), 1):find(timeVector>=timeRange(2), 1);
                    [HbRchannels.LmaxVal(iFiles,iChannels), idx] = min(HbRchannels.L(iFiles,iChannels,idxRange));
                    HbRchannels.LtimeToMax(iFiles,iChannels) = timeVector(idx+idxRange(1));
                    idxRange(2) = idx;
                    HbRchannels.LmeanVal(iFiles,iChannels) = mean(HbRchannels.L(iFiles,iChannels,idxRange));
                    HbRchannels.LAUC(iFiles,iChannels) = trapz(HbRchannels.L(iFiles,iChannels,idxRange));
                    HbRchannels.Lslope(iFiles,iChannels) = HbRchannels.LmaxVal(iFiles,iChannels)/HbRchannels.LtimeToMax(iFiles,iChannels);
                    % condition R
                    idxRange = find(timeVector>=timeRange(1), 1):find(timeVector>=timeRange(2), 1);
                    [HbRchannels.RmaxVal(iFiles,iChannels), idx] = min(HbRchannels.R(iFiles,iChannels,idxRange));
                    HbRchannels.RtimeToMax(iFiles,iChannels) = timeVector(idx+idxRange(1));
                    idxRange(2) = idx;
                    HbRchannels.RmeanVal(iFiles,iChannels) = mean(HbRchannels.R(iFiles,iChannels,idxRange));
                    HbRchannels.RAUC(iFiles,iChannels) = trapz(HbRchannels.R(iFiles,iChannels,idxRange));
                    HbRchannels.Rslope(iFiles,iChannels) = HbRchannels.RmaxVal(iFiles,iChannels)/HbRchannels.RtimeToMax(iFiles,iChannels);
                case 3 % HbT
                    % condition L
                    idxRange = find(timeVector>=timeRange(1), 1):find(timeVector>=timeRange(2), 1);
                    [HbTchannels.LmaxVal(iFiles,iChannels), idx] = max(HbTchannels.L(iFiles,iChannels,idxRange));
                    HbTchannels.LtimeToMax(iFiles,iChannels) = timeVector(idx+idxRange(1));
                    idxRange(2) = idx;
                    HbTchannels.LmeanVal(iFiles,iChannels) = mean(HbTchannels.L(iFiles,iChannels,idxRange));
                    HbTchannels.LAUC(iFiles,iChannels) = trapz(HbTchannels.L(iFiles,iChannels,idxRange));
                    HbTchannels.Lslope(iFiles,iChannels) = HbTchannels.LmaxVal(iFiles,iChannels)/HbTchannels.LtimeToMax(iFiles,iChannels);
                    % condition R
                    idxRange = find(timeVector>=timeRange(1), 1):find(timeVector>=timeRange(2), 1);
                    [HbTchannels.RmaxVal(iFiles,iChannels), idx] = max(HbTchannels.R(iFiles,iChannels,idxRange));
                    HbTchannels.RtimeToMax(iFiles,iChannels) = timeVector(idx+idxRange(1));
                    idxRange(2) = idx;
                    HbTchannels.RmeanVal(iFiles,iChannels) = mean(HbTchannels.R(iFiles,iChannels,idxRange));
                    HbTchannels.RAUC(iFiles,iChannels) = trapz(HbTchannels.R(iFiles,iChannels,idxRange));
                    HbTchannels.Rslope(iFiles,iChannels) = HbTchannels.RmaxVal(iFiles,iChannels)/HbTchannels.RtimeToMax(iFiles,iChannels);
            end
        end
    end
end
HbOdata.L = [HbOchannels.LmaxVal HbOchannels.LtimeToMax HbOchannels.LmeanVal HbOchannels.LAUC HbOchannels.Lslope];
HbOdata.R = [HbOchannels.RmaxVal HbOchannels.RtimeToMax HbOchannels.RmeanVal HbOchannels.RAUC HbOchannels.Rslope];
HbRdata.L = [HbRchannels.LmaxVal HbRchannels.LtimeToMax HbRchannels.LmeanVal HbRchannels.LAUC HbRchannels.Lslope];
HbRdata.R = [HbRchannels.RmaxVal HbRchannels.RtimeToMax HbRchannels.RmeanVal HbRchannels.RAUC HbRchannels.Rslope];
HbTdata.L = [HbTchannels.LmaxVal HbTchannels.LtimeToMax HbTchannels.LmeanVal HbTchannels.LAUC HbTchannels.Lslope];
HbTdata.R = [HbTchannels.RmaxVal HbTchannels.RtimeToMax HbTchannels.RmeanVal HbTchannels.RAUC HbTchannels.Rslope];
clear offSet iChannels iFiles output Folder idx
save ('..\fNIRS_Data\channelData_5sec.mat')
disp('channel by channel metrics computed!')
% EOF