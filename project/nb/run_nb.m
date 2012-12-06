theta = nb_train(X, Y);

classes = classify_data(X, Y);
count1 = classes{1}.count;
count2 = classes{2}.count;

size = count1 + count2;
pi = [count1 / size, count2 / size];

correct = 0;
total = 0;
for i=1:size
    predict = nb_predict(full(X(i,:)), theta, pi);
%    fprintf(1,'%d, %d\n',predict, Y(i));
    correct = correct + (predict == Y(i));
    total = total + 1;
end

fprintf(1, '%.2f%%\n', 100*(correct / total));

clear theta count0 count1 size pi correct total i predict