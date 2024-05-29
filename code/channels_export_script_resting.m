%% This script retrieves data from Homer3 structures, organizes it per task and
% computes a given metric from the estimated HRF
%% Clear space
clear; close all; clc
check_homer_path

%% Motor cortex template
% Brite 2x10 + 2SSC (Homer)
% channelsList = [
%     " HRF HbX,1,1"      %  1
%     " HRF HbX,3,1"      %  2
%     " HRF HbX,2,1"      %  3 (Right SSC)
%     " HRF HbX,1,2"      %  4
%     " HRF HbX,3,2"      %  5
%     " HRF HbX,4,2"      %  6
%     " HRF HbX,4,3"      %  7
%     " HRF HbX,5,3"      %  8
%     " HRF HbX,3,4"      %  9
%     " HRF HbX,4,4"      % 10
%     " HRF HbX,5,4"      % 11
%     " HRF HbX,8,5"      % 12
%     " HRF HbX,6,5"      % 13
%     " HRF HbX,7,5"      % 14 (Left SSC)
%     " HRF HbX,9,6"      % 15
%     " HRF HbX,8,6"      % 16
%     " HRF HbX,6,6"      % 17
%     "HRF HbX,10,7"      % 18
%     " HRF HbX,9,7"      % 19
%     " HRF HbX,8,7"      % 20
%     "HRF HbX,10,8"      % 21
%     " HRF HbX,9,8"];    % 22
% channelsIdx = [
%     1 13;
%     2 12;
%     3 14;        % SSC
%     4 17;
%     5 16;
%     6 15;
%     7 22;
%     8 21;
%     9 20;
%     10 19;
%     11 18];
% Only include long channels (exclude short-separation channels SSC)
% longChannelsIdx = channelsIdx([1:2,4:11]',:);

%% Finger Tapping ROI
% condition L (right hemisphere)
% " HRF HbO,4,3"      %  7
% " HRF HbO,5,3"      %  8
% " HRF HbO,4,4"      % 10
% " HRF HbO,5,4"      % 11
% idxR = longChannelsIdx(:,1);

% condition R (left hemisphere)
% "HRF HbX,10,7"      % 18
% " HRF HbO,9,7"      % 19
% "HRF HbO,10,8"      % 21
%  " HRF HbO,9,8"];    % 22
% idxL = longChannelsIdx(:,2);

%% List of files with the subject-specific HRF
fileList{01} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD01\1_resting_seg_1.mat';
fileList{02} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD02\1_resting_seg_1.mat';
fileList{03} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD03\1_resting_seg_1.mat';
fileList{04} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD04\1_resting_seg_1.mat';
fileList{05} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD05\1_resting_seg_1.mat';
fileList{06} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD06\1_resting_seg_1.mat';
fileList{07} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD07\1_resting_seg_1.mat';
fileList{08} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD08\1_resting_seg_1.mat';
fileList{09} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD09\1_resting_seg_1.mat';
fileList{10} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD10\1_resting_seg_1.mat';
fileList{11} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD11\1_resting_seg_1.mat';
fileList{12} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD12\1_resting_seg_1.mat';
fileList{13} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD13\1_resting_seg_1.mat';
fileList{14} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD14\1_resting_seg_1.mat';
fileList{15} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD15\1_resting_seg_1.mat';
fileList{16} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD16\1_resting_seg_1.mat';
fileList{17} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD17\1_resting_seg_1.mat';
fileList{18} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD18\1_resting_seg_1.mat';
fileList{19} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD19\1_resting_seg_1.mat';
fileList{20} = '..\fNIRS_Data\Parkinson\resting_state\PD\derivatives\homer\PD20\1_resting_seg_1.mat';
fileList{21} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control01\1_resting_seg_1.mat';
fileList{22} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control02\1_resting_seg_1.mat';
fileList{23} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control03\1_resting_seg_1.mat';
fileList{24} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control04\1_resting_seg_1.mat';
fileList{25} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control05\1_resting_seg_1.mat';
fileList{26} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control06\1_resting_seg_1.mat';
fileList{27} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control07\1_resting_seg_1.mat';
fileList{28} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control08\1_resting_seg_1.mat';
fileList{29} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control09\1_resting_seg_1.mat';
fileList{30} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control10\1_resting_seg_1.mat';
fileList{31} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control11\1_resting_seg_1.mat';
fileList{32} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control12\1_resting_seg_1.mat';
fileList{33} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control13\1_resting_seg_1.mat';
fileList{34} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control14\1_resting_seg_1.mat';
fileList{35} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control15\1_resting_seg_1.mat';
fileList{36} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control16\1_resting_seg_1.mat';
fileList{37} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control17\1_resting_seg_1.mat';
fileList{38} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control18\1_resting_seg_1.mat';
fileList{39} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control19\1_resting_seg_1.mat';
fileList{40} = '..\fNIRS_Data\Parkinson\resting_state\Control\derivatives\homer\Control20\1_resting_seg_1.mat';
% isParkinson = [true([20 1]); false([20 1])];
nFiles = numel(fileList);
% nLongChannelsSide = size(longChannelsIdx,1);

%% Extract channels data (HbO/HbR/HbT) to tab-separated values (.tsv)
for iFiles = 1: nFiles
    load(fileList{iFiles});
        channelData = output.dc.dataTimeSeries;
        timeVector = output.dc.time;
        meas  = output.dc.measurementList;
        measList = {'time'};
        for iMeas = 1:numel(meas)
            measList = [measList, strcat(meas(iMeas).dataTypeLabel, '_', ...
                num2str(meas(iMeas).sourceIndex), '_', num2str(meas(iMeas).detectorIndex))];
        end
        channelsTable = array2table([timeVector channelData]);
        channelsTable.Properties.VariableNames = measList;
        fName = regexprep(fileList{iFiles}, '\.mat$', '_export.tsv');
        writetable(channelsTable, fName, 'FileType', 'text', 'Delimiter', '\t');
        %% Extract Stimuli
        if false
        for idxStim=1:numel(output.misc.stim)
            if strcmp(output.misc.stim(idxStim).name, 'L')
                stimVectorL = output.misc.stim(idxStim).data(:,1);
            elseif strcmp(output.misc.stim(idxStim).name, 'R')
                stimVectorR = output.misc.stim(idxStim).data(:,1);
            end 
        end
        n = max(numel(stimVectorL),numel(stimVectorR));
        stimVectorL(end+1:n) = nan;
        stimVectorR(end+1:n) = nan;
        stimTable = array2table([stimVectorL stimVectorR]);
        stimTable.Properties.VariableNames = {'L' 'R'};
        fName = regexprep(fileList{iFiles}, '\.mat$', '_export_stim.tsv');
        writetable(stimTable, fName, 'FileType', 'text', 'Delimiter','\t');
        end
        %% Discard segments with motion artifacts
        motionTable = array2table(output.misc.tIncAuto{1});
        motionTable.Properties.VariableNames = {'MotionArtifact'};
        fName = regexprep(fileList{iFiles}, '\.mat$', '_export_motion.tsv');
        writetable(motionTable, fName, 'FileType', 'text', 'Delimiter','\t');
        fprintf('Subject %d done!\n',iFiles)
end

disp('Data exported!')
% EOF