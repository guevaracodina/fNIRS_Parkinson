function [zMatgroup1Mean, zMatgroup2Mean, P, pFDR] = conn_mat_group_comparison(fileGroup1,...
    fileGroup2, groupNames, saveFileName, alpha, chIdxL, chIdxR)
% Works with SNIRF-compatible files, located in derivatives/homer Homer3 (v1.54.0)
%% Load first group
load(fileGroup1)
doBonferroni = false;   % Choice of multiple comparisons

%% Gather connectivity matrices from first group
zMatgroup1 = [];
rMatgroup1 = [];
subjectNamegroup1 = {};
for iRuns=1:nRuns
    if keepRun(iRuns)
        zMatgroup1 = cat(3,zMatgroup1, zMatFDR{iRuns});
        rMatgroup1 = cat(3,rMatgroup1, zMatFDR{iRuns});
        subjectNamegroup1 = [subjectNamegroup1; runName{iRuns}];
    end
end

%% Load second group
clearvars -except zMatgroup1 rMatgroup1 subjectNamegroup1 fileGroup2 iHb saveFileName groupNames nRuns alpha chIdxL chIdxR doBonferroni
load(fileGroup2)

%% Gather connectivity matrices from second group
zMatgroup2 = [];
rMatgroup2 = [];
subjectNamegroup2 = {};
for iRuns=1:nRuns
    if keepRun(iRuns)
        zMatgroup2 = cat(3,zMatgroup2, zMatFDR{iRuns});
        rMatgroup2 = cat(3,rMatgroup2, zMatFDR{iRuns});
        subjectNamegroup2 = [subjectNamegroup2; runName{iRuns}];
    end
end
clearvars -except zMatgroup1 rMatgroup1 subjectNamegroup1 zMatgroup2 rMatgroup2 subjectNamegroup2 iHb saveFileName groupNames alpha chIdxL chIdxR doBonferroni

%% Mean correlation matrices
rMatgroup1Mean = nanmean(rMatgroup1, 3);
rMatgroup2Mean = nanmean(rMatgroup2, 3);
zMatgroup1Mean = nanmean(zMatgroup1, 3);
zMatgroup2Mean = nanmean(zMatgroup2, 3);
chIdx = zeros([2*numel(chIdxL) 1]);
chIdx(1:2:end) = chIdxL; chIdx(2:2:end) = chIdxR; 
minVal = min([zMatgroup1Mean(:); zMatgroup2Mean(:)]);
maxVal = max([zMatgroup1Mean(:); zMatgroup2Mean(:)]);

%% Perform between-group comparison
for iChannels = 1:size(zMatgroup2, 1)
    for jChannels = 1:size(zMatgroup2, 2)
        if all(isnan(squeeze(zMatgroup2(iChannels, jChannels,:)))) || all(isnan(squeeze(zMatgroup2(iChannels, jChannels,:))))
            P(iChannels, jChannels) = nan;
            H(iChannels, jChannels) = nan;
        else
            [P(iChannels, jChannels),H(iChannels, jChannels)] = ...
                ranksum(squeeze(zMatgroup2(iChannels, jChannels,:)), squeeze(zMatgroup1(iChannels, jChannels,:)), 'tail', 'both');
        end
    end
end

%% Correct for multiple comparisons
pVec = P(find(tril(ones(size(P)), -1))); % Only lower triangular part
nEdges = numel(pVec);
if doBonferroni
    pFDR = P;
    alphaBon = alpha/nEdges;
else
    [pFDR, ~] = conn_mat_fdr(P, alpha);
end
if doBonferroni
    fprintf('%d of %d edges showed a significant difference in fc before Bonferroni correction\n',sum(pVec(:)<alpha), nEdges)
    fprintf('%d of %d edges showed a significant difference in fc after Bonferroni correction\n',sum(pFDR(:)<alphaBon), nEdges)
else
    fprintf('%d of %d edges showed a significant difference in fc before FDR correction\n',sum(pVec(:)<alpha), nEdges)
    fprintf('%d of %d edges showed a significant difference in fc after FDR correction\n',sum(pFDR(:)<alpha), nEdges)
