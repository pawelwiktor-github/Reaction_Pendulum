% Fuzzy Logic creation
%% Ranges for variables

% Define ranges for variables 
pend_angle_max = 3.14159;
pend_angle_min = -3.14159;
pend_vel_max = 4.2;
pend_vel_min = -4.2;
rotor_vel_max = 450;
rotor_vel_min = -450;
control_max = 1;
control_min = -1;

%% Defining structure

% Define Mamdani FIS
fisTS_ver1 = sugfis('Name', 'PendulumControlver1', ...
                            AndMethod="prod", ... 
                            OrMethod="probor", ...
                            ImplicationMethod="prod", ...
                            AggregationMethod="sum", ...
                            DefuzzificationMethod="wtaver");

% Inputs
fisTS_ver1 = addInput(fisTS_ver1, [pend_angle_min pend_angle_max], 'Name', 'pend_angle');
fisTS_ver1 = addInput(fisTS_ver1, [pend_vel_min pend_vel_max], 'Name', 'pend_vel');
fisTS_ver1 = addInput(fisTS_ver1, [rotor_vel_min rotor_vel_max], 'Name', 'rotor_vel'); 

% Outputs
fisTS_ver1 = addOutput(fisTS_ver1, [control_min control_max] , 'Name', 'control'); 

%% Membership functions

% Inputs
% Pendulum Angle
fisTS_ver1 = addMF(fisTS_ver1,"pend_angle","trimf",[-3.14159 -0.5 0], ...
    Name="Left",VariableType="input");
fisTS_ver1 = addMF(fisTS_ver1,"pend_angle","trimf",[-0.08 0 0.08], ...
    Name="Center",VariableType="input");
fisTS_ver1 = addMF(fisTS_ver1,"pend_angle","trimf",[0 0.5 3.14159], ...
    Name="Right",VariableType="input");

% Pendulum Velocity
fisTS_ver1 = addMF(fisTS_ver1,"pend_vel","trimf",[-4.2 -2.1 0], ...
    Name="Left",VariableType="input");
fisTS_ver1 = addMF(fisTS_ver1,"pend_vel","trimf",[-0.12 0 0.12], ...
    Name="Zero",VariableType="input");
fisTS_ver1 = addMF(fisTS_ver1,"pend_vel","trimf",[0 2.1 4.2], ...
    Name="Right",VariableType="input");
% Rotor Velocity
fisTS_ver1 = addMF(fisTS_ver1,"rotor_vel","trimf",[-450 -260 0], ...
    Name="Negative",VariableType="input");
fisTS_ver1 = addMF(fisTS_ver1,"rotor_vel","trimf",[-30 0 30], ...
    Name="Zero",VariableType="input");
fisTS_ver1 = addMF(fisTS_ver1,"rotor_vel","trimf",[0 260 450], ...
    Name="Positive",VariableType="input");

% Outputs
% Control Signal
fisTS_ver1 = addMF(fisTS_ver1,"control","constant",-0.95, ...
    Name="Negative",VariableType="output");
fisTS_ver1 = addMF(fisTS_ver1,"control","constant",0, ...
    Name="Zero",VariableType="output");
fisTS_ver1 = addMF(fisTS_ver1,"control","constant",0.95, ...
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
fisTS_ver1 = addRule(fisTS_ver1, ruleList);

%% Visualization

% Plot the FIS structure
figure;
plotfis(fisTS_ver1);
title('Mamdani FIS Structure');

% Plot Membership functions
figure()
subplot(3,1,1)
plotmf(fisTS_ver1,"input",1)
subplot(3,1,2)
plotmf(fisTS_ver1,"input",2)
subplot(3,1,3)
plotmf(fisTS_ver1,"input",3)
% subplot(4,1,4)
% plotmf(fisTS_ver1,"output",1)

% Control surface
% For Pendulum Position and Pendulum Velocity vs Control Signal
figure()
subplot(3,1,1)
gensurf(fisTS_ver1, [2, 1], 1)
% For Pendulum Velocity and DC Velocity vs Control Signal
subplot(3,1,2)
gensurf(fisTS_ver1, [1, 3], 1)
% For Pendulum Position and DC Velocity vs Control Signal
subplot(3,1,3)
gensurf(fisTS_ver1, [2, 3], 1)

%% Setup simulation

% Data to execute simulation on model 
load 'exp_data_RP.mat'
fi_pend0 = deg2rad(30); % Initialize pendulum swing (0 -> at the equilibrium point)
Control_Gain = 1; % Setup control gain multiplication

% Block Path
blockPath = 'ReactionPendulum_Simulation_Model/Takagi-Sugeno';
blockPath2 = 'ReactionPendulum_Simulation_Model/ControlGain';

% Set Param
set_param(blockPath, 'fis', 'fisTS_ver1');
set_param(blockPath2, 'Gain', 'Control_Gain');

% Simulation Time
T_final = 18;

% Execute Simulation
simOut = sim('ReactionPendulum_Simulation_Model');

% Extract variables and save to .mat file
save('firstFuzzy.mat', 'PendPosLQR', 'PendPosTS', ...
                       'PendVelLQR', 'PendVelTS', ...
                       'dcVelLQR', 'dcVelTS', ...
                       'ControlLQR', 'ControlTS')

%% Plot the results

figure()
subplot(4,1,1)
plot(PendPosLQR.time,PendPosLQR.signals.values)
hold on
x_value = 3.472; 
xline(x_value, 'r', 'LineWidth', 2); 
hold on
plot(PendPosTS.time,PendPosTS.signals.values, 'g')
hold on
x_value = 7.273; 
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
plot(PendVelTS.time,PendVelTS.signals.values, 'g')
hold on
x_value = 7.273; 
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
plot(dcVelTS.time,dcVelTS.signals.values, 'g')
hold on
x_value = 7.273; 
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
plot(ControlTS.time,ControlTS.signals.values, 'g')
hold on
x_value = 7.273;   
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
