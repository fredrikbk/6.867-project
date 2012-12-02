theta = nb_train(examples);

size = count0 + count1;
pi = [count0 / size, count1 / size];

correct = 0;
total = 0;
for i=1:249
    predict = nb_predict(full(sparseX(i,:)), theta, pi);
%    fprintf(1,'%d, %d\n',predict, Y(i));
    correct = correct + (predict == Y(i));
    total = total + 1;
end

fprintf(1, '%f\n', correct / total);