%% Compute connectivity matrix for all groups (Parkinson vs. Control)
% This is the first script to be run (1/4)
% Works with SNIRF-compatible files, located in derivatives/homer Homer3 (v1.54.0)
%% Load channel by channel data
clear; close all; clc
check_homer_path
disp('Computing connectivity matrices (channel by channel)')
controlDir = 'D:\Edgar\Parkinson\walking\Control\derivatives\homer';
ParkinsonDir = 'D:\Edgar\Parkinson\walking\PD\derivatives\homer';

for iHb = 1:3               % 1=HbO, 2=HbR, 3=HbT
    % Control Group
    [control.rMatFDR, control.zMatFDR, control.pMatFDR, control.pMat, control.keepRun] = ...
        conn_mat_group_level(controlDir, iHb, 'walk_controlConn');
    % Parkinson Group
    [PD.rMatFDR, PD.zMatFDR, PD.pMatFDR, PD.pMat, PD.keepRun] = ...
        conn_mat_group_level(ParkinsonDir, iHb, 'walk_PDConn');
    % Get Hb string label
    strContrast = get_Hb_string(iHb);
    % Save all fc data
    save(fullfile('..\data\', ['walk_all_significant_connections_' strContrast '.mat']));
end
disp('Connectivity matrices (channel by channel) computed!')
% EOF