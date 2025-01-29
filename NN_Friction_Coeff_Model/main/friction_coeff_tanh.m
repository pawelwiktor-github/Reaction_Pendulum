clear; clc;

% Datasets to process
datasets = {'pendulum_swing_90deg_left.mat', ...
            'pendulum_swing_90deg_right.mat', ...
            'pendulum_swing_45deg_left.mat', ...
            'pendulum_swing_45deg_right.mat'};

% Neural network parameters
num_neurons = 3; % Number of neurons
activation = @(x) tanh(x); % Tanh activation

% Friction model
model_friction = @(p, vel) ...
    sign(vel) .* (p(1) + (p(2) - p(1)) * exp(-(abs(vel) / p(3)).^p(4))) + ... % Dry friction and the Stribeck effect
    p(5) * vel; % Viscous friction

% Pendulum model including friction
model_function = @(p, vel, pos) ...
    p(6) * pos + p(7) * vel + model_friction(p(1:5), vel);

%% Validation
% Iterate through each dataset
for i = 1:length(datasets)
    % Load the dataset
    load(datasets{i});
    
    % Extract parameters from the dataset
    time = StateData.time;
    position = StateData.signals(3).values; % Pendulum position
    velocity = StateData.signals(2).values; % Pendulum velocity

    % Initialize model parameters
    params = rand(1, num_neurons * 2 + 2); % Weights and offsets [weights, biases]

    % Define the cost function (square of errors)
    cost_function = @(p) sum((position - model_function(p, velocity, position)).^2);

    % Optimize parameters using fminunc
    options = optimoptions('fminunc', 'Display', 'iter', 'Algorithm', 'quasi-newton');
    [optimal_params, cost] = fminunc(cost_function, params, options);

    % Simulate the model with optimal parameters
    simulated_position = model_function(optimal_params, velocity, position);

    %% Quality indicators
    % Calculation of the error differential (difference between actual and predicted values)
    error_val = position - simulated_position;

    % Calculation of the mean squared error (MSE)
    mse_val = mean(abs(error_val).^2);
    disp(['MSE: ', num2str(mse_val)]);
    
    % Calculation of the mean absolute error (MAE)
    mae_val = mean(abs(error_val)); 
    disp(['MAE: ', num2str(mae_val)]);

    mse(i) = mse_val;
    mae(i) = mae_val;
    
    %% Visualization
    % Subplot 1: Comparison of actual and predicted values
    figure(i)
    subplot(3, 1, 1);
    plot(time, position, 'b', 'LineWidth', 1.5); hold on;
    plot(time, simulated_position, 'r--', 'LineWidth', 1.5);
    xlabel('Time [s]');
    ylabel('Angular Position [rad]');
    title(['Comparison of Experimental and Predicted Data - ', datasets{i}], 'Interpreter', 'none');
    legend('Actual', 'Predicted');
    grid on;
    
    % Subplot 2: Error difference
    subplot(3, 1, 2);
    plot(error_val, 'k', 'LineWidth', 1.5);
    xlabel('Time [s]');
    ylabel('Difference [rad]');
    title(['Error Difference - ', datasets{i}], 'Interpreter', 'none');
    grid on;
    
    % Subplot 3: Histogram of errors
    subplot(3, 1, 3);
    histogram(error_val, 50, 'FaceColor', 'b', 'EdgeColor', 'k');
    xlabel('Error');
    ylabel('Frequency');
    title(['Error Distribution - ', datasets{i}], 'Interpreter', 'none');
    grid on;
end

avg_mse = sum(mse)/i;
avg_mae = sum(mae)/i;

% Display results of QI
disp(['Average MSE: ', num2str(avg_mse)]);
disp(['Average MAE: ', num2str(avg_mae)]);