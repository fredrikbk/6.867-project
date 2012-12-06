function [ avg_accuracy, accuracies, formated_string ] = kfold_crossvalidation( trainer, predictor, X, Y, k, print_debug )
%KFOLD_CROSSVALIDATION Randomly partition the samples into k partitions.
%                      Trains the predictor on k-1 samples and validates on
%                      the 12th in a rotating manner.
%   trainer:   function [context] = trainer(X, Y)
%   predictor: function [prediction = {-1,1}] = predictor(x, context)

    % Randomly partition data into k folds
    N = length(Y);
    idxs = randperm(N);

    folds = cell(1,k);
    fold_size = round(N/k);
    for i=1:k-1
        foldstart = (i-1)*fold_size + 1;
        foldend   = (i) * fold_size;
        folds{i} = idxs(foldstart:foldend);
    end
    foldstart = (i)*fold_size + 1;
    foldend = N;
    folds{k} = idxs(foldstart:foldend);

    [avg_accuracy, accuracies, formated_string] = crossvalidation( trainer, predictor, X, Y, folds, print_debug);
end

