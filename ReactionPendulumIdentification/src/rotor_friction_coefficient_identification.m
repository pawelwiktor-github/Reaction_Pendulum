%% 
% *Friction Coefficients Identification*

%% Load experimental data
load enclousure_method_control_negative.mat

%% Variables

omega_1 = PozycjaKata.signals(1).values(523:1187,1);
omega_2 = PozycjaKata.signals(1).values(1191:4247,1);
T_1 = PozycjaKata.time(523:1187,1);
T_2 = PozycjaKata.time(1191:4247,1);
omega = [omega_1; omega_2];
T = [T_1; T_2];
T = T - T(1);
h = 0.00632 %[cm]
r = 0.10812/2 %[cm]
ro = 2700 % [kg/c5.802m^3]

% Equations
V = pi * r^2 * h;
m = ro * V;
J_dc = (1/2) * m * r^2; % [g*cm^2]
% J_rotor = J_rotor / (10000*1000);

% Initial guess
% uv_init = 0.0001; 
% uc_init = 0.0001;
% uv_dc = 4.6313e-06
% uc_dc = 0.017 % (estimated)

% Omega initialization
omega0 = omega(1);

% Visualization
% figure()
% plot(T,omega)

%% Results

uv_dc = 5.3017e-06
uc_dc = 0.0016 

kt = 0.026 % 0.027; % Motor Torque Constant [ Nm / A ]
kr = 0.026 % 0.025; % Motor electrical constant [ Vsrad ]
R_dc = 2.4; % Motor winding resistance [ Ohm ]