function [ prediction ] = adaboost_predict( x, boosted_stumps )
    vote = 0;
    for m=1:length(boosted_stumps)
        alpha = boosted_stumps{m}.alpha;
        stump = boosted_stumps{m}.stump;

        vote = vote + alpha * stump_predict(x, stump);
    end

    prediction = sign(vote);
end

