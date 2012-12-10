function [ Y ] = hmm_denorm( Yn )
    Y = Yn;
    for i=1:length(Y)
        if Y(i) == 2
            Y(i) = -1;
        end
    end
end

