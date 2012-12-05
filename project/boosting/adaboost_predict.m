function [ prediction ] = adaboost_predict( x, d, s )
    prediction = stump_predict(x,d,s);
end

