function [yesterday, tomorrow] = shift_data(X)

sparseX = X;
numR = length(sparseX(:,1));
numC = length(sparseX(1,:));

sparseAugX = spalloc(numR, numC, length(find(sparseX)));

sparseAugX(1,1:numC) = zeros(1,numC);
for i=2:numR
    sparseAugX(i, 1:numC) = sparseX(i-1,1:numC);
end

yesterday = sparseAugX;

sparseAugX = spalloc(numR, numC, length(find(sparseX)));

sparseAugX(numR,1:numC) = zeros(1,numC);
for i=1:numR-1
    sparseAugX(i, 1:numC) = sparseX(i+1,1:numC);
end

tomorrow = sparseAugX;

end