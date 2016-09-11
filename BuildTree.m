function [ threshold, column, gini, left_data, right_data ] = BuildTree( matrix, n, cols )
%BuildTree 
%   This should really be "BuildNode" - this only does one node at a time,
%   and the other 2 nodes will just be hard coded for simplicity of the
%   problem 
%   `matrix` - the dataset
%   `cols`   - an array specifying the index of the columns to be analyzed
%       (i.e., which attributes to analyze)
%   `n`      - number of partitions to test
%   Return value
%   `threshold`  - the value of the split threshold
%   `column` - which column (attribute) is being used to split 
%   `gini`   - the gini index for the chosen split 
%   `left_data` - a new data matrix, filtered to only contain entries whose
%        selected attribute is below the split threshold
%   `right_data` - a new data matrix, with only those above threshold

    gini = 1; % higher than the worst case -- we will now minimize this
    threshold = 0; % Will set this based on best Gini
    sorted_by_best = []; % Will be set to data sorted by the optimal chosen attribute
    
    for col = cols
            [sorted_data, bounds, class_counts] = EqWidthPartition(matrix, n, col, 11);
            [gini_idx, ~, ~] = SplitMetrics(class_counts, size(matrix,1));
            for k = 1:n-1
                if gini_idx(k) < gini
                    gini = gini_idx(k);
                    threshold = bounds(k+1);
                    column = col;
                    sorted_by_best = sorted_data;
                end
            end
    end
    left_predicate = sorted_by_best(:,column) <= threshold;
    right_predicate = ones(size(left_predicate,1),1) - left_predicate;
    
    left_data = sorted_by_best(logical(left_predicate),:);
    right_data = sorted_by_best(logical(right_predicate),:);
end

