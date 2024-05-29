function [pMatFDR, idxPvals] = conn_mat_fdr(pMat, alpha)
nChannels = size(pMat, 1);
idxTril = find(tril(ones(size(pMat)), -1));
qVec = pMat(idxTril);
qVecFDR = ioi_fdr(qVec);
qLU = ones(size(pMat));
qLU(idxTril) = qVecFDR;
qMat = triu(qLU.',1) + tril(qLU);  % Takes bottom half of qVec to make qMat symmetric
% figure; subplot(131); imagesc(pMat<alpha, [0 1]); axis image;
% subplot(132); imagesc(qLU<alpha, [0 1]); axis image;
% subplot(133); imagesc(qMat<alpha, [0 1]); axis image
idxPvals = qMat<alpha;
pMatFDR = nan(nChannels);
pMatFDR(idxPvals) = pMat(idxPvals);
end