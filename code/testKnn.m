result = zeros(100, 1);
for k = 1:100
    result(k) = crossValidation('pca', 'knn', k);
end