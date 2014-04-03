function [ num, str ] = num_equals( Y1, Y2 )
    assert(length(Y1) == length(Y2));
    
    num = 0;
    for i=1:length(Y1)
        if Y1(i) == Y2(i)
            num = num + 1;
        end
    end
    
    str = sprintf('Predicted %d/%d correct (%.2f%%%%).\n', num, length(Y1), 100*num/length(Y1));
end

