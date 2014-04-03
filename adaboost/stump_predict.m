function [ prediction ] = stump_predict( x, stump )
    if x(stump.d) > 0
        prediction = stump.s;
    else
        prediction = -stump.s;
    end
end
