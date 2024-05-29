clear; close all; clc
check_homer_path

%% Coordinates from digpts
sourceCoordinates = [
81.9	-10.5	-6.8
70.2	31.6	-13.9
73.3	18.5	16.9
74.2	-27     53.3
55.4	-3.6	69.9
-81.9	-10.5	-6.8
-70.2	31.6	-13.9
-73.3	18.5	16.9
-74.2	-27     53.3
-55.4	-3.6	69.9];  % 10 sources

detectorCoordinates = [
72.6	23.3	-9.7
81.6	-15.3	22
51.4	-36.4	80.7
71.9	2.8     42.7
-72.6	23.3	-9.7
-81.6	-15.3	22
-51.4	-36.4	80.7
-71.9	2.8     42.7];  % 8 detectors

%% Measurements list
load('C:\Edgar\Dropbox\Shared folders\fNIRS\software\fNIRS_Data\Parkinson\PD\derivatives\homer\PD.mat')
idx=1;
for idxMeas = 1:3:66
    SDmeas(idx, 1) = output.dcAvg.measurementList(idxMeas).sourceIndex;
    SDmeas(idx, 2) = output.dcAvg.measurementList(idxMeas).detectorIndex;
    idx=idx+1;
end

%% Coordinates
for idx=1:size(SDmeas, 1)
    SDcoord(idx, :) = mean([sourceCoordinates(SDmeas(idx,1),:); detectorCoordinates(SDmeas(idx,2),:)]);
end

%% Remove SSC
% 03.	S02D01    (Right SSC)
% 14.	S07D05    (Left SSC)
SDmeas([3, 14], :) = [];
SDcoord([3, 14], :) = [];

%% List channels labels
for idx=1:20, fprintf('S%02d_D%02d\n', SDmeas(idx,1), SDmeas(idx,2)); end

%% Create Mat and save into matrices.mat
% The first 20 subjects are PD, then 20 controls
% Load HbO connectivity matrices
load('C:\Edgar\Dropbox\Shared folders\fNIRS\software\data\PDConnHbO.mat', 'rMatFDR')
Mat = zeros([20 20 40]);
for idx=1:20
    tmpCorrMat = rMatFDR{idx};
    tmpCorrMat([3, 14], :) = []; 
    tmpCorrMat(:,[3, 14]) = []; 
    Mat(:,:,idx) = tmpCorrMat;
end
clear rMatFDR tmpCorrMat
load('C:\Edgar\Dropbox\Shared folders\fNIRS\software\data\controlConnHbO.mat', 'rMatFDR')
for idx=1:20
    tmpCorrMat = rMatFDR{idx};
    tmpCorrMat([3, 14], :) = []; 
    tmpCorrMat(:,[3, 14]) = []; 
    Mat(:,:,idx+20) = tmpCorrMat;
end
% save('C:\Edgar\Dropbox\Matlab\NBS\Parkinson\matrices.mat', 'Mat')
% EOF



