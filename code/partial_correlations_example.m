%% Load channel by channel data
clear; close all; clc
check_homer_path
Folder = 'C:\Edgar\Dropbox\Matlab\shadedErrorBar';
if ~ismember(Folder, strsplit(path, pathsep))
    addpath(genpath(Folder))
end
% load ('..\fNIRS_Data\channelData.mat')
load ('..\fNIRS_Data\channelData_5sec.mat')
load('C:\Edgar\Dropbox\Shared folders\fNIRS\software\fNIRS_Data\demographicsData.mat')
load('..\data\onsetSidePD.mat', 'onsetSideFull', 'onsetSide')
% If we wish to label the strength of the association, for absolute values
% of r, 0-0.19 is regarded as very weak, 0.2-0.39 as weak, 0.40-0.59 as
% moderate, 0.6-0.79 as strong and 0.8-1 as very strong correlation
printFigures = false;


%% Extract variables
% Assume 'data' is your dataset including all the variables
% Y = data{:, {'MoCA','diseaseDuration','UPDRS','FOGQ','LEDD','HY'}};
Y = table2array(allDemographics(:, 10:15));
% X = data{:, {'RmaxVal','RtimeToMax','RAUC','RmeanVal','Rslope','LmaxVal','LtimeToMax','LAUC','LmeanVal','Lslope'}};
% All 5 HRF features for each condition L/R
X = [
    HbOchannels.RmaxVal(:,5) HbOchannels.RtimeToMax(:,5) HbOchannels.RAUC(:,5)...
    HbOchannels.RmeanVal(:,5) HbOchannels.Rslope(:,5) HbOchannels.LmaxVal(:,9)  ...
    HbOchannels.LtimeToMax(:,9) HbOchannels.LAUC(:,9) HbOchannels.LmeanVal(:,9)  ...
    HbOchannels.Lslope(:,9)];
% agetable2array(allDemographics(:, 10:15))
controls = [age education];

% Assume 'data' is your dataset including all the variables
% Extract variables
% Y = data{:, {'MoCA','diseaseDuration','UPDRS','FOGQ','LEDD','HY'}};
% X = data{:, {'RmaxVal','RtimeToMax','RAUC','RmeanVal','Rslope','LmaxVal','LtimeToMax','LAUC','LmeanVal','Lslope'}};
% controls = data{:, {'age', 'yearsOfeducation'}};

% Calculate partial correlations between Y and X controlling for controls
[R, p_values] = partialcorr(Y, X, controls);

% Adjust for multiple comparisons using FDR
alpha = 0.05; % Significance level
[adjusted_p, ~] = fdr_bh(p_values, alpha, 'pdep', 'yes');

% Identify significant correlations
significant_correlations = adjusted_p < alpha;

% Labels for the heatmap
clinical_labels = {'MoCA', 'diseaseDuration', 'UPDRS', 'FOGQ', 'LEDD', 'HY'};
fnirs_labels = {'RmaxVal', 'RtimeToMax', 'RAUC', 'RmeanVal', 'Rslope', ...
                'LmaxVal', 'LtimeToMax', 'LAUC', 'LmeanVal', 'Lslope'};

% Create a heatmap only for significant correlations
figure;
h = heatmap(fnirs_labels, clinical_labels, R .* significant_correlations, ...
            'Colormap', jet, 'ColorLimits', [-1 1], 'MissingDataColor', 'white', 'CellLabelColor','none');
h.Title = 'Significant Partial Correlations for Clinical and fNIRS Variables';
h.XLabel = 'fNIRS Features';
h.YLabel = 'Clinical Variables';

fprintf('Only significant partial correlations are displayed. Non-significant correlations are shown in white.\n');


% % Step 2: Remove the effect of control variables
% Y_res = zeros(size(Y));
% X_res = zeros(size(X));
% 
% for i = 1:size(Y, 2)
%     mdl = fitlm(controls, Y(:, i));
%     Y_res(:, i) = Y(:, i) - predict(mdl, controls);
% end
% 
% for j = 1:size(X, 2)
%     mdl = fitlm(controls, X(:, j));
%     X_res(:, j) = X(:, j) - predict(mdl, controls);
% end
% 
% % Step 3: Compute partial correlations
% R = corr(Y_res, X_res);
% 
% % Display the correlation matrix
% disp(R);
% 
% % Interpret the results
% fprintf('Each cell of R represents the partial correlation between a clinical and an fNIRS variable, controlling for age and years of education.\n');
% % Assuming R is the correlation matrix and assuming 'corr' function provides p-values
% [correlation_matrix, p_values] = corr(Y_res, X_res);
% 
% % Step 5: Adjust for multiple comparisons using FDR
% alpha = 0.05; % Significance level
% [adjusted_p, crit_p, adj_ci_cvrg] = fdr_bh(p_values, alpha, 'pdep', 'yes');
% 
% % Identify significant correlations (after adjustment)
% significant_correlations = adjusted_p < alpha;
% 
% % Step 6: Prepare data for heatmap
% % Create a masked matrix for significant correlations
% significant_values = correlation_matrix .* significant_correlations;
% 
% % Create a heatmap
% clinical_labels = {'MoCA', 'diseaseDuration', 'UPDRS', 'FOGQ', 'LEDD', 'HY'};
% fnirs_labels = {'RmaxVal', 'RtimeToMax', 'RAUC', 'RmeanVal', 'Rslope', ...
%                 'LmaxVal', 'LtimeToMax', 'LAUC', 'LmeanVal', 'Lslope'};
% 
% figure;
% h = heatmap(fnirs_labels, clinical_labels, significant_values, ...
%             'Colormap', jet, 'ColorLimits', [-1 1], 'MissingDataColor', 'white', 'CellLabelColor','none');
% h.Title = 'Significant Partial Correlations for Clinical and fNIRS Variables';
% h.XLabel = 'fNIRS Features';
% h.YLabel = 'Clinical Variables';
% 
% % Interpret the results
% fprintf('Only significant partial correlations are displayed. Non-significant correlations are shown in white.\n');
% EOF