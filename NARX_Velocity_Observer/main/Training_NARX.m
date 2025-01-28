% Creating NARX training
clear; clc
%% Loading data
%load("data_positive_max_swing.mat");
%load("data_2_max_swings.mat");
load('data_complex.mat');

% Extracting variables
control = Ctrl; % First input
pendPos = Pendpos; % Second input
DCVel = Rotorvel; % Third input
pendVel = Pendvel; % Output (target)

% Combining inputs into matrix
X = [control'; pendPos'; DCVel']; 

% Converting target (output) into a numerical matrix
T = pendVel'; 

%% Creating NARX
% NARXNet configuration
inputDelays = 1:5; % Define input delays
feedbackDelays = 1:5; % Define feedback delays
hiddenNeurons = 16; %Define number of neurons in hidden layer

% Creation of a NARX network with 3 inputs
net = narxnet(inputDelays, feedbackDelays, hiddenNeurons);

% Data preparation for training
[Xs, Xi, Ai, Ts] = preparets(net, con2seq(X), {}, con2seq(T));

% Configuration of training parameters
net.trainFcn = 'trainlm';            % Levenberg-Marquardt algorithm
net.trainParam.epochs = 5000;       % Number of epochs
net.trainParam.mu = 1e-5;            % Learning factor
net.trainParam.max_fail = 6;         % Number of attempts without improvement
net.trainParam.min_grad = 1e-10;     % Prevent early stopping due to gradient
net.trainParam.goal = 0;             % No performance goal
net.trainParam.showWindow = true;
net.trainParam.showCommandLine = true;
net.divideParam.trainRatio = 1;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;

%% Training net
% Training
net = train(net, Xs, Ts, Xi, Ai);

% Visualization
view(net);

%% Performance
% Checking network performance after training
Ys = net(Xs, Xi, Ai);
performance = perform(net, Ys, Ts); % MSE on training data
disp(['Performance (MSE): ', num2str(performance)]);

%% Saving net into .mat format

% Saving network to file
save('trained_net_6', 'net');
% Display information
disp('The trained net has been saved as "trained_net_6.mat".');