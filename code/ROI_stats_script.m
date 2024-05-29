%% Load ROI data
clear; close all; clc
load('..\fNIRS_Data\ROIdataHbO.mat')
addpath(genpath('C:\Edgar\Dropbox\Matlab\shadedErrorBar'))

%% Group-averaged hemodynamic response
% Colors
myGreen = [0.00787401574803150,0.412505789717462,0.284113015284854];
myRed = [0.807843137254902,0.0666666666666667,0.149019607843137];

myFontSize = 24;
myMarkerSize = 6;
hHRF=figure; set(hHRF, 'color', 'w', 'Name', 'Group-averaged hemodynamic response')

hold on
% Spectra (mean +- s.d.) are offset for clarity
hCtl = shadedErrorBar(timeVector, 1e6*ROI.L(~isParkinson,:),{@mean,@std},'-', 1); 
hCtl.mainLine.Color = myGreen;
hCtl.edge(1).Color = myGreen;
hCtl.edge(2).Color = myGreen;
hCtl.patch.FaceColor = myGreen;
hCtl.mainLine.LineWidth = 2;
hPD = shadedErrorBar(timeVector, 1e6*ROI.L(isParkinson,:),{@mean,@std},'-', 1); 
hPD.mainLine.Color = myRed;
hPD.edge(1).Color = myRed;
hPD.edge(2).Color = myRed;
hPD.patch.FaceColor = myRed;
hPD.mainLine.LineWidth = 2;
xlabel('Time (s)', 'FontSize', myFontSize)
ylabel('\Delta HbO (\muM\cdotcm)', 'FontSize', myFontSize)
% legend({'Control' '' '' '' 'PD'},'FontSize', myFontSize)
set(gca,'FontSize',myFontSize-1)
axis tight; 

% Specify window units
set(hHRF, 'units', 'inches')
% Change figure and paper size
set(hHRF, 'Position', [0.1 0.1 11 5.5])
set(hHRF, 'PaperPosition', [0.1 0.1 11 5.5])
% print(hHRF, '-dpng', '..\figures\HbO_group_avg.png', sprintf('-r%d',300));

%% Peak amplitude Peak_HbO
hPeak = figure; 
set(hPeak, 'Name', '\DeltaHbO', 'color', 'w')
labels = categorical(isParkinson);
labels(isParkinson) = "PD";
labels(~isParkinson) = "Control";

controlData = 1e6*ROI.LmaxVal(~isParkinson);
PDdata = 1e6*ROI.LmaxVal(isParkinson);
% idx2include = [3 4 6 10 12 13 15 17 18 19];
idx2include = 1:20;
PDdata = PDdata(idx2include);
% labels = labels([1:9 end-5:end]);

subplot(221)
boxplot([PDdata; controlData], labels,  'Colors', [myRed; myGreen]); 
set(gca,'FontSize', myFontSize)
hold on;
x1 = 2*ones([sum(labels=="Control") 1]);
x2 = ones([sum(labels=="PD") 1]);
h1 = scatter(x1,controlData,'filled','MarkerFaceAlpha',0.6','jitter','on','jitterAmount',0.15);
h1.CData = myGreen;
h2 = scatter(x2,PDdata,'filled','MarkerFaceAlpha',0.6','jitter','on','jitterAmount',0.15);
h2.CData = myRed;
ylabel('Peak_{\DeltaHbO} (\muM\cdotcm)', 'FontSize', myFontSize)
title('Peak \DeltaHbO concentration')
[P.peakHbO,H.peakHbO] = ranksum(controlData, PDdata);

%% Peak latency
controlData = ROI.LtimeToMax(~isParkinson);
PDdata = ROI.LtimeToMax(isParkinson);
PDdata = PDdata(idx2include);

subplot(222)
hb = boxplot([PDdata; controlData], labels,  'Colors', [myRed; myGreen]); 
h = findobj(gca,'tag','Outliers');
for i = 1:numel(h)
% if rem(i,2)==0
    h(i).MarkerEdgeColor = myGreen;
% end
end
hold on;
x1 = 2*ones([sum(labels=="Control") 1]);
x2 = ones([sum(labels=="PD") 1]);
h1 = scatter(x1,controlData,'filled','MarkerFaceAlpha',0.6','jitter','on','jitterAmount',0.15);
h1.CData = myGreen;
h2 = scatter(x2,PDdata,'filled','MarkerFaceAlpha',0.6','jitter','on','jitterAmount',0.15);
h2.CData = myRed;
ylabel('\tau_{\DeltaHbO} (s)', 'FontSize', myFontSize)
title('\DeltaHbO latency')
set(gca,'FontSize', myFontSize)
[P.latencyHbO,H.latencyHbO] = ranksum(controlData, PDdata);

%% AUC
controlData = 1e6*ROI.LAUC(~isParkinson);
PDdata = 1e6*ROI.LAUC(isParkinson);
PDdata = PDdata(idx2include);

subplot(223)
boxplot([PDdata; controlData], labels,  'Colors', [myRed; myGreen]); 
hold on;
x1 = 2*ones([sum(labels=="Control") 1]);
x2 = ones([sum(labels=="PD") 1]);
h1 = scatter(x1,controlData,'filled','MarkerFaceAlpha',0.6','jitter','on','jitterAmount',0.15);
h1.CData = myGreen;
h2 = scatter(x2,PDdata,'filled','MarkerFaceAlpha',0.6','jitter','on','jitterAmount',0.15);
h2.CData = myRed;
ylabel('AUC_{\DeltaHbO}  (\muM\cdotcm\cdots)', 'FontSize', myFontSize)
title(['Area under the' newline '\DeltaHbO concentration Curve'])
set(gca,'FontSize', myFontSize)
[P.AUCHbO,H.AUCHbO] = ranksum(controlData, PDdata);

%% Mean 
controlData = 1e6*ROI.LmeanVal(~isParkinson);
PDdata = 1e6*ROI.LmeanVal(isParkinson);
PDdata = PDdata(idx2include);

subplot(224)
boxplot([PDdata; controlData], labels,  'Colors', [myRed; myGreen]); 
hold on;
x1 = 2*ones([sum(labels=="Control") 1]);
x2 = ones([sum(labels=="PD") 1]);
h1 = scatter(x1,controlData,'filled','MarkerFaceAlpha',0.6','jitter','on','jitterAmount',0.15);
h1.CData = myGreen;
h2 = scatter(x2,PDdata,'filled','MarkerFaceAlpha',0.6','jitter','on','jitterAmount',0.15);
h2.CData = myRed;
ylabel('Mean_{\DeltaHbO}  (\muM\cdotcm)', 'FontSize', myFontSize)
title('Mean \DeltaHbO concentration')
set(gca,'FontSize', myFontSize)
[P.meanHbO,H.meanHbO] = ranksum(controlData, PDdata);

% Specify window units
set(hPeak, 'units', 'inches')
% Change figure and paper size
set(hPeak, 'Position', [0.1 0.1 12 12])
set(hPeak, 'PaperPosition', [0.1 0.1 12 12])
% print(hPeak, '-dpng', '..\figures\HbO_stats.png', sprintf('-r%d',300));

fprintf(' Peak: p=%0.2f \n Latency: p=%0.2f \n AUC: p=%0.2f \n Mean: p=%0.2f \n',...
    P.peakHbO, P.latencyHbO, P.AUCHbO, P.meanHbO)
% save ('..\fNIRS_Data\ROIstatsHbO.mat')
disp('ROI stats done!')