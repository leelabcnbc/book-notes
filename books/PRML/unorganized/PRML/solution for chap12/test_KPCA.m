x = load('pca_2d/pcaData.txt','-ascii');

X = x'; % using convention in my solution.

X = bsxfun(@minus, X, mean(X,1));
N = size(X,1);

C = 1/N*X'*X;
K = X*X';

% vectors of C
[V,DV] = svd(C);
[A,DA] = svd(K);
A = A(:,1:2);
Ac = A;

A(:,1) = A(:,1)/norm(A(:,1))*(1/sqrt(DV(1,1)*N));
A(:,2) = A(:,2)/norm(A(:,2))*(1/sqrt(DV(2,2)*N));


% A(:,1)'*A(:,1) - 1/(DV(1,1)*N)
% A(:,2)'*A(:,2) - 1/(DV(2,2)*N)

YbyPRML = K*A;
YbyMe = Ac;
YbyPCA = X*V;
ratio = YbyMe./YbyPRML;

disp(ratio);