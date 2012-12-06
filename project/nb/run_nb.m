theta = nb_train(classes);

count0 = classes{1}.num_training_vectors;
count1 = classes{2}.num_training_vectors;

size = count0 + count1;
pi = [count0 / size, count1 / size];

correct = 0;
total = 0;
for i=1:249
    predict = nb_predict(full(X(i,:)), theta, pi);
%    fprintf(1,'%d, %d\n',predict, Y(i));
    correct = correct + (predict == Y(i));
    total = total + 1;
end

fprintf(1, '%.2f%%\n', 100*(correct / total));

clear theta count0 count1 size pi correct total i predict