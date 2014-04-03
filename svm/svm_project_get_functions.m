function [trainer, predictor] = svm_project_get_functions(fn, C)
% load data from csv files

    trainer = @(x,y) {svm_kernel(x, y, fn, C) x y};
    
    predictor = @(x, context) svm_project_predict(x, context, fn, C);

end


