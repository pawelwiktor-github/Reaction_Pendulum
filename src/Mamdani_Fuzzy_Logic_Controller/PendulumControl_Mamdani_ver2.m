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
control_max = 1;
control_min = -1;

%% Defining structure

% Define Mamdani FIS
fisMam_ver2 = mamfis('Name', 'PendulumControlver2', ...
                            AndMethod="min", ... 
                            OrMethod="max", ...
                            ImplicationMethod="min", ...
                            AggregationMethod="max", ...
                            DefuzzificationMethod="centroid");

% Inputs
fisMam_ver2 = addInput(fisMam_ver2, [pend_angle_min pend_angle_max], 'Name', 'pend_angle');
fisMam_ver2 = addInput(fisMam_ver2, [pend_vel_min pend_vel_max], 'Name', 'pend_vel');
fisMam_ver2 = addInput(fisMam_ver2, [rotor_vel_min rotor_vel_max], 'Name', 'rotor_vel'); 

% Outputs
fisMam_ver2 = addOutput(fisMam_ver2, [control_min control_max] , 'Name', 'control'); 

%% Membership functions

% Inputs
% Pendulum Angle
fisMam_ver2 = addMF(fisMam_ver2,"pend_angle","trimf",[-3.14159 -0.5 0], ...
    Name="Left",VariableType="input");
fisMam_ver2 = addMF(fisMam_ver2,"pend_angle","trimf",[-0.08 0 0.08], ...
    Name="Center",VariableType="input");
fisMam_ver2 = addMF(fisMam_ver2,"pend_angle","trimf",[0 0.5 3.14159], ...
    Name="Right",VariableType="input");

% Pendulum Velocity
fisMam_ver2 = addMF(fisMam_ver2,"pend_vel","trimf",[-4.2 -2.1 0], ...
    Name="Left",VariableType="input");
fisMam_ver2 = addMF(fisMam_ver2,"pend_vel","trimf",[-0.12 0 0.12], ...
    Name="Zero",VariableType="input");
fisMam_ver2 = addMF(fisMam_ver2,"pend_vel","trimf",[0 2.1 4.2], ...
    Name="Right",VariableType="input");

% Rotor Velocity
fisMam_ver2 = addMF(fisMam_ver2,"rotor_vel","trimf",[-450 -250 0], ...
    Name="Negative",VariableType="input");
fisMam_ver2 = addMF(fisMam_ver2,"rotor_vel","trimf",[-30 0 30], ...
    Name="Zero",VariableType="input");
fisMam_ver2 = addMF(fisMam_ver2,"rotor_vel","trimf",[0 250 450], ...
    Name="Positive",VariableType="input");

% Outputs
% Control Signal
fisMam_ver2 = addMF(fisMam_ver2,"control","trimf",[-1.45 -0.95 -0.45], ...
    Name="Negative",VariableType="output");
fisMam_ver2 = addMF(fisMam_ver2,"control","trimf",[-0.5 0 0.5], ...
    Name="Zero",VariableType="output");
fisMam_ver2 = addMF(fisMam_ver2,"control","trimf",[0.45 0.95 1.45], ...
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
    3 3 3 3 1 1; ...
    ];

% Add rules to FIS
fisMam_ver2 = addRule(fisMam_ver2, ruleList);

%% Visualization

% Plot the FIS structure
figure;
plotfis(fisMam_ver2);
title('Mamdani FIS Structure');

% Plot Membership functions
figure()
subplot(4,1,1)
plotmf(fisMam_ver2,"input",1)
subplot(4,1,2)
plotmf(fisMam_ver2,"input",2)
subplot(4,1,3)
plotmf(fisMam_ver2,"input",3)
subplot(4,1,4)
plotmf(fisMam_ver2,"output",1)

% Control surface
% For Pendulum Position and Pendulum Velocity vs Control Signal
figure()
subplot(3,1,1)
gensurf(fisMam_ver2, [2, 1], 1)
% For Pendulum Velocity and DC Velocity vs Control Signal
subplot(3,1,2)
gensurf(fisMam_ver2, [1, 3], 1)
% For Pendulum Position and DC Velocity vs Control Signal
subplot(3,1,3)
gensurf(fisMam_ver2, [2, 3], 1)