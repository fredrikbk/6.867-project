M = 1;
k = 10;

fprintf('M=%d, k=%d\n\n', M, k);

trainer = @(X, Y) adaboost_train(X,Y,M);
predictor = @adaboost_predict;

[avg_accuracy, accuracies, string] = kfold_crossvalidation(trainer, predictor, X, Y, k, 0);
fprintf(string);
accuracies = accuracies'

clear M trainer predictor string;