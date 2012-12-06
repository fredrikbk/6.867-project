words = importdata('text/results.txt');
labels = importdata('dow_2007.txt');

removelabel = [];

indices = [];
for i=1:length(labels.textdata)
    broken = 0;
    for j=1:length(words.textdata)
        if(strcmp(words.textdata(j), labels.textdata(i)))
            indices(end+1) = j;
            broken = 1;
            break
        end
    end
    if ~broken
        fprintf(2, 'No WSJ for %d\n', i);
        removelabel(end+1) = i;
    end
end

months = cell(1,12);
dates = labels.rowheaders;
dates(removelabel, :) = [];

for i=1:length(dates)
    month = str2num(strtok(dates{i},'/'));
    months{month} = [months{month} i];
end

X = sparse(words.data(indices, :));
Y = labels.data;
Y(removelabel, :) = [];

class0 = X(find(Y - 1),:);
count0 = length(class0(:,1));
class0(class0 > 1) = 1;
class0 = full(sum(class0, 1))';

class1 = X(find(Y + 1),:);
count1 = length(class1(:,1));
class1(class1 > 1) = 1;
class1 = full(sum(class1, 1))';

classes = cell(2);
classes{1} = create_nbtrain_struct(class0, count0);
classes{2} = create_nbtrain_struct(class1, count1);

clear i j removelabel indices broken dates month;
clear words;
clear class0 count0 class1 count1;
clear labels;
clear removelabel;
