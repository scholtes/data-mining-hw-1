function [ sorted_matrix, bounds, class_counts ] = EqFreqPartition( matrix, n, col, class_col )
%EqWidthPartition - split matrix into cell partitions
%   `matrix` is sorted by data in column `col` and then split into
%      `n` equal width partitions. `class_col` is the index of the column
%       in `matrix` which contains class labels
%    Return value is
%      `sorted_matrix`, the data matrix, `matrix`, sorted by column `col`
%      `bounds`, an array with the `n-1` splits for the `n` partitions
%      `class_counts`, like counts, but per class (each slice in the third
%           dimension is like `counts`, but only for a certain class)

    sorted_matrix = sortrows(matrix, col);
    attrs = sorted_matrix(:,col);
    classes = sorted_matrix(:,class_col);
    unique_classes = unique(classes);
    
    lower_bound = min(attrs);
    upper_bound = max(attrs);
    
    num_entries = size(matrix,1);
    bounds = linspace(1, num_entries+1, n+1);
    bounds = round(bounds(2:end-1)); % trim end and front index
    bounds = attrs(bounds); % Use values, not indexes for below logic
    
    %counts = zeros(n-1,2);
    %entries = size(attrs, 1);
    %for k = 1:n-1
    %    counts(k,1) = sum(attrs < bounds(k));
    %    counts(k,2) = entries - counts(k,1);
    %end
    
    number_of_classes = size(unique_classes,1);
    class_counts = zeros(n-1,2, number_of_classes);
    for c = 1:number_of_classes
        class = unique_classes(c);
        for k = 1:n-1
            class_counts(k,1,c) = sum(attrs <= bounds(k) & classes == class);
            class_counts(k,2,c) = sum(attrs > bounds(k) & classes == class);
        end
    end
    
    bounds = [lower_bound; bounds; upper_bound];     

end



