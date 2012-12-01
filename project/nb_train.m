function [ theta ] = nb_train( wordcounts )
    k = length(wordcounts(:,1));
    D = length(wordcounts(1,:));

    theta = zeros(k, D);
    for c = 1:k
        numc = sum(wordcounts(c,:));
        for j = 1:D
            theta(c, j) = (wordcounts(c,j) + 1) / (numc + 2);
        end
        
        % Normalize probabilities
        total = sum(theta(c,:));
        for j = 1:D
            theta(c, j) = theta(c, j) / total;
        end
        assert(sum(theta(c,:)) == 1.0);
    end
end
