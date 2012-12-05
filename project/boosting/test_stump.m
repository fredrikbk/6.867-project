Xtmp = uint32(full(X));

Ntmp=length(X(:,1));
Wtmp = ones(Ntmp)/Ntmp;

[word,s] = stump_train(Xtmp, Y, Wtmp);

words = import_words();
fprintf(1, '%s (%d)\n', words{word}, s);


clear Xtmp;
clear Wtmp;
clear Ntmp;
