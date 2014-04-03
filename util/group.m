function [ groups ] = group( indices, numgroups )
    N = length(indices);

    groups = cell(1,numgroups);
    group_size = round(N/numgroups);
    for i=1:numgroups-1
        groupstart = (i-1)*group_size + 1;
        groupend   = (i) * group_size;
        groups{i} = indices(groupstart:groupend);
    end
    groupstart = (i)*group_size + 1;
    groupend = N;
    groups{numgroups} = indices(groupstart:groupend);
end

