function [out] = memory_data(X, lookback, alphas)

sparseX = X;
numR = length(sparseX(:,1));
numC = length(sparseX(1,:));
memoryAugX = spalloc(numR, 2*numC, lookback*length(find(sparseX)));

alphas = fliplr(alphas);

memoryAugX(1,1:numC) = sparseX(1,1:numC);
for i=2:numR
    memoryAugX(i, 1:numC) = sparseX(i,1:numC);
    
    sumc = zeros(1, numC);
    j = 1;
    for k=max(1,i-lookback):(i-1)
        sumc = sumc + alphas(j) * memoryAugX(k,1:numC);
        j = j + 1;
    end
    sumc = ceil(sumc / sum(alphas));
    memoryAugX(i,numC+1:2*numC) = sumc;
   
end

out = memoryAugX;

end
