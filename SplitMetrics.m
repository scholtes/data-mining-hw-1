function [ gini_idx, info_gain, gain_ratio ] = SplitMetrics( class_counts, records, data )
%SplitMetrics 
%   Given `class_counts` that come from `EqWidthPartition()` and the number
%   of records `records` from the dataset, compute these indexes for
%   various splits

    counts = sum(class_counts(:,:,:), 3);
    number_of_classes = size(class_counts,3);
    
    num_partitions = size(class_counts, 1);
    
    gini_idx = zeros(num_partitions,1);
    info_gain = zeros(num_partitions,1);
    gain_ratio = zeros(num_partitions,1);
    
    % Root entropy
    root_entropy = 0;
    for k = 1:number_of_classes
        probability = class_counts(1, 1, k) + class_counts(1, 2, k);
        probability  = probability / records;
        if probability > 0
            root_entropy = root_entropy - probability*log(probability);
        end
    end
    
    for split = 1:num_partitions
        gini_idx(split) = 0;
        info_gain(split) = root_entropy;
        gain_ratio(split) = 0;
        
        for branch = [1 2]
            gini = 0;
            entropy = 0;
            
            for class = 1:number_of_classes
                probability = class_counts(split, branch, class)/counts(split, branch);
                gini = gini + (probability)^2;
                if probability > 0
                    entropy = entropy - probability*log(probability);
                end
            end
            gini = 1-gini;
            density = counts(split, branch) / records;
            
            gini_idx(split) = gini_idx(split) + gini * density;
            info_gain(split) = info_gain(split) - entropy * density;
            gain_ratio(split) = gain_ratio(split) - density * log(density);
        end
        gain_ratio(split) = info_gain(split) / gain_ratio(split);
    end
    
end

