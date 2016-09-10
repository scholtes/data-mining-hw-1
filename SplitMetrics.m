function [ gini_idx, info_gain, gain_ratio ] = SplitMetrics( class_counts, records )
%SplitMetrics Summary of this function goes here
%   Detailed explanation goes here

    counts = sum(class_counts(:,:,:), 3);
    number_of_classes = size(class_counts,3);
    
    num_partitions = size(class_counts, 1);
    gini_idx = zeros(num_partitions,1);
    for split = 1:num_partitions
        gini_idx(split) = 0;
        for branch = [1 2]
            gini = 0;
            for class = 1:number_of_classes
                gini = gini + (class_counts(split, branch, class)/counts(split, branch))^2;
            end
            gini = 1-gini;
            gini_idx(split) = gini_idx(split) + gini * counts(split, branch) / records;
        end
    end
    
    info_gain=0;
    gain_ratio=0;
end

