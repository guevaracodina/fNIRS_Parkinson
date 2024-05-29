function [zMatgroup1Mean, zMatgroup2Mean, rMatgroup1Mean, rMatgroup2Mean, P] = ...
    conn_mat_group_comparison_InterHC(fileGroup1, fileGroup2, groupNames, saveFileName, ...
    chIdxL, chIdxR, group1Color, group2Color)
%% Load first group to compute Interhemispheric Correlation (InterHC)
% TO DO: choose color and symbol, fix graph limits
load(fileGroup1)

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
clearvars -except zMatgroup1 rMatgroup1 subjectNamegroup1 fileGroup2 iHb saveFileName groupNames nRuns chIdxL chIdxR group1Color group2Color
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
clearvars -except zMatgroup1 rMatgroup1 subjectNamegroup1 zMatgroup2 rMatgroup2 subjectNamegroup2 iHb saveFileName groupNames chIdxL chIdxR group1Color group2Color

%% Median correlation matrices
rMatgroup1Mean = nanmedian(rMatgroup1, 3);
rMatgroup2Mean = nanmedian(rMatgroup2, 3);
zMatgroup1Mean = nanmedian(zMatgroup1, 3);
zMatgroup2Mean = nanmedian(zMatgroup2, 3);
chIdx = zeros([2*numel(chIdxL) 1]);
chIdx(1:2:end) = chIdxL; chIdx(2:2:end) = chIdxR;
minVal = min([zMatgroup1Mean(:); zMatgroup2Mean(:)]);
maxVal = max([zMatgroup1Mean(:); zMatgroup2Mean(:)]);

%% Perform between-group comparison
% across subjects NOT across channels
for iSubjects1 = 1:size(zMatgroup1,3)
%     iInterHC = 1;
    for iCh = 1:numel(chIdxL)
        zVec1(iSubjects1,iCh) = zMatgroup1(chIdxL(iCh), chIdxR(iCh), iSubjects1);
        rVec1(iSubjects1,iCh) = rMatgroup1(chIdxL(iCh), chIdxR(iCh), iSubjects1);
%         iInterHC = iInterHC + 1;
    end
end
for iSubjects2 = 1:size(zMatgroup2,3)
%     iInterHC = 1;
    for iCh = 1:numel(chIdxL)
        zVec2(iSubjects2,iCh) = zMatgroup2(chIdxL(iCh), chIdxR(iCh), iSubjects2);
        rVec2(iSubjects2,iCh) = rMatgroup2(chIdxL(iCh), chIdxR(iCh), iSubjects2);
%         iInterHC = iInterHC + 1;
    end
end

% Compute median InterHC per subject
zVec1SubjMean = nanmedian(zVec1,2);
zVec2SubjMean = nanmedian(zVec2,2);
rVec1SubjMean = nanmedian(rVec1,2);
rVec2SubjMean = nanmedian(rVec2,2);

% Remove outliers
zVec1SubjMean = zVec1SubjMean(~isoutlier(zVec1SubjMean, 'gesd', 'MaxNumOutliers', 2));
zVec2SubjMean = zVec2SubjMean(~isoutlier(zVec2SubjMean, 'gesd', 'MaxNumOutliers', 2));
rVec1SubjMean = rVec1SubjMean(~isoutlier(rVec1SubjMean, 'gesd', 'MaxNumOutliers', 2));
rVec2SubjMean = rVec2SubjMean(~isoutlier(rVec2SubjMean, 'gesd', 'MaxNumOutliers', 2));

