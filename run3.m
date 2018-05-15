clear all; clc;

% Define all symbolic variables here

syms b1 b2 b3 b4; % Parameters
syms x1 x2 x3; % Variables
f = b1*x1 + b2*exp(b3*x2)/(x2*x3) + b4*tan(x3); % Actual function to which the data has to be fit

% Define the input vector here - mind the order: first row =>
% all values of the first variable and so on
X = randn(3, 10);
variable_list = [x1 x2 x3];

% Define the output vector here
Y = randn(1,10);

% Define the parameter vector here - mind the order
parameter_list = [b1 b2 b3 b4];
init_values_parameters = [0 0 0 0];

% The usage has been made clear by the names of the variables themselves
beta = non_linear_regression(X, Y, init_values_parameters, f, variable_list, parameter_list)

% Now, predict the values
obtained_func = subs(f, parameter_list, transpose(beta));
func_eval = [];
for i = 1:length(Y)
    temp1 = subs(obtained_func, variable_list, transpose(X(:, i)));
    temp2 = eval(temp1);
    func_eval = [func_eval, temp2];
end

% Print the results
disp('Results obtained by our algorithm');
eval(obtained_func)
Y
func_eval
error = func_eval - Y