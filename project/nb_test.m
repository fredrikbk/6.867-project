words = {'August', 'hallo', 'hei', 'hello', 'hey', 'ja', 'mister', 'yes'};
D = length(words);

test_counts = zeros(2, D);
test_counts(1,:) = [0 3 1 0 1 4 1 0]; % Norwegian (C=0)
test_counts(2,:) = [2 0 0 3 2 0 1 1]; % English   (C=1)

theta = nb_train(test_counts);

norwegian = [1 2 1 0 1 2 0 0]; % Norwegian (C=0)
fprintf(1, '\nValidating on Norwegian dataset\n');
prediction = nb_predict(norwegian, theta);
if prediction == 0
    fprintf(1, 'Predicted Norwegian\n');
else
    fprintf(1, 'Predicted English\n');
end

english = [2 0 0 2 1 1 1 1]; % English (C=1)
fprintf(1, '\nValidating on English dataset\n');
prediction = nb_predict(english, theta);
if prediction == 0
    fprintf(1, 'Predicted Norwegian\n');
else
    fprintf(1, 'Predicted English\n');
end