% for iChannels = 1:size(zMatgroup2, 1)
%     for jChannels = 1:size(zMatgroup2, 2)
%         if all(isnan(squeeze(zMatgroup2(iChannels, jChannels,:)))) || all(isnan(squeeze(zMatgroup2(iChannels, jChannels,:))))
%             P(iChannels, jChannels) = nan;
%             H(iChannels, jChannels) = nan;
%         else
%             [P(iChannels, jChannels),H(iChannels, jChannels)] = ...
%                 ranksum(squeeze(zMatgroup2(iChannels, jChannels,:)), squeeze(zMatgroup1(iChannels, jChannels,:)), 'tail', 'both');
%         end
%     end
% end
% %% Extract only symmetrical channels
% zMat1org = zMatgroup1Mean(chIdx, chIdx);
% zMat2org = zMatgroup2Mean(chIdx, chIdx);
% rMat1org = rMatgroup1Mean(chIdx, chIdx);
% rMat2org = rMatgroup2Mean(chIdx, chIdx);
% % pMatorg = P(chIdx, chIdx);
% idxInterHC = 1;
% for iCh=1:2:41
%     zVec1(idxInterHC,:) = zMat1org(iCh, iCh+1);
%     zVec2(idxInterHC,:) = zMat2org(iCh, iCh+1);
%     rVec1(idxInterHC,:) = rMat1org(iCh, iCh+1);
%     rVec2(idxInterHC,:) = rMat2org(iCh, iCh+1);
% %     pVec(idxInterHC,:) = pMatorg(iCh, iCh+1);
%     idxInterHC = idxInterHC + 1;  
% end
[P,H] = ranksum(zVec1SubjMean, zVec2SubjMean, 'tail', 'both');
save(fullfile('..\data\', [saveFileName '.mat']));

%% Boxplots of InterHC
% group1Color = [181, 39, 53]/255;      % 1st group
% group2Color = [109, 167, 75]/255;   % 2nd group
groupVec = [ones(size(zVec1SubjMean)); 2*ones(size(zVec2SubjMean))];
colors = repmat({group1Color, group2Color},[1 numel(unique(groupVec))/2]);
myMarkers = repmat({'o', 'x'},[1 numel(unique(groupVec))/2]);
allData = {rVec1SubjMean; rVec2SubjMean};
% Get Hb string label
HbString = get_Hb_string(iHb);
% Boxplot
hFig = figure; set(hFig, 'color', 'w', 'Name', HbString);
h = boxplot(cell2mat(allData),groupVec, 'colors', [0 0 0]);
set(h, 'linewidth', 0.5)
lines = findobj(hFig, 'type', 'line', 'Tag', 'Median');
set(lines, 'LineWidth', 2.5);
xCenter = 1:numel(allData);
% xTicks = movmean(xCenter,2); xTicks = xTicks(2:2:end);
set(gca,'XTick', xCenter);
set(gca,'XTickLabel', groupNames)
% ylim([0 1])
ylim([-0.6 2.5])        % Change as needed
hold on

% Scatter plot
for idx = 1:numel(allData)
%     scatter(repmat(xCenter(idx),size(allData{idx})),...
%         allData{idx},'filled','MarkerFaceAlpha',0.8,'MarkerFaceColor',colors{idx},...
%         'jitter','on','jitterAmount',0.15, 'Marker');
    scatter(repmat(xCenter(idx),size(allData{idx})),allData{idx},'Marker', myMarkers{idx}, 'MarkerEdgeAlpha',0.8,'MarkerEdgeColor',colors{idx},'jitter','on','jitterAmount',0.15, 'SizeData', 40, 'LineWidth', 1.5);
end

ylabel('InterHC (z-score)')
% legend(groupNames)
title(sprintf('p = %0.4f',P))
set(gca, 'FontSize', 14)

%% Save figure
% Specify window units
set(hFig, 'units', 'inches')
% Change figure and paper size
set(hFig, 'Position', [0.1 0.1 6 6])
set(hFig, 'PaperPosition', [0.1 0.1 6 6])
% Save as PNG
print(hFig, '-dpng', fullfile('..\figures\', [saveFileName '.png']), '-r300');
fprintf('Inter-hemispherical connectivity computed (%s)\n',HbString)
end
% EOF