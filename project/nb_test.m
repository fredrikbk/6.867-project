words = {'August', 'hallo', 'hei', 'hello', 'hey', 'ja', 'mister', 'yes'}
D = length(words);

examples = cell(2);

% Norwegian (C=0)
norwegian_examples = struct('num_training_vectors', 5, 'training_vector_sums', sparse(1,D));
norwegian_examples.training_vector_sums = [1 3 1 0 1 4 1 0]
examples{1} = norwegian_examples;

% English (C=1)
english_examples = struct('num_training_vectors', 4, 'training_vector_sums', sparse(1,D));
english_examples.training_vector_sums   = [2 0 0 3 2 0 1 2]
examples{2} = english_examples;

theta = nb_train(examples);
norwegian_theta = theta{1}
english_theta = theta{2}

norwegian = [1 1 1 0 0 1 0 0]; % Norwegian (C=0)
fprintf(1, '\nValidating on Norwegian dataset\n');
prediction = nb_predict(norwegian, theta);
if prediction == 0
    fprintf(1, 'Predicted     Norwegian\n');
else
    fprintf(1, 'Predicted     English\n');
end

english = [1 0 0 1 1 1 1 1]; % English (C=1)
fprintf(1, '\nValidating on English dataset\n');
prediction = nb_predict(english, theta);
if prediction == 0
    fprintf(1, 'Predicted     Norwegian\n');
else
    fprintf(1, 'Predicted     English\n');
end

clear words
clear D
clear test_counts
clear theta
clear norwegian
clear english
clear prediction