end
ii = ones(size(pFDR));
idx = tril(ii);
Pthreshold = P;
Pthreshold(P>=alpha) = nan;
if doBonferroni
    pFDR(pFDR>=alphaBon) = nan;
end
% pFDR(~idx) = nan;
save(fullfile('..\data\', [saveFileName '.mat']));

%% Find contrast type (HbO/HbR/HbT)
% switch iHb
%     case 1
%         strContrast = '_HbO';
%     case 2
%         strContrast = '_HbR';
%     case 3
%         strContrast = '_HbT';
% end
% Get Hb string label
strContrast = get_Hb_string(iHb);

%% Display images
hFig = figure; set(hFig,'color', 'w', 'Name', strContrast)
subplot(221); imagesc(zMatgroup1Mean(chIdx, chIdx), [minVal maxVal]); title(groupNames{1})
xlabel ('Channels'); ylabel('Channels')
axis image; a = colorbar; a.Label.String = 'z-score';  colormap(ioi_get_colormap('bipolar'))
axisLabels = [chIdxL chIdxR];
set(gca, 'XTick', 1:2:numel([chIdxL chIdxR]), 'XTickLabel', axisLabels(1:2:end))
set(gca, 'YTick', 1:2:numel([chIdxL chIdxR]), 'YTickLabel', axisLabels(1:2:end))
subplot(222); imagesc(zMatgroup2Mean(chIdx, chIdx), [minVal maxVal]); title(groupNames{2})
xlabel ('Channels'); ylabel('Channels')
axis image; a = colorbar; a.Label.String = 'z-score'; colormap(ioi_get_colormap('bipolar'))
set(gca, 'XTick', 1:2:numel([chIdxL chIdxR]), 'XTickLabel', axisLabels(1:2:end))
set(gca, 'YTick', 1:2:numel([chIdxL chIdxR]), 'YTickLabel', axisLabels(1:2:end))
subplot(223); 
minValP = min(-log10(Pthreshold(:)));
maxValP = max(-log10(Pthreshold(:)));
imagesc(-log10(Pthreshold(chIdx, chIdx)), [minValP, maxValP]); 
% title('P-value matrix -log(p)')
title(sprintf('%d of %d edges (p<%0.3f)',sum(pVec(:)<alpha), nEdges, alpha))
xlabel ('Channels'); ylabel('Channels')
axis image; colormap(gca, ioi_get_colormap('octgold'))
a = colorbar; a.Label.String = '-log(p)'; %colormap(ioi_get_colormap('octgold'))
set(gca, 'XTick', 1:2:numel([chIdxL chIdxR]), 'XTickLabel', axisLabels(1:2:end))
set(gca, 'YTick', 1:2:numel([chIdxL chIdxR]), 'YTickLabel', axisLabels(1:2:end))
subplot(224); 
imagesc(-log10(pFDR(chIdx, chIdx)), [minValP, maxValP]); 
if doBonferroni
    title(sprintf('Bonferroni-corrected \nP-value matrix -log(p)'))
else
    title(sprintf('FDR-corrected \nP-value matrix -log(p)'))
end
xlabel ('Channels'); ylabel('Channels')
axis image; colormap(gca, ioi_get_colormap('octgold'))
a = colorbar; a.Label.String = '-log(p)'; %colormap(ioi_get_colormap('octgold'))
set(gca, 'XTick', 1:2:numel([chIdxL chIdxR]), 'XTickLabel', axisLabels(1:2:end))
set(gca, 'YTick', 1:2:numel([chIdxL chIdxR]), 'YTickLabel', axisLabels(1:2:end))

%% Save figure
% Specify window units
set(hFig, 'units', 'inches')
% Change figure and paper size
set(hFig, 'Position', [0.1 0.1 6 6])
set(hFig, 'PaperPosition', [0.1 0.1 6 6])
% Save as PNG
print(hFig, '-dpng', fullfile('..\figures\', [saveFileName '_conn_mat.png']), '-r300');
fprintf('Full connectivity matrix group comparison done (%s)\n', strContrast)
end
% EOF