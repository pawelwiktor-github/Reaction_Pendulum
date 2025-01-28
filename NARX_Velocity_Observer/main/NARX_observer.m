% Executing NARX
clear; clc
%% Loading data
% Load net data
load('trained_net_6.mat');

% Load refference data
%load('data_single_30deg.mat'); 
%load('data_double_-25deg_25deg.mat'); 
%load('data_double_15deg_20deg.mat'); 
%load('data_triple_-5deg_15deg_-25deg.mat');

% Extracting variables
time = Time;            % Time
control_val = Ctrl;     % First input
pendPos_val = Pendpos;  % Second input
DCVel_val = Rotorvel;   % Third input
pendVel_val = Pendvel;  % Output (target)

%% Preparition for validation
% Combining inputs into matrix
X_val = [control_val'; pendPos_val'; DCVel_val']; 

% Converting target (output) into a numerical matrix
T_val = pendVel_val'; 

% Preparation of new data for validation
[Xs_val, Xi_val, Ai_val, Ts_val] = preparets(net, con2seq(X_val), {}, con2seq(T_val));

% Prediction of results using loaded net
Ys_val = net(Xs_val, Xi_val, Ai_val);

% Conversion of predicted and actual results into numerical matrices
predicted_val = cell2mat(Ys_val); % Predicted results by network
actual_val = Pendvel(1:length(predicted_val))';
%% Quality indicators
% Calculation of the error differential (difference between actual and predicted values)
error_val = actual_val - predicted_val;

% Calculation of the mean squared error (MSE)
mse_val = mean(abs(error_val).^2);
disp(['MSE: ', num2str(mse_val)]);

% Calculation of the mean absolute error (MAE)
mae_val = mean(abs(error_val)); 
disp(['MAE: ', num2str(mae_val)]);

%% Visualization
% Subplot 1: Comparison of actual and predicted values
subplot(3, 1, 1);
plot(actual_val, 'b', 'LineWidth', 1.5); hold on;
plot(predicted_val, 'r--', 'LineWidth', 1.5);
xlabel('Sample');
ylabel('Value');
title('Comparison of Actual and Predicted Data (Validation)');
legend('Actual', 'Predicted');
grid on;

% Subplot 2: Error difference
subplot(3, 1, 2);
plot(error_val, 'k', 'LineWidth', 1.5);
xlabel('Sample');
ylabel('Error');
title('Error Difference (Validation)');
grid on;

% Subplot 3: Histogram of errors
subplot(3, 1, 3);
histogram(error_val, 50, 'FaceColor', 'b', 'EdgeColor', 'k');
xlabel('Error');
ylabel('Frequency');
title('Error Distribution (Validation)');
grid on;
