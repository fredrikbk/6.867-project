function [ indices ] = ungroup(groups)
    indices = [];
    for g=1:length(groups)
        indices = [indices groups{g}];
    end
end

