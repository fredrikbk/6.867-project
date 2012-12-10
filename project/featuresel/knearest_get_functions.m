function [trainer, predictor] = knearest_get_functions(k, R)
% load data from csv files

    trainer = @(x,y) knearest_train(x, y, k, R);
    
    predictor = @(x, context) knearest_predict(x, context);

end

function [state] = knearest_train(X, Y, k, R)
    outcell = reduce_rank(X, R);
    
    state = {outcell, k, Y};
end

function [guess] = knearest_predict(x, context)
    SVD = context{1};
    k = context{2};
    Y = context{3};
    
    minangs = 100000*ones(1,k);    
    closest = zeros(1,k);
    
    projected = project_input(SVD, x');
    
    for j=1:length(SVD{3}(:,1))
        if j == i
            continue
        end
        
        ang = dist_metric(projected, SVD{3}(j,:));
        
        for myk=fliplr(1:k)
            if ang < minangs(myk)
                for z=1:myk-1
                    closest(z) = closest(z+1);
                    minangs(z) = minangs(z+1);
                end
                minangs(myk) = ang;
                closest(myk) = j;
                break
            end
        end
    end
        
    
    if (sum(arrayfun(@(x) Y(x), closest))) / k >= 0
        guess = 1;
    else
        guess = -1;
    end
end

function [output] = dist_metric(vec1, vec2)
    % Angle similarity
    %output = acos((vec1 * vec2')/(norm(vec1)*norm(vec2))) * (180/pi);
    %output = min(output, 360-output);
    
    % L2 distance
    output = norm(vec1 - vec2);
end