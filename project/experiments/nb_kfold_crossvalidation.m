k = 10;

fprintf('k=%d\n\n', k);

trainer = @nb_train;
predictor = @nb_predict;

[avg_accuracy, accuracies, string] = kfold_crossvalidation(trainer, predictor, X, Y, k, 0);
fprintf(string);
accuracies = accuracies'

clear M trainer predictor string;