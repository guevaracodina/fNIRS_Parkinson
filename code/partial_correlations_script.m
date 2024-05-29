% Computes partial correlations about the following HRF metrics on a channel-by-channel
% basis: peak value, time-to-peak, AUC, mean value, slope (for L&Rconditions) 
% with the following clinical variables:
%  'MoCA'    'diseaseDuration'    'UPDRS'    'FOGQ'    'LEDD'    'HY'
% Taking into account side of onset

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

%% Perform Spearman correlations on HbO active channels for L/R conditions
disp('HbO')
PDcolor = [1 0 1];
controlColor = [1 0 0];
myMarkerSize = 10;
myLineWidth = 2;
myFontSize = 12;
% Extract the variable names from the table
variableNames = allDemographics.Properties.VariableNames;
% variableNames = variableNames(10:15);
% see longChannelsIdx for correct indices
% channel 10 (idx=9) (left finger-tapping)
% channel 15 (idx=5) (right finger-tapping)
% All 5 HRF features for each condition L/R
X = [
    HbOchannels.RmaxVal(:,5) HbOchannels.RtimeToMax(:,5) HbOchannels.RAUC(:,5)...
    HbOchannels.RmeanVal(:,5) HbOchannels.Rslope(:,5) HbOchannels.LmaxVal(:,9)  ...
    HbOchannels.LtimeToMax(:,9) HbOchannels.LAUC(:,9) HbOchannels.LmeanVal(:,9)  ...
    HbOchannels.Lslope(:,9)];

% Log-transformation
doLogTransform = false;

% Variable names from HRF features
fNIRSvarsNames = {"Peak (R)" "Time to peak (R)" "AUC (R)" "Mean (R)" "Slope (R)"...
    "Peak (L)" "Time to peak (L)"  "AUC (L)" "Mean (L)" "Slope (L)" };

