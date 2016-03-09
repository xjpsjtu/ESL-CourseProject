%test KNN
for t = 1:50
    k = t * 10;
    test_data = data_inst([1:1200],:);
    test_label = data_label([1:1200],:);
    train_data = data_inst([1201:2072],:);
    train_label = data_label([1201:2072],:);
    ans = knnclassify(test_data,train_data,train_label,k,'cosine','random');

    cnt = 0;
    for i = 1:1200
        if ans(i) == test_label(i)
            cnt = cnt +  1;
        end
    end
    knn_data(t) = cnt/1200
end
