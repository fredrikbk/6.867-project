function [ stump ] = stump_train( X, Y, W )
    print_percentage = 1;
    print_result = 1;

    N = length(X(:,1));
    D = length(X(1,:));
    
    assert(length(W) == N);
 
    % Should be done by caller
%    X = uint32(full(X));

    print_stride = int32(floor(D/10));
    print_iter = 1;
    percent = 0;
    
    % Find the dimension to separate in that best classifies the data
    best_numwrongw = N+1;
    best_numwrong = N+1;
    best_d = 0;
    best_s = 0;
    
    for d=1:D
        numwrong = 0;
        numwrongw = 0;
        numcorrectw = 0;
        
        % Try to predict all examples with s=1
        s = 1;
        
        for n=1:N
            if predictor(X(n,d), s) ~= Y(n)
                numwrong = numwrong + 1;
                numwrongw = numwrongw + W(n);
            else
                numcorrectw = numcorrectw + W(n);
            end
        end
        if numwrong > N/2
            % Turns out a better predictor is s=-1
            numwrong = N - numwrong;
            numwrongw = numcorrectw;
            s = -1;
        end
        
        if numwrongw < best_numwrongw
            best_numwrong = numwrong;
            best_numwrongw = numwrongw;
            best_d = d;
            best_s = s;
        end
        
        if print_percentage
            % Print out every 10%
            if print_iter == print_stride
                percent = percent + 10;
                print_iter = 0;
                fprintf(1, '%d%%\n', percent);
            end
            print_iter = print_iter + 1;
        end
    end
    assert(best_d ~= 0);
    
    if print_result == 1
        words = import_words;
        fprintf(1, 'Best word is: %s (#%d). It classified %d examples correctly.\n', words{best_d}, best_d, N-best_numwrong);
        if best_s == 1
            fprintf(1, 'If that word was present the stock market was more likely to go up\n\n');
        else
            fprintf(1, 'If that word was present the stock market was more likely to go down\n\n');
        end
    end
    
    stump = struct('d', best_d, 's', best_s);
end

% Can't use stump_predict for performance reasons and I didn't want 
% an extra file.
function [prediction] = predictor(x,s)
    if x > 0
        prediction = s;
    else
        prediction = -s;
    end
end