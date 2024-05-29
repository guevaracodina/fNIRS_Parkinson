function [chIdxL, chIdxR] = get_channels_from_template(template)
switch template
    case 'motor'
        % Motor cortex template
        % Brite 2x10 + 2SSC (Homer)
        % See https://www.dropbox.com/s/48h7eqcwbciyiqv/optodes_template_motor.PNG?dl=0
        % Channels list
        % 01.	HRF HbO S01D01    R             % 12.	HRF HbO S06D05    L
        % 02.	HRF HbO S01D02    R             % 13.	HRF HbO S06D06    L
        % 03.	HRF HbO S02D01    (Right SSC)   % 14.	HRF HbO S07D05    (Left SSC)
        % 04.	HRF HbO S03D01    R             % 15.	HRF HbO S08D05    L
        % 05.	HRF HbO S03D02    R             % 16.	HRF HbO S08D06    L
        % 06.	HRF HbO S03D04    R             % 17.	HRF HbO S08D07    L
        % 07.	HRF HbO S04D02    R             % 18.	HRF HbO S09D06    L
        % 08.	HRF HbO S04D03    R             % 20.	HRF HbO S09D08    L
        % 09.	HRF HbO S04D04    R             % 19.	HRF HbO S09D07    L
        % 10.	HRF HbO S05D03    R             % 22.	HRF HbO S10D08    L
        % 11.	HRF HbO S05D04    R             % 21.	HRF HbO S10D07    L
        % Only include long channels (exclude short-separation channels SSC)
        chIdxR = [1:2, 4:11];
        chIdxL = [12:13, 15:18, 20, 19, 22, 21];
    case 'prefrontal'
        % Brite Frontal with 22 long channels and 2 short separation
        % channels using 8 Rx and 10 Tx (for Homer Export)
        % See https://www.dropbox.com/s/3re9e089u5qolch/Brite_Frontal_22_2_SSC_Homer.png?dl=0
        % Channels list
        % 01.	HbO S01D01      R           % 23.	HbO S09D08      L
        % 02.	HbO S04D01      R           % 22.	HbO S08D08      L
        % 03.	HbO S03D01      (Right SSC) % 24.	HbO S10D08      (Left SSC)
        % 04.	HbO S01D02      R           % 19.	HbO S09D06      L
        % 05.	HbO S02D02      R           % 17.	HbO S07D06      L
        % 06.	HbO S04D02      R           % 18.	HbO S08D06      L
        % 07.	HbO S05D02      R           % 16.	HbO S06D06      L
        % 08.	HbO S04D03      R           % 21.	HbO S08D07      L
        % 09.	HbO S05D03      R           % 20.	HbO S06D07      L
        % 10.	HbO S02D04      R           % 13.	HbO S07D04      L
        % 11.	HbO S05D04      R           % 12.	HbO S06D04      L
        % 14.	HbO S05D05      R           % 15.	HbO S06D05      L
        % Only include long channels (exclude short-separation channels SSC)
        chIdxR = [1:2, 4:11, 14];
        chIdxL = [23 22 19 17 18 16 21 20 13 12 15];
end
%% List channels
%         for idx = 1:numel(output.dc.measurementList)
%             if contains(output.dc.measurementList(idx).dataTypeLabel,'HbO')
%                 fprintf('%s S%02dD%02d\n', output.dc.measurementList(idx).dataTypeLabel,...
%                     output.dc.measurementList(idx).sourceIndex, ...
%                     output.dc.measurementList(idx).detectorIndex);
%             end
%         end
% EOF