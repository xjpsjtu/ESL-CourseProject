%Test KNN
k = 3 % k in KNN 
test_data = inputData([1:800], :);
train_data = inputData([801:1765], :);
train_label = labels([801:1765]);
ans = knnclassify(test_data, train_data, train_label, k, 'cosine', 'random');


cnt = 0
for i = 1:800
    if ans(i) ~= labels(i)
        cnt = cnt + 1;
    end
end
