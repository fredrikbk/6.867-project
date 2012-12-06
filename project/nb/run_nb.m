Xb = X;
Xb(Xb>1) = 1;
Xb = full(Xb);

N = length(Y);

[theta, pi] = nb_train(Xb, Y);
%pi = [1 1]

correct = 0;
for i=1:N
    prediction = nb_predict(Xb(i,:), theta, pi);
    if prediction == Y(i)
        correct = correct + 1;
    end
end

fprintf(1, '%.2f%%\n', 100*(correct / N));

clear theta pi correct i Xb prediction;