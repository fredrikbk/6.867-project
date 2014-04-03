function [ xt1 ] = mm_predict( xt, theta)
    xt = xt';

    for i=1:length(xt)
        xt(i) = normalize(xt(i));
    end

    largest = -1;
    largest_id = 0;
    
    for i=1:2
        if theta(mmidx([xt, i])) >= largest
            largest = theta(mmidx([xt, i]));
            largest_id = i;
        end
    end
    xt1 = (largest_id * 2) - 3;
end

