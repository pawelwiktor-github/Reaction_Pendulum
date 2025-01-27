%% 
% *Friction Coefficients Identification*

%% Load experimental data
load pozycjakata90st.mat

%% Zmienne

    T = PozycjaKata.time(107:end,1);
    T = T - T(1);
    angle = PozycjaKata.signals.values(107:end,1) - 1.567;
    
%% Plot
    % figure()
    % plot(T,angle);
    
 %% Wzory
 J_pend = 0.026668518142893;
 uc_init = 0.001;
 uv_init = 0.001;
 
 %Przyk³adowe
 uv_pend = 1.847652061155842e-04;
 uc_pend = 0.004345619039819;

 g = 9.81;
 U = 0.012144;
 fi0 = angle(1);
 omega0 = 0;
 %% Warunki pocz¹tkowe
 omega_pend0 = 0;
 fi_pend0 = 0;
 omega_dc0 = 0;
 fi_dc0 = 0;
 
  %% Wyniki
% Estymacja 
% uc_init = 0.004345619039819 /kinetryczne
% uv_init = 1.847652061155842e-04
% J_wahadlo = 0.026668518142893
