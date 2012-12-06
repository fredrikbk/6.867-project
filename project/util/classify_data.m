function [ classes ] = classify_data( X, Y )
    class1 = X(find(Y - 1),:);
    count1 = length(class1(:,1));
    class1(class1 > 1) = 1;
    class1 = full(sum(class1, 1))';

    class2 = X(find(Y + 1),:);
    count2 = length(class2(:,1));
    class2(class2 > 1) = 1;
    class2 = full(sum(class2, 1))';

    classes = cell(2);
    classes{1} = create_class(class1, count1);
    classes{2} = create_class(class2, count2);
    assert(length(classes{1}.class) == length(classes{2}.class));
end 

function [ class_struct ] = create_class( class, count )
    class_struct = struct('count', count);
    class_struct.class = class;
end

