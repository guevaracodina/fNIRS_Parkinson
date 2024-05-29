%% Interhemispherical correlations script 
% This is the third script to be run (3/4)
% First, you have to run walk_conn_mat_group_level_script.m
% Then you need to run walk_conn_compare_control_vs_PD_script.m
%% Controls vs. Parkinson's Disease
clear; 
groupNames = {'Control' 'PD'};
disp('Controls vs. PD Interhemispheric correlation (channels)')
[chIdxL, chIdxR] = get_channels_from_template('motor');

%% Interhemispherical connectivity HbO
controlColor = [1 0 0]; % Control HbO color
PDcolor = [1 0 1];      % PD HbO color
controlGroupHbO = '..\data\walk_controlConnHbO.mat';
PDgroupHbO = '..\data\walk_PDConnHbO.mat';
saveFileNameHbO = 'walk_conn_InterHC_HbO';
% Perform inter-hemispherical connectivity (InterHC) for HbO
conn_mat_group_comparison_InterHC(controlGroupHbO, PDgroupHbO, groupNames, saveFileNameHbO, ...
    chIdxL, chIdxR, controlColor, PDcolor);

%% Interhemispherical connectivity HbR
controlColor = [0 0 1]; % Control HbR color
PDcolor = [0 1 1];      % PD HbR color
controlGroupHbR = '..\data\walk_controlConnHbR.mat';
PDgroupHbR = '..\data\walk_PDConnHbR.mat';
saveFileNameHbR = 'walk_conn_InterHC_HbR';
% Perform inter-hemispherical connectivity (InterHC) for HbR
conn_mat_group_comparison_InterHC(controlGroupHbR, PDgroupHbR, groupNames, saveFileNameHbR, ...
    chIdxL, chIdxR, controlColor, PDcolor);

%% Interhemispherical connectivity HbT
controlColor = [0.00787401574803150,0.412505789717462,0.284113015284854]; % Control HbT color
PDcolor = [0 1 0];  % PD HbT color
controlGroupHbT = '..\data\walk_controlConnHbT.mat';
PDgroupHbT = '..\data\walk_PDConnHbT.mat';
saveFileNameHbT = 'walk_conn_InterHC_HbT';
% Perform inter-hemispherical connectivity (InterHC) for HbT
conn_mat_group_comparison_InterHC(controlGroupHbT, PDgroupHbT, groupNames, saveFileNameHbT, ...
    chIdxL, chIdxR, controlColor, PDcolor);

% EOF