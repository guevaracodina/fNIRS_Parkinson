function T = displayStats(filename, Hb, p_threshold, flag_contrast)
% Modified to work with more than 1 condition only on baseline
% Modified from script by Meryem A. Yücel, PhD
% Use contrast [1 0] for two conditions for example
% T = displayStats('D:\Edgar\fNIRS_data\Parkinson\Control\homerOutput\Control\Control.mat', 1, 0.05, 0);
% e.g. displayStats('DEMO.mat', 1, 0.05, 1)
% filename     : name of the output file, including .mat extension
% Hb           : (1) HbO; (2) HbR; (3) HbT
% p_threshold  : p threshold for paired t-test stats
% flag_contrast: (1) contrast stats (0) baseline vs condition
% T table with statistics
% load output
load(filename);
disp(filename);
switch Hb
    case 1
        disp('HbO')
    case 2
        disp('HbR')
    case 3
        disp('HbT')
end
% display source-detector pairs, tval and pval for the channels that pass pval threshold
if flag_contrast
    
    if ~isfield(output.misc,'hmrstatsG_contrast')
        disp('No statistical output for contrast')
        return
    end
    ml = output.misc.hmrstatsG_contrast.ml;
    
    lst_thresh = find(output.misc.hmrstatsG_contrast.pval(Hb,:)<p_threshold);
    
    for i = 1:size(output.misc.hmrstatsG_contrast.ml,1)
        tval(i) = output.misc.hmrstatsG_contrast.tstats{Hb,i}.tstat;
    end
    sig_before_fdr = output.misc.hmrstatsG_contrast.pval(Hb,:);
        sig_after_fdr = ioi_fdr(sig_before_fdr);
    T = array2table([ml(lst_thresh,1), ml(lst_thresh,2), tval(lst_thresh)', ...
        output.misc.hmrstatsG_contrast.pval(Hb,lst_thresh)', sig_after_fdr(lst_thresh)']...
        ,'VariableNames',{'Source','Detector','tval','pval', 'pval_corr'});
    
    disp(T)
    
else
    % Baseline condition
    if ~isfield(output.misc,'hmrstatsG_base_cond')
        disp('No statistical output for baseline vs condition')
        return
    end
    ml = output.misc.hmrstatsG_base_cond.ml;
    nCond = size(output.misc.hmrstatsG_base_cond.pval, 3);
    for iCond=1:nCond
        fprintf('Condition %d of %d\n', iCond, nCond)
        lst_thresh = find(output.misc.hmrstatsG_base_cond.pval(Hb,:,iCond)<p_threshold);
        sig_before_fdr = output.misc.hmrstatsG_base_cond.pval(Hb,:,iCond);
        sig_after_fdr = ioi_fdr(sig_before_fdr);
        for i = 1:size(output.misc.hmrstatsG_base_cond.ml,1)
            tval(i) = output.misc.hmrstatsG_base_cond.tstats{Hb,i,iCond}.tstat;
        end
        
        T{iCond} = array2table([ml(lst_thresh,1), ml(lst_thresh,2), tval(lst_thresh)', ...
            output.misc.hmrstatsG_base_cond.pval(Hb,lst_thresh,iCond)', sig_after_fdr(lst_thresh)']...
            ,'VariableNames',{'Source','Detector','tval','pval', 'pval_corr'});
        
        disp(T{iCond})
    end
end

