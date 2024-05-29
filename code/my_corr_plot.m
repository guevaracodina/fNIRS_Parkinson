function hFig = my_corr_plot(X_temp, Y, isPD_temp, controlColor, PDcolor, myMarkerSize, myLineWidth)
% Perform linear regression
LM = fitlm(X_temp,Y);
% Scatter plot with linear fit and cofidence bounds
hFig = figure;
set(hFig, 'Color', 'w')
hPlot = plot(LM);
% Extract confidence bounds
xCI = hPlot(3).XData;
yCI1 = hPlot(3).YData;
yCI2 = hPlot(4).YData;
% Linear fit
yFit = LM.Coefficients.Estimate(1) + LM.Coefficients.Estimate(2).*xCI;
clf;
hold on;
% Fill confidence bounds in light gray
x_fill = [xCI, fliplr(xCI)];
y_fill = [yCI1, fliplr(yCI2)];
fill(x_fill, y_fill, [0.9 0.9 0.9], 'EdgeColor', 'none');
alpha(0.5);
% Plot linear fit
plot(xCI, yFit, 'k-', 'LineWidth', myLineWidth)
% Plot data
plot(X_temp(isPD_temp), Y(isPD_temp), 'x', 'MarkerSize', myMarkerSize, 'Color', PDcolor, 'LineWidth', myLineWidth);
plot(X_temp(~isPD_temp), Y(~isPD_temp), 'o',  'MarkerSize', myMarkerSize, 'Color', controlColor, 'LineWidth', myLineWidth);
axis square
xlim([min(X_temp) max(X_temp)])
% Specify window units
set(hFig, 'units', 'inches')
% Change figure and paper size
set(hFig, 'Position', [0.1 0.1 4 4])
set(hFig, 'PaperPosition', [0.1 0.1 4 4])
end

% EOF