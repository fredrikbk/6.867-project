function [ scaledX ] = scale_data( X )

    scaledX = X;
    
    for i=1:length(scaledX(:,1))
        therow = scaledX(i, :);
        count = length(find(therow));
        sumx = sum(therow);
        for j=find(therow)
            scaledX(i,j) = scaledX(i,j) / sumx; %log(scaledX(i,j) + 1) - log(sumx + count);
        end
    end

end

