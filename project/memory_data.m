function [out] = memory_data(X, lookback)

sparseX = X;
numR = length(sparseX(:,1));
numC = length(sparseX(1,:));
memoryAugX = spalloc(numR, 2*numC, lookback*length(find(sparseX)));

memoryAugX(1,1:numC) = sparseX(1,1:numC);
for i=2:numR
    memoryAugX(i, 1:numC) = sparseX(i,1:numC);
    
    sum = zeros(1, numC);
    for k=max(1,i-lookback):(i-1)
        sum = sum + memoryAugX(k,1:numC);
    end
    sum = sum / lookback;
    memoryAugX(i,numC+1:2*numC) = sum;
   
end

out = memoryAugX;

end
