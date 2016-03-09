result = zeros(10, 10);
c = 2 .^ (-1:8);
gamma = 2 .^ (-12:-3);
for cIndex = 1:10
    for gammaIndex = 1:10
        result(cIndex, gammaIndex) = crossValidation('lda', 'svm', c(cIndex), gamma(gammaIndex));
    end
    disp(result);
end