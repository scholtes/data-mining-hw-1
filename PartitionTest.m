% Hw1, #1-4
% Garrett Scholtes
% Compute answers for these problems

clear all;
clc;

data = xlsread('glassdataB.xls');

% Problem #1
% `bounds` tells you the interval boundaries
% `counts` tells you how many data are in each interval
[sorted_data, bounds_width, class_counts] = EqWidthPartition(data, 4, 4, 11);
fprintf('Problem 1:');
display(bounds_width);

% Problem #2
% Each variable is an array containing the indexes for each of the splits
[gini_idx, info_gain, gain_ratio] = SplitMetrics(class_counts, size(data,1));
fprintf('\n\nProblem 2:');
display(gini_idx);
display(info_gain);
display(gain_ratio);

% Problem #3
% Like the above problem #1, each variable is an array containing the 
% indexes for each of the splits (but this time, equal frequency not width)
[sorted_data, bounds_freq, class_counts_freq] = EqFreqPartition(data, 4, 4, 11);
fprintf('\n\nProblem 3:');
display(bounds_freq);

% Problem #4
% Each variable is an array containing the indexes for each of the splits
[gini_idx_freq, info_gain_freq, gain_ratio_freq] = SplitMetrics(class_counts_freq, size(data,1));
fprintf('\n\nProblem 4:');
display(gini_idx_freq);
display(info_gain_freq);
display(gain_ratio_freq);

% Problem #5
% Perform equal width partitioning for each of the first 3 attributes.
% Use the gini index in order to choose the best splits to form a
% complete decision tree with depth 2
[split1, column1, gini1, left_data1, right_data1] = BuildTree( data, 4, 2:4 );
% Now build the child nodes from the resultant parent
[split1a, column1a, gini1a, left_data1a, right_data1a] = BuildTree( left_data1, 4, 2:4 );
[split1b, column1b, gini1b, left_data1b, right_data1b] = BuildTree( right_data1, 4, 2:4 );

% Problem #6
% Compute the purity for each child node in the above decision tree
[purity_l1a, class_l1a] = Purity(left_data1a, 11);
[purity_l1b, class_l1b] = Purity(left_data1b, 11);
[purity_r1a, class_r1a] = Purity(right_data1a, 11);
[purity_r1b, class_r1b] = Purity(right_data1b, 11);

% ------ %

fprintf('\n\nProblems 5 and 6:\n');
fprintf('\nRoot question:\nAttribute %d < %0.4f ?\n[GINI = %0.4f]\n', column1-1, split1, gini1);
fprintf('\nLeft question:\nAttribute %d < %0.4f ?\n[GINI = %0.4f]\n', column1a-1, split1a, gini1a);
fprintf('\nRight question:\nAttribute %d < %0.4f ?\n[GINI = %0.4f]\n', column1b-1, split1b, gini1b);

fprintf('\nRoot state ----------------:\n%d entries\n', size(data, 1));

fprintf('\nRoot question - left answer:\n%d entries\n', size(left_data1,1));
fprintf('\nRoot question - right answer:\n%d entries\n', size(right_data1,1));

fprintf('\nLeft question - left answer:\n%d entries\nPurity: %0.4f\n', size(left_data1a,1), purity_l1a);
fprintf('\nLeft question - right answer:\n%d entries\nPurity: %0.4f\n', size(right_data1a,1), purity_r1a);
fprintf('\nRight question - left answer:\n%d entries\nPurity: %0.4f\n', size(left_data1b,1), purity_l1b);
fprintf('\nRight question - right answer:\n%d entries\nPurity: %0.4f\n', size(right_data1b,1), purity_r1b);