clear all; clc;

% Define all symbolic variables here

syms b1 b2; % Parameters
syms x; % Variables
f = b1 * exp(b2*x); % Actual function to which the data has to be fit

% Define the input vector here - mind the order: first row =>
% all values of the first variable and so on
X = 1:10;
variable_list = [x];

% Define the output vector here
Y = [10 12 15 18 25 39 50 67 80 80];

% Define the parameter vector here - mind the order
parameter_list = [b1 b2];
init_values_parameters = [0 0];

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

disp('MATLAB nlinfit results');
% Compute the matlab nlinfit results
% y = b1*e^(b2*x)
fit_this = @(b, x)(b(1).*exp(b(2).*x))

% Curve fitting - find the parameters
warning('off','all'); % Suppress nlinfit warnings
beta_nlinfit = nlinfit(X, Y, fit_this, init_values_parameters)
warning('on', 'all'); % Enable all the warnings again

% Find the error in each term
Y_func_nlinfit = fit_this(beta_nlinfit, X)
error_nlinfit = Y_func_nlinfit - Y

% Plot the results
plot(X, Y, 'or', X, Y_func_nlinfit, '*b', X, func_eval, 'g');
legend('Actual Data', 'MATLAB nlinfit', 'Parametric curve fit');