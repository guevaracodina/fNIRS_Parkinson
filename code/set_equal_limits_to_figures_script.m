%% Inter-hemispherical correlations - set equal limits to all figures
ylim([0 1.85])

%% Print InterHC figures
print(gcf, '-dpng', fullfile('..\figures\', [saveFileNameHbO '_InterHC.png']), '-r300');
print(gcf, '-dpng', fullfile('..\figures\', [saveFileNameHbR '_InterHC.png']), '-r300');
print(gcf, '-dpng', fullfile('..\figures\', [saveFileNameHbT '_InterHC.png']), '-r300');

%% Connectivity matrices - set equal limits to all colormaps
subplot(221); get(gca, 'Clim')  % Repeat for all 3 contrasts
colorMapLimits = [0.0834 1.5558];
subplot(221); set(gca, 'Clim', colorMapLimits); subplot(222); set(gca, 'Clim', colorMapLimits)

%% p-value matrices - set equal limits to all colormaps
subplot(223); get(gca, 'Clim') % Repeat for all 3 contrasts
colorMapLimits = [1.3223 2.2549];
subplot(223); set(gca, 'Clim', colorMapLimits); subplot(224); set(gca, 'Clim', colorMapLimits)

%% Print connectivity figures
print(figure(1), '-dpng', fullfile('..\figures\', ['conn_control_PD_GroupCompHbO' '_conn_mat.png']), '-r300');
print(figure(2), '-dpng', fullfile('..\figures\', ['conn_control_PD_GroupCompHbR' '_conn_mat.png']), '-r300');
print(figure(3), '-dpng', fullfile('..\figures\', ['conn_control_PD_GroupCompHbT' '_conn_mat.png']), '-r300');

% EOF