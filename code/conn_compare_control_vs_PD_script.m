%% Full connectivity matrix comparison
% Controls compared to Parkinson's disease patients
% This is the second script to be run (2/4)
% First, you have to run conn_mat_group_level_script.m
clear; close all; clc
groupNames = {'Control' 'PD'};
alpha = 0.05;
[chIdxL, chIdxR] = get_channels_from_template('motor');
disp('Control vs. PD (channels)')

%% HbO
fileGroup1 = '..\data\controlConnHbO.mat';     % CHANGE AS NEEDED!
fileGroup2 = '..\data\PDConnHbO.mat';          % CHANGE AS NEEDED!
saveFileName = 'conn_controlPD_GroupCompHbO'; % CHANGE AS NEEDED!
conn_mat_group_comparison(fileGroup1, fileGroup2, groupNames, saveFileName,...
    alpha, chIdxL, chIdxR);

%% HbR
fileGroup1 = '..\data\controlConnHbR.mat';     % CHANGE AS NEEDED!
fileGroup2 = '..\data\PDConnHbR.mat';          % CHANGE AS NEEDED!
saveFileName = 'conn_control_PD_GroupCompHbR'; % CHANGE AS NEEDED!
conn_mat_group_comparison(fileGroup1, fileGroup2, groupNames, saveFileName,...
    alpha, chIdxL, chIdxR);
disp('Full connectivity matrix group comparison done (HbR)')

%% HbT
fileGroup1 = '..\data\controlConnHbT.mat';     % CHANGE AS NEEDED!
fileGroup2 = '..\data\PDConnHbT.mat';          % CHANGE AS NEEDED!
saveFileName = 'conn_control_PD_GroupCompHbT'; % CHANGE AS NEEDED!
conn_mat_group_comparison(fileGroup1, fileGroup2, groupNames, saveFileName,...
    alpha, chIdxL, chIdxR);
disp('Full connectivity matrix group comparison done (HbT)')
% EOF
