function hFig = my_partial_corr_plot(X_temp, Y, isPD_temp, LeftColor, RightColor, myMarkerSize, myLineWidth)
    % Adjust the function to handle categorical 'isPD_temp' with values 'L' and 'R'
    groupL = (isPD_temp == 'L');
    groupR = (isPD_temp == 'R');
    
    % Initialize figure
    hFig = figure;
    set(hFig, 'Color', 'w');
    hold on;
    
    % Plot and fit for group 'L'
    LM_L = fitlm(X_temp(groupL), Y(groupL));
    plotFitAndCI(LM_L, LeftColor, myMarkerSize, myLineWidth, X_temp(groupL), Y(groupL), '<'); % Using triangle up for 'L'
    
    % Plot and fit for group 'R'
    LM_R = fitlm(X_temp(groupR), Y(groupR));
    plotFitAndCI(LM_R, RightColor, myMarkerSize, myLineWidth, X_temp(groupR), Y(groupR), '>'); % Using triangle down for 'R'
    
    % Adjust axis and set square
    axis square;
    xlim([min(X_temp), max(X_temp)]);
    ylim([1.1*min(Y) , 1.1*max(Y) ]); % Adding some padding for visibility
    
    % Setup figure size
    set(hFig, 'units', 'inches', 'Position', [0.1 0.1 4 4], 'PaperPosition', [0.1 0.1 4 4]);
    
    hold off;
end

function plotFitAndCI(LM, color, markerSize, lineWidth, X_temp, Y, markerType)
    % Get the regression line and confidence interval from plot
    hPlot = plot(LM);
    xCI = hPlot(3).XData;
    yCI1 = hPlot(3).YData;
    yCI2 = hPlot(4).YData;
    yFit = hPlot(2).YData;
    
    % Delete the plot to recreate with custom settings
    delete(hPlot);
    
    % Fill confidence bounds in light color
    x_fill = [xCI, fliplr(xCI)];
    y_fill = [yCI1, fliplr(yCI2)];
    fill(x_fill, y_fill, [0.9 0.9 0.9], 'EdgeColor', 'none', 'FaceAlpha', 0.3);
    
    % Plot linear fit
    plot(xCI, yFit, 'Color', color, 'LineWidth', lineWidth);
    
    % Plot data points using plot
    plot(X_temp, Y, markerType, 'MarkerSize', markerSize, 'MarkerEdgeColor', color, 'MarkerFaceColor', color, 'LineWidth', lineWidth);
end
