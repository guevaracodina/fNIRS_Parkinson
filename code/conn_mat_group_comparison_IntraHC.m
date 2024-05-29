function [zMatgroup1Mean, zMatgroup2Mean, rMatgroup1Mean, rMatgroup2Mean, P] = ...
    conn_mat_group_comparison_IntraHC(fileGroup1, fileGroup2, groupNames, saveFileName, ...
    chIdxL, chIdxR, group1Color, group2Color)
%% Load first group to compute Intrahemispheric Correlation (IntraHC)
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
zVec1SubjMean = zeros([size(zMatgroup1, 3), 1]);
zVec2SubjMean = zeros([size(zMatgroup2, 3), 1]);
rVec1SubjMean = zeros([size(rMatgroup1, 3), 1]);
rVec2SubjMean = zeros([size(rMatgroup2, 3), 1]);

%% Perform between-group comparison
% across subjects NOT across channels
% Group 1
[rows, columns, ~] = size(zMatgroup1);
for iSubjects1 = 1:size(zMatgroup1,3)
    % Extract quadrants 
    lowerRight1 = zMatgroup1(rows/2+1:end, columns/2+1:end, iSubjects1); % Extract lower right.
    upperLeft1 = zMatgroup1(1:rows/2, 1:columns/2, iSubjects1); % Extract lower right.
    % Compute median across subjects
    zVec1SubjMean(iSubjects1) = nanmedian(lowerRight1(:));
%     zVec1SubjMean(iSubjects1) = nanmedian([lowerRight1(:); upperLeft1(:)]);
    % Extract quadrants
    lowerRight1 = rMatgroup1(rows/2+1:end, columns/2+1:end, iSubjects1); % Extract lower right.
    upperLeft1 = rMatgroup1(1:rows/2, 1:columns/2, iSubjects1); % Extract lower right.
    rVec1SubjMean(iSubjects1) = nanmedian(lowerRight1(:));
%     rVec1SubjMean(iSubjects1) = nanmedian([lowerRight1(:); upperLeft1(:)]);
end
% Group 2
[rows, columns, ~] = size(zMatgroup2);
for iSubjects2 = 1:size(zMatgroup2,3)
    % Extract quadrants
    lowerRight2 = zMatgroup2(rows/2+1:end, columns/2+1:end, iSubjects2); % Extract lower right.
    upperLeft2 = zMatgroup2(1:rows/2, 1:columns/2, iSubjects2); % Extract lower right.
    % Compute median across subjects
    zVec2SubjMean(iSubjects2) = nanmedian(lowerRight2(:));
%     zVec2SubjMean(iSubjects2) = nanmedian([lowerRight2(:); upperLeft2(:)]);
    % Extract quadrants
    lowerRight2 = rMatgroup2(rows/2+1:end, columns/2+1:end, iSubjects2); % Extract lower right.
    upperLeft2 = rMatgroup2(1:rows/2, 1:columns/2, iSubjects2); % Extract lower right.
    rVec2SubjMean(iSubjects2) = nanmedian(lowerRight2(:));
%     rVec2SubjMean(iSubjects2) = nanmedian([lowerRight2(:); upperLeft2(:)]);
end

% Remove outliers
zVec1SubjMean = zVec1SubjMean(~isoutlier(zVec1SubjMean, 'gesd', 'MaxNumOutliers', 2));
zVec2SubjMean = zVec2SubjMean(~isoutlier(zVec2SubjMean, 'gesd', 'MaxNumOutliers', 2));
rVec1SubjMean = rVec1SubjMean(~isoutlier(rVec1SubjMean, 'gesd', 'MaxNumOutliers', 2));
rVec2SubjMean = rVec2SubjMean(~isoutlier(rVec2SubjMean, 'gesd', 'MaxNumOutliers', 2));

% Perform Wilcoxon Mann-Whitney test
[P,H] = ranksum(zVec1SubjMean, zVec2SubjMean, 'tail', 'both');
save(fullfile('..\data\', [saveFileName '.mat']));

%% Boxplots of IntraHC
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
hold on

% Scatter plot
for idx = 1:numel(allData)
%     scatter(repmat(xCenter(idx),size(allData{idx})),...
%         allData{idx},'filled','MarkerFaceAlpha',0.8,'MarkerFaceColor',colors{idx},...
%         'jitter','on','jitterAmount',0.15, 'Marker');
    scatter(repmat(xCenter(idx),size(allData{idx})),allData{idx},'Marker', myMarkers{idx}, 'MarkerEdgeAlpha',0.8,'MarkerEdgeColor',colors{idx},'jitter','on','jitterAmount',0.15, 'SizeData', 40, 'LineWidth', 1.5);
end

ylabel('IntraHC (z-score)')
% legend(groupNames)
title(sprintf('p = %0.4f',P))
set(gca, 'FontSize', 14)
% ylim([-0.2 1.4])        % Change as needed
ylim([-0.6 2.5])        % Change as needed

%% Save figure
% Specify window units
set(hFig, 'units', 'inches')
% Change figure and paper size
set(hFig, 'Position', [0.1 0.1 6 6])
set(hFig, 'PaperPosition', [0.1 0.1 6 6])
% Save as PNG
print(hFig, '-dpng', fullfile('..\figures\', [saveFileName '.png']), '-r300');
fprintf('Intra-hemispherical connectivity computed (%s)\n',HbString)
end
% EOF