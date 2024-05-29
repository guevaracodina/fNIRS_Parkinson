function [hFig, R_L, R_R, adjusted_p_L, adjusted_p_R]  = partial_correlations_compute(X,Y,controls,onsetSide)

% Extract data by onset side
XL = X(onsetSide == 'L', :);
XR = X(onsetSide == 'R', :);
YL = Y(onsetSide == 'L', :);
YR = Y(onsetSide == 'R', :);
controlsL = controls(onsetSide == 'L', :);
controlsR = controls(onsetSide == 'R', :);

%% Use partial correlation
% Calculate partial correlations for 'L' group
[R_L, p_values_L] = partialcorr(XL, YL, controlsL, 'type', 'Spearman');

% Calculate partial correlations for 'R' group
[R_R, p_values_R] = partialcorr(XR, YR, controlsR, 'type', 'Spearman');

% Adjust p-values for multiple comparisons in each group
[hL, crit_pL, adj_ci_cvrgL, adjusted_p_L] = fdr_bh(p_values_L, 0.05, 'pdep', 'yes');
[hR, crit_pR, adj_ci_cvrgR, adjusted_p_R] = fdr_bh(p_values_R, 0.05, 'pdep', 'yes');

% Compare and display results
% Simple comparison: Print or visualize significant correlations
fprintf('Significant correlations for L onset:\n');
significant_correlationsL = adjusted_p_L < 0.05;
disp(R_L .* significant_correlationsL);

fprintf('Significant correlations for R onset:\n');
significant_correlationsR = adjusted_p_R < 0.05;
disp(R_R .* significant_correlationsR);

%% Heatmap
% Labels for the heatmap
clinical_labels = {'MoCA', 'diseaseDuration', 'UPDRS', 'FOGQ', 'LEDD', 'HY'};
fnirs_labels = {'RPeak', 'RTimeToPeak', 'RAUC', 'RMean', 'RSlope', ...
                'LPeak', 'LTimeToPeak', 'LAUC', 'LMean', 'LSlope'};

% Create a heatmap only for significant correlations
hFig = figure;
subplot(121)
heatMapMatL = R_L;
% heatMapMatL = R_L .* significant_correlationsL;
% heatMapMatL(~significant_correlationsL) = NaN;
hL = imagesc(heatMapMatL, [-1 1]);
colormap(ioi_get_colormap('redbluecmap'));
colorbar
set(gca, 'YTick', 1:size(heatMapMatL,1))
set(gca, 'YTickLabel', fnirs_labels)
set(gca, 'XTick', 1:size(heatMapMatL,2))
set(gca, 'XTickLabel', clinical_labels)
xtickangle(45)
axis equal; axis tight

% hL = heatmap(clinical_labels, fnirs_labels, heatMapMatL, ...
%             'Colormap', ioi_get_colormap('redbluecmap'), 'ColorLimits', [-1 1], 'MissingDataColor', 'white', 'CellLabelColor','none');
% hL.Title = 'Left side onset';
% hL.YLabel = 'fNIRS Features';
% hL.XLabel = 'Clinical Variables';

subplot(122)
heatMapMatR = R_R;
% heatMapMatR = R_R .* significant_correlationsR;
% heatMapMatR(~significant_correlationsR) = NaN;
% hR = heatmap(clinical_labels, fnirs_labels, heatMapMatR, ...
%             'Colormap', ioi_get_colormap('redbluecmap'), 'ColorLimits', [-1 1], 'MissingDataColor', 'white', 'CellLabelColor','none');
hR = imagesc(heatMapMatR, [-1 1]);
colormap(ioi_get_colormap('redbluecmap'));
colorbar
set(gca, 'YTick', 1:size(heatMapMatL,1))
set(gca, 'YTickLabel', fnirs_labels)
set(gca, 'XTick', 1:size(heatMapMatL,2))
set(gca, 'XTickLabel', clinical_labels)
xtickangle(45)
axis equal; axis tight
% hR.Title = 'Right side onset';
% hR.YLabel = 'fNIRS Features';
% hR.XLabel = 'Clinical Variables';

% Specify window units
set(hFig, 'units', 'inches')
% Change figure and paper size
set(hFig, 'Position', [0.1 0.1 8 4])
set(hFig, 'PaperPosition', [0.1 0.1 8 4])
set(hFig, 'color', 'w')

fprintf('Only significant partial correlations are displayed. Non-significant correlations are shown in white.\n');

end