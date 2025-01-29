% Neural Network with sigmoid activation
clear; clc;

% Datasets to process
datasets = {'pendulum_swing_90deg_left.mat', ...
            'pendulum_swing_90deg_right.mat', ...
            'pendulum_swing_45deg_left.mat', ...
            'pendulum_swing_45deg_right.mat'};

%% Optimization Method Selection
% Choose one: 'fminunc', 'ga', 'simulated_annealing', 'pso'
opt_method = 'ga'; % Choose method

%% Creating NN
% Neural network parameters
num_neurons = 3; % Number of neurons
activation = @(x) 1 ./ (1 + exp(-x)); % Sigmoid activation

% Friction model
model_friction = @(p, vel) ...
    sign(vel) .* (abs(p(1)) + (abs(p(2)) - abs(p(1))) * exp(-(abs(vel) / abs(p(3))).^abs(p(4)))) + ...
    abs(p(5)) * vel; % Ensuring all parameters are positive

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
    params_init = rand(1, 8); % 8 parameters

    % Define parameter bounds to prevent non-real values
    lb = [0, 0, 0.01, 0.01, -10, -10, -10, -10]; % Lower bounds (ensuring p(3) and p(4) > 0)
    ub = [10, 10, 10, 10, 10, 10, 10, 10]; % Upper bounds

    % Define the cost function (square of errors)
    cost_function = @(p) sum((position - model_function(p, velocity, position)).^2);

    %% Optimization Selection
    switch opt_method
        case 'fminunc'
            options = optimoptions('fminunc', 'Display', 'iter', 'Algorithm', 'quasi-newton');
            [optimal_params, cost] = fminunc(cost_function, params_init, options);
        
        case 'ga' % Genetic Algorithm
            options = optimoptions('ga', 'Display', 'iter', 'PopulationSize', 50, 'MaxGenerations', 100);
            optimal_params = ga(cost_function, 8, [], [], [], [], lb, ub, [], options);
            cost = cost_function(optimal_params);
        
        case 'simulated_annealing' % Simulated Annealing
            options = optimoptions('simulannealbnd', 'Display', 'iter', 'MaxIterations', 100);
            optimal_params = simulannealbnd(cost_function, params_init, lb, ub, options);
            cost = cost_function(optimal_params);
        
        case 'pso' % Particle Swarm Optimization
            options = optimoptions('particleswarm', 'Display', 'iter', 'SwarmSize', 30, 'MaxIterations', 100);
            optimal_params = particleswarm(cost_function, 8, lb, ub, options);
            cost = cost_function(optimal_params);
        
        otherwise
            error('Invalid optimization method selected.');
    end

    % Simulate the model with optimal parameters
    simulated_position = model_function(optimal_params, velocity, position);

    %% Quality indicators
    error_val = position - simulated_position;
    mse_val = mean(abs(error_val).^2);
    mae_val = mean(abs(error_val));

    disp(['Dataset: ', datasets{i}]);
    disp(['MSE: ', num2str(mse_val)]);
    disp(['MAE: ', num2str(mae_val)]);

    mse(i) = mse_val;
    mae(i) = mae_val;
    
    %% Visualization
    figure(i)
    
    % Subplot 1: Comparison of actual and predicted values
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

%% Final Evaluation
avg_mse = sum(mse)/i;
avg_mae = sum(mae)/i;

disp(['Average MSE: ', num2str(avg_mse)]);
disp(['Average MAE: ', num2str(avg_mae)]);
