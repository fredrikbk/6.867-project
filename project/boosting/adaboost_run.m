M = 1;

N = length(X(:,1));

[d,s] = adaboost_train(X, Y, M);

numcorrect = 0;
for n=1:N
     if adaboost_predict(X(n,:),d,s) == Y(n)
         numcorrect = numcorrect + 1;
     end
end

words = import_words();

fprintf(1, 'Predictor got %d/%d (%.2f%%) correct\n', numcorrect, N, 100*numcorrect/N);