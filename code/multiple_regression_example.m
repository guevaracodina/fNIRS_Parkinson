% Example data creation
n = 100;  % Number of participants
data = table(randi([0 1], n, 1), rand(n, 1), randi([18 30], n, 1), randi([100 800], n, 1), randi([1 5], n, 1), 'VariableNames', {'OnsetSide', 'fNIRSSignal', 'MoCA', 'LevodopaDose', 'HoehnYahr'});
data.OnsetSide = categorical(data.OnsetSide, [0 1], {'LEFT', 'RIGHT'});

% Divide the data based on onset side
leftGroup = data(data.OnsetSide == 'LEFT', :);
rightGroup = data(data.OnsetSide == 'RIGHT', :);

% Calculate correlations within each group
corrLeft = corr(leftGroup{:, {'fNIRSSignal', 'MoCA', 'LevodopaDose', 'HoehnYahr'}});
corrRight = corr(rightGroup{:, {'fNIRSSignal', 'MoCA', 'LevodopaDose', 'HoehnYahr'}});

fprintf('Correlation matrix for LEFT side onset:\n');
disp(corrLeft);

fprintf('Correlation matrix for RIGHT side onset:\n');
disp(corrRight);

% Regression analysis with interaction terms
% Preparing variables for regression
data.InteractionMoCA = data.MoCA .* double(data.OnsetSide == 'RIGHT');
data.InteractionLevodopa = data.LevodopaDose .* double(data.OnsetSide == 'RIGHT');
data.InteractionHoehnYahr = data.HoehnYahr .* double(data.OnsetSide == 'RIGHT');

% Multiple linear regression model
mdl = fitlm(data, 'fNIRSSignal ~ MoCA + LevodopaDose + HoehnYahr + OnsetSide + InteractionMoCA + InteractionLevodopa + InteractionHoehnYahr');

% Display the results of the regression
disp(mdl);
