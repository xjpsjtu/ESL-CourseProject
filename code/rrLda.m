function V = rrLda(data, dataGroup)
    N = size(data, 1);
    K = size(unique(dataGroup), 1);
    p = size(data, 2);
    
    %计算M
    M = zeros(K, p);
    indices = 1:N;
    for k = 1:K
        M(k, :) = mean(data(indices(dataGroup == k), :));
    end
    
    %计算协方差矩阵W
    W = zeros(p);
    for k = 1:K
        Xk = data(indices(dataGroup == k), :);
        W = W + cov(Xk) * (size(Xk, 1) - 1);
    end
    W = W / (N - K);
    
    [wU, wS, unused1] = svd(W);
    
    %计算白化之后的矩阵MStar
    L = sum(double(diag(wS) > 0.000001));
    wSDiag = diag(wS);
    W2 = wU(:, 1:L) * diag(wSDiag(1:L) .^ (-0.5));
    MStar = M * W2;
    
    BStar = cov(MStar);
    [VStar, unused1, unused2] = svd(BStar);
    V = W2 * VStar;
end
