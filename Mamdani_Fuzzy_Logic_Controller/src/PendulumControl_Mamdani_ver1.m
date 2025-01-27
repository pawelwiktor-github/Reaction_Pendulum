% Fuzzy Logic creation
%% Ranges for variables

% Define ranges for variables 
pend_angle_max = 3.14159;
pend_angle_min = -3.14159;
pend_vel_max = 10;
pend_vel_min = -10;
rotor_vel_max = 450;
rotor_vel_min = -450;
control_max = 1.2;
control_min = -1.2;

%% Defining structure

% Define Mamdani FIS
fisMam_ver1 = mamfis('Name', 'PendulumControlver1', ...
                            AndMethod="min", ... 
                            OrMethod="max", ...
                            ImplicationMethod="min", ...
                            AggregationMethod="max", ...
                            DefuzzificationMethod="centroid");

% Inputs
fisMam_ver1 = addInput(fisMam_ver1, [pend_angle_min pend_angle_max], 'Name', 'pend_angle');
fisMam_ver1 = addInput(fisMam_ver1, [pend_vel_min pend_vel_max], 'Name', 'pend_vel');
fisMam_ver1 = addInput(fisMam_ver1, [rotor_vel_min rotor_vel_max], 'Name', 'rotor_vel'); 

% Outputs
fisMam_ver1 = addOutput(fisMam_ver1, [control_min control_max] , 'Name', 'control'); 

%% Membership functions

% Inputs
% Pendulum Angle
fisMam_ver1 = addMF(fisMam_ver1,"pend_angle","trimf",[-3.14159 -0.5 -0.01], ...
    Name="Left",VariableType="input");
fisMam_ver1 = addMF(fisMam_ver1,"pend_angle","trimf",[-0.02 0 0.02], ...
    Name="Center",VariableType="input");
fisMam_ver1 = addMF(fisMam_ver1,"pend_angle","trimf",[0.01 0.5 3.14159], ...
    Name="Right",VariableType="input");

% Pendulum Velocity
fisMam_ver1 = addMF(fisMam_ver1,"pend_vel","trimf",[-10 -5 -0.01], ...
    Name="Left",VariableType="input");
fisMam_ver1 = addMF(fisMam_ver1,"pend_vel","trimf",[-0.02 0 0.02], ...
    Name="Zero",VariableType="input");
fisMam_ver1 = addMF(fisMam_ver1,"pend_vel","trimf",[0.01 5 10], ...
    Name="Right",VariableType="input");
% Rotor Velocity
fisMam_ver1 = addMF(fisMam_ver1,"rotor_vel","trimf",[-450 -130 -5], ...
    Name="Negative",VariableType="input");
fisMam_ver1 = addMF(fisMam_ver1,"rotor_vel","trimf",[-10 0 10], ...
    Name="Zero",VariableType="input");
fisMam_ver1 = addMF(fisMam_ver1,"rotor_vel","trimf",[5 130 450], ...
    Name="Positive",VariableType="input");

% Outputs
% Control Signal
fisMam_ver1 = addMF(fisMam_ver1,"control","trimf",[-1.2 -1 -0.01], ...
    Name="Negative",VariableType="output");
fisMam_ver1 = addMF(fisMam_ver1,"control","trimf",[-0.02 0 0.02], ...
    Name="Zero",VariableType="output");
fisMam_ver1 = addMF(fisMam_ver1,"control","trimf",[0.01 1 1.2], ...
    Name="Positive",VariableType="output");

%% Rules

% Define rules (in list format)
ruleList = [
    1 1 1 1 1 1; ...
    2 1 1 1 1 1; ...
    3 1 1 3 1 1; ...
    1 2 1 1 1 1; ...
    2 2 1 1 1 1; ...
    3 2 1 3 1 1; ...
    1 3 1 1 1 1; ...
    2 3 1 3 1 1; ...
    3 3 1 3 1 1; ...
    1 1 2 1 1 1; ...
    2 1 2 1 1 1; ...
    3 1 2 3 1 1; ...
    1 2 2 1 1 1; ...
    2 2 2 2 1 1; ...
    3 2 2 3 1 1; ...
    1 3 2 1 1 1; ...
    2 3 2 3 1 1; ...
    3 3 2 3 1 1; ...
    1 1 3 1 1 1; ...
    2 1 3 1 1 1; ...
    3 1 3 3 1 1; ...
    1 2 3 1 1 1; ...
    2 2 3 3 1 1; ...
    3 2 3 3 1 1; ...
    1 3 3 1 1 1; ...
    2 3 3 3 1 1; ...
    3 3 3 3 1 1
    ];

% Add rules to FIS
fisMam_ver1 = addRule(fisMam_ver1, ruleList);

%% Visualization

% Plot the FIS structure
figure;
plotfis(fisMam_ver1);
title('Mamdani FIS Structure');

% Plot Membership functions
figure()
subplot(4,1,1)
plotmf(fisMam_ver1,"input",1)
subplot(4,1,2)
plotmf(fisMam_ver1,"input",2)
subplot(4,1,3)
plotmf(fisMam_ver1,"input",3)
subplot(4,1,4)
plotmf(fisMam_ver1,"output",1)

