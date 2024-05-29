function Z = prewhiten(X)
% X = N-by-P matrix for N observations and P predictors
% Z = N-by-P prewhitened matrix
if true
    % 1. Size of X.
    [N,P] = size(X);
    assert(N >= P);
    
    % 2. SVD of covariance of X. We could also use svd(X) to proceed but N
    % can be large and so we sacrifice some accuracy for speed.
    [U,Sig] = svd(cov(X));
    Sig     = diag(Sig);
    Sig     = Sig(:)';
    
    % 3. Figure out which values of Sig are non-zero.
    tol = eps(class(X));
    idx = (Sig > max(Sig)*tol);
    assert(~all(idx == 0));
    
    % 4. Get the non-zero elements of Sig and corresponding columns of U.
    Sig = Sig(idx);
    U   = U(:,idx);
    
    % 5. Compute prewhitened data.
    mu = mean(X,1);
    Z = bsxfun(@minus,X,mu);
    Z = bsxfun(@times,Z*U,1./sqrt(Sig));
else
    % Alternative algorithm
    
    [m,n]=size(X);
    
    Rxx=(X*X')/n;
    
    [Ux,Dx,Vx]=svd(Rxx);
    Dx=diag(Dx);
    % n=xxx;
    if n<m % under assumption of additive white noise and
        %when the number of sources are known or can a priori estimated
        Dx=Dx-real((mean(Dx(n+1:m))));
        Z= diag(real(sqrt(1./Dx(1:n))))*Ux(:,1:n)';
        %
    else    % under assumption of no additive noise and when the
        % number of sources is unknown
        n=max(find(Dx>eps)); %Detection the number of sources
        Z= diag(real(sqrt(1./Dx(1:n))))*Ux(:,1:n)';
    end
end
if ~isequal(size(X), size(Z))
    Z = conn_regress_global(X);
end