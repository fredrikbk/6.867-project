theta = mm_train(Y);

fprintf(1, '(xt0, xt1) = (%d, %d)\n', Y(2), Y(3));
prediction = mm_predict(Y(2), theta);


fprintf(1, 'xt1 prediction = %d\n', prediction);