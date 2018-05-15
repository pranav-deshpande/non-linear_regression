clear all; clc;

% Define all symbolic variables here

syms b1 b2; % Parameters
syms x1 x2; % Variables
f = b1*exp(x1)/(b2 + tan(x2)); % Actual function to which the data has to be fit

% Define the input vector here - mind the order: first row =>
% all values of the first variable and so on
X = randn(2, 100);
variable_list = [x1 x2];

% Define the output vector here
Y = randn(1,100);

% Define the parameter vector here - mind the order
parameter_list = [b1 b2];
init_values_parameters = [0.2 0.2];

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

% Plot the results
plot3(X(1, :), X(2, :), Y, 'or', X(1, :), X(2, :), func_eval, 'xg');
legend('Actual Values', 'Predicted values');