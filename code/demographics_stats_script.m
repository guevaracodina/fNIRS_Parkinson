%% Load demographics data
clear; clc; close all
load('..\fNIRS_Data\demographicsData.mat');

%% Statistical test
demographicsStats = nan([9 5]);
% "Age (years)" 
demographicsStats(1,1) = nanmean(age(isPD));
demographicsStats(1,2) = nanstd(age(isPD));
demographicsStats(1,3) = nanmean(age(~isPD));
demographicsStats(1,4) = nanstd(age(~isPD));
[~, demographicsStats(1,5)] = ttest2(age(isPD), age(~isPD));

% "No. of men (%)" 
isMale = strcmp(sex,"M");
isFemale = strcmp(sex,"F");
tbl(1,1) = sum(isMale(isPD));
tbl(2,1) = sum(isFemale(isPD));
tbl(1,2) = sum(isMale(~isPD));
tbl(2,2) = sum(isFemale(~isPD));
demographicsStats(2,1) = 100*sum(isMale(isPD))./numel(isMale(isPD));
demographicsStats(2,3) = 100*sum(isMale(~isPD))./numel(isMale(~isPD));
[~,demographicsStats(2,5),~] = fishertest(tbl);

% "Education (years)" 
demographicsStats(3,1) = nanmean(education(isPD));
demographicsStats(3,2) = nanstd(education(isPD));
demographicsStats(3,3) = nanmean(education(~isPD));
demographicsStats(3,4) = nanstd(education(~isPD));
[~, demographicsStats(3,5)] = ttest2(education(isPD), education(~isPD));


% "BMI (kg/m^2)"
demographicsStats(4,1) = nanmean(BMI(isPD));
demographicsStats(4,2) = nanstd(BMI(isPD));
demographicsStats(4,3) = nanmean(BMI(~isPD));
demographicsStats(4,4) = nanstd(BMI(~isPD));
[~, demographicsStats(4,5)] = ttest2(BMI(isPD), BMI(~isPD));

% Montreal Cognitive Assessment (MoCA)
demographicsStats(5,1) = nanmean(MoCA(isPD));
demographicsStats(5,2) = nanstd(MoCA(isPD));
demographicsStats(5,3) = nanmean(MoCA(~isPD));
demographicsStats(5,4) = nanstd(MoCA(~isPD));
[~, demographicsStats(5,5)] = ttest2(MoCA(isPD), MoCA(~isPD));


% "Unified Parkinson’s Disease Rating Scale III" 
demographicsStats(6,1) = nanmean(UPDRS(isPD));
demographicsStats(6,2) = nanstd(UPDRS(isPD));
demographicsStats(6,3) = nanmean(UPDRS(~isPD));
demographicsStats(6,4) = nanstd(UPDRS(~isPD));
[~, demographicsStats(6,5)] = ttest2(UPDRS(isPD), UPDRS(~isPD));

% "Disease duration (years)"
demographicsStats(7,1) = nanmean(diseaseDuration(isPD));
demographicsStats(7,2) = nanstd(diseaseDuration(isPD));
demographicsStats(7,3) = nanmean(diseaseDuration(~isPD));
demographicsStats(7,4) = nanstd(diseaseDuration(~isPD));
[~, demographicsStats(7,5)] = ttest2(diseaseDuration(isPD), diseaseDuration(~isPD));

% "Freezing of Gait Questionnaire" 
demographicsStats(8,1) = nanmean(FOGQ(isPD));
demographicsStats(8,2) = nanstd(FOGQ(isPD));
demographicsStats(8,3) = nanmean(FOGQ(~isPD));
demographicsStats(8,4) = nanstd(FOGQ(~isPD));
[~, demographicsStats(8,5)] = ttest2(FOGQ(isPD), FOGQ(~isPD));
fprintf('FOGQ range (%f - %f)\n', min(FOGQ), max(FOGQ));

% "Levodopa Equivalent Daily Dosage (mg)"...
demographicsStats(9,1) = nanmean(LEDD(isPD));
demographicsStats(9,2) = nanstd(LEDD(isPD));
demographicsStats(9,3) = nanmean(LEDD(~isPD));
demographicsStats(9,4) = nanstd(LEDD(~isPD));
[~, demographicsStats(9,5)] = ttest2(LEDD(isPD), LEDD(~isPD));

% "Hoehn and Yahr Scale"
demographicsStats(10,1) = nanmean(HY(isPD));
demographicsStats(10,2) = nanstd(HY(isPD));
demographicsStats(10,3) = nanmean(HY(~isPD));
demographicsStats(10,4) = nanstd(HY(~isPD));
[~, demographicsStats(10,5)] = ttest2(HY(isPD), HY(~isPD));
fprintf('HY range (%f - %f)\n', min(HY), max(HY));

% Arranging and displaying data
cTable = table(["Age (years)" "No. of men (%)" "Education (years)" "BMI (kg/m^2)"...
    "Montreal Cognitive Assessment (MoCA)"...
"Unified Parkinson’s Disease Rating Scale III" "Disease duration (years)"...
"Freezing of Gait Questionnaire" "Levodopa Equivalent Daily Dosage (mg)"...
"Hoehn and Yahr Scale"]');
cTable.Properties.VariableNames = {'Variable_Names'};
cTable2 = array2table(demographicsStats);
cTable2.Properties.VariableNames = { 'PD_mean' 'PD_sd' 'control_mean' 'control_sd' 'p_val'};
cTable = horzcat(cTable, cTable2);
clear cTable2
disp(cTable)

% EOF
