clear; close all; clc
check_homer_path;
%% Displays stats baseline vs. condition:  Finger-Tapping
TctrlHbO = displayStats('..\fNIRS_Data\Control.mat', 1, 0.05, 0);
TctrlHbR = displayStats('..\fNIRS_Data\Control.mat', 2, 0.05, 0);
TctrlHbT = displayStats('..\fNIRS_Data\Control.mat', 3, 0.05, 0);

TPDHbO = displayStats('..\fNIRS_Data\PD.mat', 1, 0.05, 0);
TPDHbR = displayStats('..\fNIRS_Data\PD.mat', 2, 0.05, 0);
TPDHbT = displayStats('..\fNIRS_Data\PD.mat', 3, 0.05, 0);

%%  Displays stats baseline vs. condition: Walking task
TctrlHbOWalk = displayStats('..\fNIRS_Data\Parkinson\walking\Control\derivatives\homer\Control.mat', 1, 0.05, 0);
TctrlHbRWalk = displayStats('..\fNIRS_Data\Parkinson\walking\Control\derivatives\homer\Control.mat', 2, 0.05, 0);
TctrlHbTWalk = displayStats('..\fNIRS_Data\Parkinson\walking\Control\derivatives\homer\Control.mat', 3, 0.05, 0);

TPDHbOWalk = displayStats('..\fNIRS_Data\Parkinson\walking\PD\derivatives\homer\PD.mat', 1, 0.05, 0);
TPDHbRWalk = displayStats('..\fNIRS_Data\Parkinson\walking\PD\derivatives\homer\PD.mat', 2, 0.05, 0);
TPDHbTWalk = displayStats('..\fNIRS_Data\Parkinson\walking\PD\derivatives\homer\PD.mat', 3, 0.05, 0);
% save('..\fNIRS_Data\group_stats_active_baseline')