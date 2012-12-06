function [ avg_accuracy, accuracies, formated_string ] = kfold_crossvalidation( trainer, predictor, X, Y, k, true_random )
%KFOLD_CROSSVALIDATION Randomly partition the samples into k partitions.
%                      Trains the predictor on k-1 samples and validates on
%                      the 12th in a rotating manner.
%   trainer:   function [context] = trainer(X, Y)
%   predictor: function [prediction = {-1,1}] = predictor(x, context)

    % Randomly partition data into k folds
    N = length(Y);
    
    if true_random
        idxs = randperm(N);
    else
        idxs = importdata('rand_nums.txt')';
        assert(length(idxs) == N);
    end
    
    folds = group(idxs, k);

    [avg_accuracy, accuracies, formated_string] = crossvalidation( trainer, predictor, X, Y, folds );
end

