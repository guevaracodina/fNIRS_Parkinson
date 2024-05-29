function [rMatFDR, zMatFDR, pMatFDR, pMat, keepRun] = conn_mat_subject_level(iHb, runName)
% Computes the full connectivity matrix at subject level
% Works with SNIRF-compatible files, located in derivatives/homer Homer3 (v1.54.0)
%% Extract data from individual runs
% runName = '1_resting.mat';
load(runName)
dc = output.dc.GetDataTimeSeries('reshape');
t = output.dc.GetTime();
Y = squeeze(dc(:,iHb,:));
doPreWhitening = false;
doPearson = true;
% List channels names
% for idx = 1:numel(output.dc.measurementList)
%     if contains(output.dc.measurementList(idx).dataTypeLabel,'HbO')
%         fprintf('%s S%02dD%02d\n', output.dc.measurementList(idx).dataTypeLabel, output.dc.measurementList(idx).sourceIndex, output.dc.measurementList(idx).detectorIndex);
%     end
% end
[~, runFolder] = fileparts(fileparts(runName));
fprintf('Processing %s...\t', runFolder);

%% Discard subjects with less than 120 seconds of recordings
ts = mean(diff(t));        % Sampling period
minRecordingTime = 120;
keepRun = sum(output.misc.tIncAuto{1})*ts >= minRecordingTime; % Keep current run/subject
% Discard first 100 seconds
nFirstSamples2Discard = round(100/ts);
Y = Y(nFirstSamples2Discard:end,:);
t = t(nFirstSamples2Discard:end,:);
if ~keepRun
    % If subject is discarded
    rMatFDR = [];
    zMatFDR = [];
    pMatFDR = [];
    pMat = [];
    return
end
% figure;
% Plot included time
% subplot(311);  hold on
% stem(t, max(max(Y))*~output.misc.tIncAuto{1})
% Plot channels
% plot(t,Y); title('Original')

%% Find nans and replace them
idxInf = find(isinf(Y));
Y(idxInf) = mean([Y(idxInf-1); Y(idxInf+1)]);

%% Discard segments with motion artifacts
% yHatDiscard = Y(boolean(output.misc.tIncAuto{1}),:);
tIncVec = output.misc.tIncAuto{1};
tIncVec = tIncVec(nFirstSamples2Discard:end);
yHatDiscard = Y(boolean(tIncVec),:); 
% yHatDiscard = yHat;
% Plot channels
% subplot(313); plot(t(boolean(output.misc.tIncAuto{1})),yHatDiscard); title('Artifacts discarded')

%% Prewhitening OR global signal regression
if doPreWhitening
    yHat = prewhiten(yHatDiscard);
else
    yHat = conn_regress_global(yHatDiscard);
end

%% Perform functional connectivity at subject level
fisherz = @(r) 0.5*log( (1+r)./(1-r) );         % Fisher transform
% inv_fisherz = @(z) (exp(2*z)-1) ./ (exp(2*z)+1);% Inverse Fisher transform
nChannels= size(yHat,2);         % Number of channels
alpha = 0.05;
if doPearson
    % Pearson's correlation
    [rMat, pMat] = corr(yHat);
else
    % Spearman's correlation
    [rMat, pMat] = corr(yHat, 'type', 'Spearman');
end
zMat = fisherz(rMat);
[pMatFDR, idxPvals] = conn_mat_fdr(pMat, alpha);
rMatFDR = nan(nChannels);
rMatFDR(idxPvals) = rMat(idxPvals);
zMatFDR = nan(nChannels);
zMatFDR(idxPvals) = zMat(idxPvals);
fprintf('%s done!\n', runFolder);
% figure; imagesc(rMatFDR); axis image; colorbar
% colormap([0 0 0; ioi_get_colormap('bipolar')])
% Perform statistical analyisis at group level

end


