M = 2;

start_of_predictions = 30;

P = zeros(1,length(Y));

for i=1:M
    P(i) = 1;
end

for i=max(M+1, start_of_predictions):length(Y)
    theta = mm_train(Y(1:i), M);
    P(i) = mm_predict(Y(i-M:i-1), theta);
end

[num, str] = num_equals(P(start_of_predictions:end), Y(start_of_predictions:end));

fprintf(str);


