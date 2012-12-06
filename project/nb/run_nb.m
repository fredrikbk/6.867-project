N = length(Y);

[theta, pi] = nb_train(X, Y);
pi = [1 1]

correct = 0;
for i=1:N
    prediction = nb_predict(X(i,:), theta, pi);
    if prediction == Y(i)
        correct = correct + 1;
    end
end

fprintf(1, '%.2f%%\n', 100*(correct / N));

clear theta pi correct i Xb prediction;