% Control surface
% For Pendulum Position and Pendulum Velocity vs Control Signal
figure()
subplot(3,1,1)
gensurf(fisMam_ver1, [2, 1], 1)
% For Pendulum Velocity and DC Velocity vs Control Signal
subplot(3,1,2)
gensurf(fisMam_ver1, [1, 3], 1)
% For Pendulum Position and DC Velocity vs Control Signal
subplot(3,1,3)
gensurf(fisMam_ver1, [2, 3], 1)

%% Setup simulation

% Data to execute simulation on model 
load 'exp_data_RP.mat'
fi_pend0 = deg2rad(30); % Initialize pendulum swing (0 -> at the equilibrium point)
Control_Gain = 1.55; % Setup control gain multiplication

% Block Path
blockPath = 'ReactionPendulum_Simulation_Model/Mamdani';
blockPath2 = 'ReactionPendulum_Simulation_Model/ControlGain';

% Set Param
set_param(blockPath, 'fis', 'fisMam_ver1');
set_param(blockPath2, 'Gain', 'Control_Gain');

% Simulation Time
T_final = 18;

% Execute Simulation
simOut = sim('ReactionPendulum_Simulation_Model');

% Extract variables and save to .mat file
save('firstFuzzy.mat', 'PendPosLQR', 'PendPosMam', ...
                       'PendVelLQR', 'PendVelMam', ...
                       'dcVelLQR', 'dcVelMam', ...
                       'ControlLQR', 'ControlMam')

%% Plot the results

figure()
subplot(4,1,1)
plot(PendPosLQR.time,PendPosLQR.signals.values)
hold on
x_value = 3.472; 
xline(x_value, 'r', 'LineWidth', 2); 
hold on
plot(PendPosMam.time,PendPosMam.signals.values, 'g')
hold on
x_value = 16.5291; 
xline(x_value, 'm', 'LineWidth', 2); 
hold off
legend('Pendulum Angle - LQR', 'Equilibrium Point - LQR', 'Pendulum Angle - Fuzzy', ...
    'Equilibrium Point - Fuzzy', 'Interpreter', 'latex', 'FontSize', 9);
title('Regulation of Pendulum Angle - Comparison', 'Interpreter', 'latex', 'FontSize', 16);
xlabel('Time [s]', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('Value [rad]', 'Interpreter', 'latex', 'FontSize', 16);
grid on
ax = gca; 
ax.FontSize = 12; 
subplot(4,1,2)
plot(PendVelLQR.time,PendVelLQR.signals.values)
hold on
x_value = 3.472; 
xline(x_value, 'r', 'LineWidth', 2); 
hold on
plot(PendVelMam.time,PendVelMam.signals.values, 'g')
hold on
x_value = 16.5291; 
xline(x_value, 'm', 'LineWidth', 2); 
hold off
legend('Pendulum Velocity - LQR', 'Equilibrium Point - LQR', 'Pendulum Velocity - Fuzzy', ...
    'Equilibrium Point - Fuzzy', 'Interpreter', 'latex', 'FontSize', 9);
title('Regulation of Pendulum Velocity - Comparison', 'Interpreter', 'latex', 'FontSize', 16);
xlabel('Time [s]', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('Value [rad/s]', 'Interpreter', 'latex', 'FontSize', 16);
grid on
ax = gca; 
ax.FontSize = 12; 
subplot(4,1,3)
plot(dcVelLQR.time,dcVelLQR.signals.values)
hold on
x_value = 3.472; 
xline(x_value, 'r', 'LineWidth', 2); 
hold on
plot(dcVelMam.time,dcVelMam.signals.values, 'g')
hold on
x_value = 16.5291; 
xline(x_value, 'm', 'LineWidth', 2); 
hold off
legend('Rotor Velocity - LQR', 'Equilibrium Point - LQR', 'Rotor Velocity - Fuzzy', ...
    'Equilibrium Point - Fuzzy', 'Interpreter', 'latex', 'FontSize', 9);
title('Regulation of Rotor Velocity - Comparison', 'Interpreter', 'latex', 'FontSize', 16);
xlabel('Time [s]', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('Value [rad/s]', 'Interpreter', 'latex', 'FontSize', 16);
grid on
ax = gca; 
ax.FontSize = 12; 
subplot(4,1,4)
plot(ControlLQR.time,ControlLQR.signals.values)
hold on
x_value = 3.472; 
xline(x_value, 'r', 'LineWidth', 2); 
hold on
plot(ControlMam.time,ControlMam.signals.values, 'g')
hold on
x_value = 16.5291;  
xline(x_value, 'm', 'LineWidth', 2); 
hold off
legend('Control Signal - LQR', 'Equilibrium Point - LQR', 'Control Signal - Fuzzy', ...
    'Equilibrium Point - Fuzzy', 'Interpreter', 'latex', 'FontSize', 9);
title('Control Signal for Pendulum - Comparison', 'Interpreter', 'latex', 'FontSize', 16);
xlabel('Time [s]', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('Value', 'Interpreter', 'latex', 'FontSize', 16);
grid on
ax = gca; 
ax.FontSize = 12; 
