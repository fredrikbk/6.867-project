lookback = 2;
numR = length(sparseX(:,1));
numC = length(sparseX(1,:));
sparseAugX = spalloc(numR, (lookback+1)*numC, lookback*length(find(sparseX)));

sparseAugX(1,1:numC) = sparseX(1,1:numC);
for i=2:numR
    sparseAugX(i, 1:numC) = sparseX(i,1:numC);
    sparseAugX(i,numC+1:(lookback+1)*numC) = sparseAugX(i-1,1:(lookback)*numC);
end