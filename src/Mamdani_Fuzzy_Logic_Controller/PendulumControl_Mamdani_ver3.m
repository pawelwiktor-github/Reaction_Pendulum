%% Fuzzy Logic creation

% Data to execute simulation on model 
% /comment if unnecessary
%load 'exp_data_RP.mat'
%fi_pend0 = deg2rad(30); % Initialize pendulum swing (0 -> at the equilibrium point)

%% Ranges for variables

% Define ranges for variables 
pend_angle_max = pi;
pend_angle_min = -pi;
pend_vel_max = 4.2;
pend_vel_min = -4.2;
rotor_vel_max = 450;
rotor_vel_min = -450;
control_max = 10;
control_min = -10;

%% Defining structure

% Define Mamdani FIS
fisMam_ver3 = mamfis('Name', 'PendulumControlver3', ...
                            AndMethod="min", ... 
                            OrMethod="max", ...
                            ImplicationMethod="prod", ...
                            AggregationMethod="sum", ...
                            DefuzzificationMethod="centroid");

% Inputs
fisMam_ver3 = addInput(fisMam_ver3, [pend_angle_min pend_angle_max], 'Name', 'pend_angle');
fisMam_ver3 = addInput(fisMam_ver3, [pend_vel_min pend_vel_max], 'Name', 'pend_vel');
fisMam_ver3 = addInput(fisMam_ver3, [rotor_vel_min rotor_vel_max], 'Name', 'rotor_vel'); 

% Outputs
fisMam_ver3 = addOutput(fisMam_ver3, [control_min control_max] , 'Name', 'control'); 

%% Membership functions

% Inputs
% Pendulum Angle
fisMam_ver3 = addMF(fisMam_ver3,"pend_angle","trimf",[-3.14159 -0.5 0], ...
    Name="Left",VariableType="input");
fisMam_ver3 = addMF(fisMam_ver3,"pend_angle","trimf",[-0.08 0 0.08], ...
    Name="Center",VariableType="input");
fisMam_ver3 = addMF(fisMam_ver3,"pend_angle","trimf",[0 0.5 3.14159], ...
    Name="Right",VariableType="input");

% Pendulum Velocity
fisMam_ver3 = addMF(fisMam_ver3,"pend_vel","trimf",[-4.2 -2.1 0], ...
    Name="Left",VariableType="input");
fisMam_ver3 = addMF(fisMam_ver3,"pend_vel","trimf",[-0.12 0 0.12], ...
    Name="Zero",VariableType="input");
fisMam_ver3 = addMF(fisMam_ver3,"pend_vel","trimf",[0 2.1 4.2], ...
    Name="Right",VariableType="input");

% Rotor Velocity
fisMam_ver3 = addMF(fisMam_ver3,"rotor_vel","trimf",[-450 -260 0], ...
    Name="Negative",VariableType="input");
fisMam_ver3 = addMF(fisMam_ver3,"rotor_vel","trimf",[-30 0 30], ...
    Name="Zero",VariableType="input");
fisMam_ver3 = addMF(fisMam_ver3,"rotor_vel","trimf",[0 260 450], ...
    Name="Positive",VariableType="input");

% Outputs
% Control Signal
fisMam_ver3 = addMF(fisMam_ver3,"control","trimf",[-10 -10 0], ...
    Name="Negative",VariableType="output");
fisMam_ver3 = addMF(fisMam_ver3,"control","trimf",[-0.01 0 0.01], ...
    Name="Zero",VariableType="output");
fisMam_ver3 = addMF(fisMam_ver3,"control","trimf",[0 10 10], ...
    Name="Positive",VariableType="output");

%% Rules

% Define rules (in list format)
ruleList = [
    1 0 0 3 0.0799 1; ...
    2 0 0 2 0.0799 1; ...
    3 0 0 1 0.0799 1; ...
    0 1 0 3 0.161 1; ...
    0 2 0 2 0.161 1; ...
    0 3 0 1 0.161 1; ...
    0 0 1 3 0.101 1; ...
    0 0 2 2 0.101 1; ...
    0 0 3 1 0.101 1; ...
    ];

% Add rules to FIS
fisMam_ver3 = addRule(fisMam_ver3, ruleList);

%% Visualization

% Plot the FIS structure
figure;
plotfis(fisMam_ver3);
title('Mamdani FIS Structure');

% Plot Membership functions
figure()
subplot(4,1,1)
plotmf(fisMam_ver3,"input",1)
subplot(4,1,2)
plotmf(fisMam_ver3,"input",2)
subplot(4,1,3)
plotmf(fisMam_ver3,"input",3)
subplot(4,1,4)
plotmf(fisMam_ver3,"output",1)

% Control surface
% For Pendulum Position and Pendulum Velocity vs Control Signal
figure()
subplot(3,1,1)
gensurf(fisMam_ver3, [2, 1], 1)
% For Pendulum Velocity and DC Velocity vs Control Signal
subplot(3,1,2)
gensurf(fisMam_ver3, [1, 3], 1)
% For Pendulum Position and DC Velocity vs Control Signal
subplot(3,1,3)
gensurf(fisMam_ver3, [2, 3], 1)