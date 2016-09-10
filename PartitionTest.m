% Hw1, #1-4
% Garrett Scholtes
% Compute answers for these problems

clear all;

data = xlsread('glassdataB.xls');

% Problem #1
% `bounds` tells you the interval boundaries
% `counts` tells you how many data are in each interval
[sorted_data, bounds_width, class_counts] = EqWidthPartition(data, 4, 4, 11);

% Problem #2
% Each variable is an array containing the indexes for each of the splits
[gini_idx, info_gain, gain_ratio] = SplitMetrics(class_counts, size(data,1), sorted_data);

% Problem #3
% Like the above problem #1, each variable is an array containing the 
% indexes for each of the splits (but this time, equal frequency not width)
[sorted_data, bounds_freq, class_counts_freq] = EqFreqPartition(data, 4, 4, 11);

% Problem #2
% Each variable is an array containing the indexes for each of the splits
[gini_idx_freq, info_gain_freq, gain_ratio_freq] = SplitMetrics(class_counts_freq, size(data,1), sorted_data);