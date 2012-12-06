function [ packX, packY ] = pack_data( X, Y, groups )
    indices = ungroup(groups);
    packX = X(indices,:);
    packY = Y(indices);
end

