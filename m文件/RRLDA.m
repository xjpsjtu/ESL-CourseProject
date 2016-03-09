no_dims = round(intrinsic_dim(data_inst, 'MLE'));
disp(['MLE estimate of intrinsic dimensionality: ' num2str(no_dims)]);
[mappedX, mapping] = compute_mapping(data, 'PCA',no_dims,3);
%figure
mappedX
%scatter(mappedX(:,1), mappedX(:,2), 6, data_label)
title('Result of PCA')