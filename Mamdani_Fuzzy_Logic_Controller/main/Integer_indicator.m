% Integer indicator for disturbances

% List of files for analysis
files = {'repeating_sequence_02.mat', ...            % angle swings disturbance
         'repeating_sequence_02_length15mm.mat', ... % angle swings disturbance + longer distance from pivot point
         'repeating_sequence_02_dcvel100.mat'};      % angle swings disturbance + constant rotor disc velocity 

% Variable initialisation
square_error_quality = zeros(length(files), 1);     % Integer of the square of the control
time_weighted_quality = zeros(length(files), 1);    % Integer of absolute value of control * time
    
ts = [1.81574 1.81779 2.10758];

% Looping through files
for i = 1:length(files)
    % Loading data
    data = load(files{i});
    u = data.ScopeData.signals(4).values;  % Control
    t = data.ScopeData.time;               % Time
    theta = data.ScopeData.signals(1).values; % Pendulum swing angle
    
    % Determining the time range to be analysed
    if i == 1 || i == 2 || i == 3
        % Range from 10 to 30 seconds
        time_idx = t >= 10 & t < 30;
    % elseif i == 3
    %     % Range from 20 to 30 seconds
    %     time_idx = t >= 20 & t < 30;
    end

    % Trim the data to the selected time range
    t = t(time_idx) - t(find(time_idx, 1)); % Offset time to zero
    u = u(time_idx);
    theta = theta(time_idx);
    
    % 1. The integral of the square of control (J1)
    square_error_quality(i) = trapz(t, u.^2);
    
    % 2. The integral of the absolute value of control * time (J2)
    abs_u = abs(u);  % Absolute values of control
    time_weighted_quality(i) = trapz(t, abs_u .* ts(1, i));
    
    % Drawing a graph of the pendulum swing angle
    figure;
    subplot(2, 1, 1); 
    plot(t, theta, 'LineWidth', 1.5);
    grid on;
    title(sprintf('Pendulum Angular Position for Experiment: %d', i), 'Interpreter', 'latex', 'FontSize', 16);
    xlabel('Time [s]', 'Interpreter', 'latex', 'FontSize', 16);
    ylabel('Pendulum Angle [rad]', 'Interpreter', 'latex', 'FontSize', 16);
    legend('Pendulum Angle', 'Interpreter', 'latex', 'FontSize', 9);
    
    % Drawing a control graph
    subplot(2, 1, 2);
    plot(t, u, 'LineWidth', 1.5);
    grid on;
    title(sprintf('Control Signal Performance for Experiment: %d', i), 'Interpreter', 'latex', 'FontSize', 16);
    xlabel('Time [s]', 'Interpreter', 'latex', 'FontSize', 16);
    ylabel('Value', 'Interpreter', 'latex', 'FontSize', 16);
    %ylim([-1.2 1.2])
    legend('Control Signal', 'Interpreter', 'latex', 'FontSize', 9);

    % Display the results for a given file
    fprintf('File: %s\n', files{i});
    fprintf('  Integer of control square (J1): %.4f\n', square_error_quality(i));
    fprintf('  Integer of control absolute value * time (J2): %.4f\n\n', time_weighted_quality(i));
end

% Sumarry
fprintf('Summary of results:\n');
for i = 1:length(files)
    fprintf('File: %s\n', files{i});
    fprintf('  Integer of control square (J1): %.4f\n', square_error_quality(i));
    fprintf('  Integer of control absolute value * time (J2): %.4f\n\n', time_weighted_quality(i));
end
fprintf('  Regulation time (1): %.5f\n', 1.81574);
fprintf('  Regulation time (2): %.5f\n', 1.81779);
fprintf('  Regulation time (3): %.5f\n', 2.10758);
