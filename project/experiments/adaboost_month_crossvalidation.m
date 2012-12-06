M = 1;

fprintf('M=%d\n\n', M);

trainer = @(X, Y) adaboost_train(X,Y,M);
predictor = @adaboost_predict;

[avg_accuracy, accuracies, string] = crossvalidation(trainer, predictor, X, Y, months, 1);
fprintf(string);
accuracies = accuracies'

clear M trainer predictor string;