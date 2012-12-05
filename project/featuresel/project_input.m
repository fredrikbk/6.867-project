function [ output ] = project_input( SVD, input )

% Project onto circle
%output = input'*SVD{1}*SVD{2}^-1;

% Original
output = input'*SVD{1};

end

