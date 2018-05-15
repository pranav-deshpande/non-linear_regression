function beta = non_linear_regression(x, y, init_values_parameters, f, variable_list, parameter_list)
    
    % List of error messages
    err1 = 'The number of input and output values do not match';
    err2 = 'The no. of parameters and length of the supplied parameter do not match';

    [rows, cols] = size(x);
    
    assert(cols == length(y), err1);
    y = y(:);
    init_values_parameters = init_values_parameters(:);
    variable_list = variable_list(:);
    parameter_list = parameter_list(:);

    auxFunc = [];
    for i = 1:cols
        temp = subs(f, variable_list, x(:, i));
        auxFunc = [auxFunc; temp];
    end
    
    assert(length(parameter_list) == length(init_values_parameters), err2);
    J = jacobian(auxFunc, parameter_list);
    %J2 = transpose(J);
    J2 = J;
    beta = init_values_parameters;
        
    for i=1:1000
        Jacobian = subs(J2, parameter_list, beta);
        final_J = eval(Jacobian);
    
        sysMat = pinv(transpose(final_J) * final_J);
        
        delFuncValue = y - subs(auxFunc, parameter_list, beta);
        delFuncVal = eval(delFuncValue);
        inputVec =  transpose(final_J) * delFuncVal; 
    
        deltaBeta = sysMat * inputVec;
        beta =  beta + deltaBeta;
        threshold = sum(deltaBeta.^2);
        
        if threshold < 1e-5
            break
        end
    end
    
end