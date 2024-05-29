function [rMatFDR, zMatFDR, pMatFDR, pMat, keepRun] = conn_mat_group_level(currentDir, iHb, saveFileName)
% Computes group-level functional connectivity matrix
% Works with SNIRF-compatible files, located in derivatives/homer Homer3 (v1.54.0)
sDir = dir(fullfile(currentDir));
nRuns = 0;
for iFiles=1:numel(sDir)
    if sDir(iFiles).isdir
        nRuns = nRuns + 1;
    end
end
nRuns = nRuns - 2;    % Remove . & .. dirs
rMatFDR = cell([nRuns 1]);
zMatFDR = cell([nRuns 1]);
pMatFDR = cell([nRuns 1]);
runName = cell([nRuns 1]);
pMat = cell([nRuns 1]);
keepRun = false([nRuns 1]);
iRuns=0;
for iFiles = 1:numel(sDir)
    if ~strcmp(sDir(iFiles).name, '.') && ~strcmp(sDir(iFiles).name, '..') && sDir(iFiles).isdir
        iRuns = iRuns+1;
        currDirMat = dir(fullfile(currentDir, sDir(iFiles).name, '*.mat'));
        % Always consider the first file to contain the resting-sate data
        % usually '1_resting.mat'
        runName{iRuns} = fullfile(currentDir, sDir(iFiles).name, currDirMat(1).name);
        [rMatFDR{iRuns}, zMatFDR{iRuns}, pMatFDR{iRuns}, pMat{iRuns}, keepRun(iRuns)] = ...
            conn_mat_subject_level(iHb, runName{iRuns});
    end
end
fprintf('Kept %d out of %d runs in folder %s\n', sum(keepRun), nRuns, currentDir)
% Get Hb string label
strContrast = get_Hb_string(iHb);
saveFileName = strcat(saveFileName, strContrast);
save(fullfile('..\data\',[saveFileName '.mat']), 'currentDir', 'iHb', 'keepRun', ...
    'nRuns', 'pMat', 'pMatFDR', 'rMatFDR', 'runName', 'sDir', 'zMatFDR')
fprintf('Contrast %s, folder %s done!\n', strContrast, currentDir);
end

% EOF