% Initialize a variable to store the correlation results
correlationsHbO = zeros(size(X,2), length(variableNames));
pValsHbO = correlationsHbO;
idxVars = 10:15; % 'MoCA'    'diseaseDuration'    'UPDRS'    'FOGQ'    'LEDD'    'HY'
for idxHRF = 1:size(X,2)
    % Loop through each variable in the table
    for idxDemo = idxVars
        % Check if the variable is continuous
        if isa(allDemographics.(variableNames{idxDemo}), 'double')
            % handling NaN values
            X_temp = X(:, idxHRF);
            Y = allDemographics.(variableNames{idxDemo});
            idx2remove = isnan(Y);
            X_temp(idx2remove) = [];
            Y(idx2remove) = [];
            isPD_temp = isPD;
            isPD_temp(idx2remove) = [];
            if doLogTransform
                Y = log(Y);
            end
            [correlationsHbO(idxHRF, idxDemo), pValsHbO(idxHRF, idxDemo)] = corr(X_temp,Y,'type','spearman');
            if pValsHbO(idxHRF, idxDemo) < 0.05
                % Display the correlation results
                fprintf('The Spearman correlation of %s and %s is: %.4f (p=%.4f)\n', fNIRSvarsNames{idxHRF}, variableNames{idxDemo}, correlationsHbO(idxHRF, idxDemo), pValsHbO(idxHRF, idxDemo));

                % Plot data and fit
                hPlot = my_corr_plot(X_temp, Y, isPD_temp, controlColor, PDcolor, myMarkerSize, myLineWidth);
               
                % Add labels and legend
                xlabel(fNIRSvarsNames{idxHRF})
                ylabel(variableNames{idxDemo})
                title(sprintf('Spearman''s rho=%.4f (p=%.4f)\n',correlationsHbO(idxHRF, idxDemo), pValsHbO(idxHRF, idxDemo)))
                set(gca, 'Fontsize', myFontSize)
                % Print figures
                if printFigures
                    figName = strcat('..\figures\correlations\', 'HbO_partial_corr_5sec_', fNIRSvarsNames{idxHRF}, '_', variableNames{idxDemo}, '.png');
                    print(hPlot, '-dpng',  figName , sprintf('-r%d',300));
                end
            end
        end
    end
end

%% Perform Spearman correlations on HbR active channels for L/R conditions
disp('HbR')
PDcolor  = [0 1 1];
controlColor= [0 0 1];

% see longChannelsIdx for correct indices
% channel 10 (idx=9) (left finger-tapping)
% channel 15 (idx=5) (right finger-tapping)
% All 5 HRF features for each condition L/R
X = [
    HbRchannels.RmaxVal(:,5) HbRchannels.RtimeToMax(:,5) HbRchannels.RAUC(:,5)...
    HbRchannels.RmeanVal(:,5) HbRchannels.Rslope(:,5) HbRchannels.LmaxVal(:,9)  ...
    HbRchannels.LtimeToMax(:,9) HbRchannels.LAUC(:,9) HbRchannels.LmeanVal(:,9)  ...
    HbRchannels.Lslope(:,9)];

% Initialize a variable to store the correlation results
correlationsHbR = zeros(size(X,2), length(variableNames));
pValsHbR = correlationsHbR;

for idxHRF = 1:size(X,2)
    % Loop through each variable in the table
    for idxDemo = idxVars
        % Check if the variable is continuous
        if isa(allDemographics.(variableNames{idxDemo}), 'double')
            % handling NaN values
            X_temp = X(:, idxHRF);
            Y = allDemographics.(variableNames{idxDemo});
            idx2remove = isnan(Y);
            X_temp(idx2remove) = [];
            Y(idx2remove) = [];
            isPD_temp = isPD;
            isPD_temp(idx2remove) = [];
            if doLogTransform
                Y = log(Y);
            end
            [correlationsHbR(idxHRF, idxDemo), pValsHbR(idxHRF, idxDemo)] = corr(X_temp,Y,'type','spearman');
            if pValsHbR(idxHRF, idxDemo) < 0.05
                % Display the correlation results
                fprintf('The Spearman correlation of %s and %s is: %.4f (p=%.4f)\n', fNIRSvarsNames{idxHRF}, variableNames{idxDemo}, correlationsHbR(idxHRF, idxDemo), pValsHbR(idxHRF, idxDemo));
                % Plot data and fit
                hPlot = my_corr_plot(X_temp, Y, isPD_temp, controlColor, PDcolor, myMarkerSize, myLineWidth);
                
                % Add labels and legend
                xlabel(fNIRSvarsNames{idxHRF})
                ylabel(variableNames{idxDemo})
                title(sprintf('Spearman''s rho=%.4f (p=%.4f)\n',correlationsHbR(idxHRF, idxDemo), pValsHbR(idxHRF, idxDemo)))
                set(gca, 'Fontsize', myFontSize)
                % Print figures
                if printFigures
                    figName = strcat('..\figures\correlations\', 'HbR_partial_corr_5sec_', fNIRSvarsNames{idxHRF}, '_', variableNames{idxDemo}, '.png');
                    print(hPlot, '-dpng',  figName , sprintf('-r%d',300));
                end
            end
        end
    end
end

%% Perform Spearman correlations on HbT active channels for L/R conditions
disp('HbT')
controlColor = [0.00787401574803150,0.412505789717462,0.284113015284854];
PDcolor = [0 1 0];


% see longChannelsIdx for correct indices
% channel 10 (idx=9) (left finger-tapping)
% channel 15 (idx=5) (right finger-tapping)
% All 5 HRF features for each condition L/R
X = [
    HbTchannels.RmaxVal(:,5) HbTchannels.RtimeToMax(:,5) HbTchannels.RAUC(:,5)...
    HbTchannels.RmeanVal(:,5) HbTchannels.Rslope(:,5) HbTchannels.LmaxVal(:,9)  ...
    HbTchannels.LtimeToMax(:,9) HbTchannels.LAUC(:,9) HbTchannels.LmeanVal(:,9)  ...
    HbTchannels.Lslope(:,9)];

% Initialize a variable to store the correlation results
correlationsHbT = zeros(size(X,2), length(variableNames));
pValsHbT = correlationsHbT;

for idxHRF = 1:size(X,2)
    % Loop through each variable in the table
    for idxDemo = idxVars
        % Check if the variable is continuous
        if isa(allDemographics.(variableNames{idxDemo}), 'double')
            % Relevant variableNames(idxVars)
            % handling NaN values
            X_temp = X(:, idxHRF);
            Y = allDemographics.(variableNames{idxDemo});
            idx2remove = isnan(Y);
            X_temp(idx2remove) = [];
            Y(idx2remove) = [];
            isPD_temp = isPD;
            isPD_temp(idx2remove) = [];
            if doLogTransform
                Y = log(Y);
            end
            [correlationsHbT(idxHRF, idxDemo), pValsHbT(idxHRF, idxDemo)] = corr(X_temp,Y,'type','spearman');
            if pValsHbT(idxHRF, idxDemo) < 0.05
                % Display the correlation results
                fprintf('The Spearman correlation of %s and %s is: %.4f (p=%.4f)\n', fNIRSvarsNames{idxHRF}, variableNames{idxDemo}, correlationsHbT(idxHRF, idxDemo), pValsHbT(idxHRF, idxDemo));
                % Plot data and fit
                hPlot = my_corr_plot(X_temp, Y, isPD_temp, controlColor, PDcolor, myMarkerSize, myLineWidth);
                
                % Add labels and legend
                xlabel(fNIRSvarsNames{idxHRF})
                ylabel(variableNames{idxDemo})
                title(sprintf('Spearman''s rho=%.4f (p=%.4f)\n',correlationsHbT(idxHRF, idxDemo), pValsHbT(idxHRF, idxDemo)))
                set(gca, 'Fontsize', myFontSize)
                % Print figures
                if printFigures
                    figName = strcat('..\figures\correlations\', 'HbT_partial_corr_5sec_', fNIRSvarsNames{idxHRF}, '_', variableNames{idxDemo}, '.png');
                    print(hPlot, '-dpng',  figName , sprintf('-r%d',300));
                end
            end
        end
    end
end

%% Plot correlation matrix
% Hb variables: Max value, time to peak, AUC, mean, slope for Dominant and non-dominant finger-tapping
disp(fNIRSvarsNames);
disp(variableNames(idxVars));
corrMat = [correlationsHbO(:, idxVars) correlationsHbR(:, idxVars) correlationsHbT(:, idxVars)];
pValsMat = [pValsHbO(:, idxVars) pValsHbR(:, idxVars) pValsHbT(:, idxVars)];
hCorr = figure;
I = imagesc(corrMat, [-1 1]);
% I.AlphaData = rescale(-log10(pValsMat));
colormap(ioi_get_colormap('redbluecmap'))
colorbar
set(gca, 'YTick', 1:size(corrMat,1))
set(gca, 'YTickLabel', {'Peak' 'Time to peak' 'AUC' 'Mean' 'Slope' 'Peak' 'Time to peak' 'AUC' 'Mean' 'Slope'})
set(gca, 'XTick', 1:size(corrMat,2))
set(gca, 'XTickLabel', repmat(variableNames(idxVars), [1 3]))
xtickangle(45)
axis equal; axis tight
% Specify window units
set(hCorr, 'units', 'inches')
% Change figure and paper size
set(hCorr, 'Position', [0.1 0.1 8 4])
set(hCorr, 'PaperPosition', [0.1 0.1 8 4])
set(hCorr, 'color', 'w')
if printFigures
    print(hCorr, '-dpng', '..\figures\correlations\partial_corr_matrix_5sec.png', sprintf('-r%d',300));
end
% save ('..\fNIRS_Data\partialCorrData_5sec.mat')
% EOF