function svm_project(X, Y, fn, C)
disp('======Training======');
% load data from csv files

% Carry out training for dual
alphas = svm_kernel(X, Y, fn, C);

% Define the predictSVM(x) function, which uses trained parameters
Sidx = arrayfun(@(x) 0.001 < x         , alphas);
Midx = arrayfun(@(x) 0.001 < x && x < C, alphas);

w0 = 0;
for j = 1:length(Midx)
    if Midx(j) == 1
        soln = 0;
        for i = 1:length(Sidx)
            soln = soln + alphas(i)*Y(i)*fn(X(j,:),X(i,:)); 
        end
        soln = Y(j) - soln;
        w0 = w0 + soln;
    end
end

w0 = w0 / sum(Midx);


%sum([-1,-2] * X' * diag(alphas) * diag(Midx) * diag(Y))
%sum([-1,-2] * X' * diag(alphas) * diag(Midx))




predictSVM = @(x) sum(kern_map(x, X, fn) * diag(alphas) * diag(Y) * diag(Midx)) + w0;

predictSVM(X(1,:)')
predictSVM(X(3,:)')
printStats(X, Y, predictSVM);
