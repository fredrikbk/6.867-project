function [ prediction ] = stump_predict( x, d, s )
    if x(d) > 0
        prediction = s;
    else
        prediction = -s;
    end
end
