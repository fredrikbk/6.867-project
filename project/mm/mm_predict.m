function [ xt1 ] = mm_predict( xt0, theta)
    xt0 = normalize(xt0);

    largest = -1;
    largest_id = 0;
    for i=1:length(theta(1,:))
        if theta(xt0, i) > largest
            largest = theta(xt0, i);
            largest_id = i;
        end
    end
    xt1 = (largest_id * 2) - 3;
end

