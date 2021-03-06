N = length(Y);

tic
nb = nb_train(X, Y);
toc

tic
correct = 0;
for i=1:N
    prediction = nb_predict(X(i,:), nb);
    if prediction == Y(i)
        correct = correct + 1;
    end
end
toc

fprintf(1, '%.2f%%\n', 100*(correct / N));

clear theta pi correct i Xb prediction;