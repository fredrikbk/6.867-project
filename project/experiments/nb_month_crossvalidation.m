trainer = @nb_train;
predictor = @nb_predict;

[avg_accuracy, accuracies, string] = crossvalidation(trainer, predictor, X, Y, months, 1);
fprintf(string);
accuracies = accuracies'

clear M trainer predictor string;