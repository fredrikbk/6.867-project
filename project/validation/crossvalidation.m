function [avg_accuracy, accuracies, formated_string] = crossvalidation( trainer, predictor, X, Y, groups, print_debug )
%MONTH_CROSSVALIDATION Trains predictor on 11 months and validates on the
%12th in a rotating manner.
%   trainer:   function [context] = trainer(X, Y)
%   predictor: function [prediction = {-1,1}] = predictor(x, context)
%   groups:    cell array containinig a vector of indices (into X,Y) for
%              crossvalidation group.
    accuracies = zeros(1,length(groups));
    for g=1:length(groups)
        if print_debug
            fprintf('Validating on group %d/%d\n', g, length(groups));
        end

        vidxs = groups{g};

        tidxs = [];
        for t=1:length(groups)
            if t ~= g
                tidxs = [tidxs groups{t}];
            end
        end

        context = trainer(X(tidxs,:), Y(tidxs));
        accuracies(g) = validate(@(x) predictor(x,context), X(vidxs,:), Y(vidxs));

        if print_debug
            fprintf('\n');
        end
    end
    avg_accuracy = mean(accuracies);

    formated_string = sprintf('The average accuracy in crossvalidation was: %.2f%%%%\n', avg_accuracy*100);
end

