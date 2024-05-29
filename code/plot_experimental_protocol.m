%% Create experimental protocol
clear; close all; clc;
interStimulus = [23 22 22 21 20 24 22 21 22 20 25 25 22 21 20 21 23 24 22 20]';
fingerTappingSide = ['L' 'L' 'R' 'R' 'L' 'R' 'L' 'R' 'R' 'R' 'L' 'R' 'L' 'R' 'L' 'L' 'R' 'L' 'R' 'L']';
stimuli = 10*ones(size(fingerTappingSide));
timeDurationVec = [15; reshape([stimuli interStimulus]',[],1)];
fingerTappingKey = ones(size(fingerTappingSide));
fingerTappingKey(fingerTappingSide=='R')=2;
protocolKey = [0; reshape([fingerTappingKey zeros(size(interStimulus))]',[],1)];

%% Plot
printFigs = true;
hFig = figure;
set(hFig, 'color', 'w')
hold on
y = [0 0 1 1];
lastTimePoint = 0;
for idx=1:numel(timeDurationVec)
    x = [lastTimePoint lastTimePoint+timeDurationVec(idx) lastTimePoint+timeDurationVec(idx) lastTimePoint];
    if protocolKey(idx)==1
        patch(x,y,[0.5 0.5 0.5])    % Non-dominant (left)
    elseif protocolKey(idx)==2
        patch(x,y,'black')          % Dominant (right)
    else
        patch(x,y,'white')
    end
    lastTimePoint = lastTimePoint+timeDurationVec(idx);
end
xlabel('time (s)')
set(gca,'YTick',[], 'FontSize', 12, 'XTick',[0 lastTimePoint])
axis tight
% Specify window units
set(hFig, 'units', 'inches')
% Change figure and paper size
set(hFig, 'Position', [0.1 0.1 12 1.5])
set(hFig, 'PaperPosition', [0.1 0.1 12 1.5])
if printFigs
    print(hFig, '-dpng', '..\figures\experimental_protocol_timing.png', sprintf('-r%d',300));
    close(hFig)
end