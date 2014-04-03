function [ percent_correct, guessed0, guessed1 ] = k_nearest( decomp, logX, Y, k)


guessed0 = 0;
guessed1 = 0;
correct = 0;
total = 0;

% Guess for each input vector
for i=1:length(logX(1,:))
    minangs = 100000*ones(1,k);    
    closest = zeros(1,k);
    
    projected = project_input(decomp, logX(:, i));
    
    for j=1:length(decomp{3}(:,1))
        if j == i
            continue
        end
        
        ang = dist_metric(projected, decomp{3}(j,:));
        
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
    
    correct = correct + (guess == Y(i));
    if guess == 1
        guessed1 = guessed1 + 1;
    else
        guessed0 = guessed0 + 1;
    end
    
    total = total + 1;
        
    
end

guessed1 = guessed1/total;
guessed0 = guessed0/total;

percent_correct =  correct / total;


end


function [output] = dist_metric(vec1, vec2)
    % Angle similarity
    %output = acos((vec1 * vec2')/(norm(vec1)*norm(vec2))) * (180/pi);
    %output = min(output, 360-output);
    
    % L2 distance
    output = norm(vec1 - vec2);
end

