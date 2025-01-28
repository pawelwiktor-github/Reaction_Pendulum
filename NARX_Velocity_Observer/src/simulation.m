clear; clc;

% Range of values for fi_pend0
angles_deg = [-5, 15, -25]; % Skip 0 degrees
fi_pend0_values = deg2rad(angles_deg); % Conversion to radians
simulation_time = 20; % Duration of one simulation
% Structures to store results
Pendpos = [];
Pendvel = []; 
Rotorvel = []; 
Ctrl = []; 
Time = []; 

% Loading data
load('exp_data_RP.mat'); % model execution
load('fisMam.mat'); % controller

% Iterate through all angle values fi_pend0
for i = 1:length(fi_pend0_values)
    fi_pend0 = fi_pend0_values(i); % Current initial angle value

    % Set value in workspace
    assignin('base', 'fi_pend0', fi_pend0);

    % Set the simulation time
    set_param('ReactionPendulum_Simulation_Model', 'StopTime', num2str(simulation_time));

    % Simulation start
    simOut = sim('ReactionPendulum_Simulation_Model');

    % Saving results
    Pendpos = [Pendpos; PendPos.signals.values]; 
    Pendvel = [Pendvel; PendVel.signals.values]; 
    Rotorvel = [Rotorvel; dcVel.signals.values]; 
    Ctrl = [Ctrl; Control.signals.values]; 
    Time = [Time; PendPos.time]; 

    % Progress display
    if mod(i, 5) == 0
        fprintf('Iteration %d completed. There are %d left.\n', i, length(fi_pend0_values)-i);
    end

end

