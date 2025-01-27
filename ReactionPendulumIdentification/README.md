# Reaction Pendulum Identification

## Table of Contests

1. [General Description](#general-description)
2. [Usage Instructions](#usage-instructions)
3. [File Descriptions](#file-descriptions)
4. [Results](#results)

## General Description
This section is dedicated to the identification proccess of a nonlinear Reaction Pendulum object and creating a simulation model in Matlab/Simulink environment. 

## Usage Instructions
1. **Prerequisites**:
   - MATLAB 2024b+ or any tool capable of reading (`.m`, `.mat`, `.slx`) files is required. Additionaly Simulink extension are obligatory. To be able to open producent files, there is need to install extension mentioned in [RPend_User_Manual.pdf](doc/RPend_User_Manual.pdf) file.

2. **Execution**:
   - Final version of created and properly identified Reaction Pendulum can be found as [ReactionPendulum_Simulation_Model.slx](main/ReactionPendulum_Simulation_Model.slx) which can be executed using prepared [exp_data_RP.mat](main/exp_data_RP.mat) data.
   - To load the `data.mat` file into MATLAB, use the following command:
   ```matlab
   load('data.mat');

## File Decriptions
### Scripts:
- [free_oscilation.m](main/free_oscilation.m) is a file which generated conditions for free oscilations of real Reaction Pendulum
- [step.m](main/step.m) is a file which generated conditions for step response of real Reaction Pendulum
- [pendulum_friction_coefficient_identification.m](main/pendulum_friction_coefficient_identification.m) calculates friction coefficients and moment of inertia for Pendulum's part of model
- [rotor_friction_coefficient_identification.m](main/rotor_friction_coefficient_identification.m) calculates friction coefficients and moment of inertia for Rotor's part of model.
- [LQR.m](main/LQR.m) is a file which calculated Linear-Quadratic Regulator matrices based on previous experiments

### Data:
- [angle_position_15deg.mat](main/angle_position_15deg.mat) data for deflection of the pendulum experiment (15deg) 
- [angle_position_45deg.mat](main/angle_position_45deg.mat) data for deflection of the pendulum experiment (45deg) 
- [angle_position_90deg.mat](main/angle_position_90deg.mat) data for deflection of the pendulum experiment (90deg) 
- [currwork.mat](main/currwork.mat) saved workspace for LQR calculations
- [enclousure_method_control_negative.mat](main/enclousure_method_control_negative.mat) data for enclousre method to determine the moment of inertia (-)
- [enclousure_method_control_positive.mat](main/enclousure_method_control_positive.mat) data for enclousre method to determine the moment of inertia (+)
- [exp_data_RP.mat](main/exp_data_RP.mat) prepared data for final version of Reaction Pendulum model execution
- [free_oscilation.mat](main/free_oscilation.mat) data saved from executing [free_oscilation.m](main/free_oscilation.m) on Real Pendulum
- [step.mat](main/step.mat) data saved from executing [step.m](main/step.m) on Real Pendulum
- [real_pendulum_data.mat](main/real_pendulum_data.mat) saved data from performed experiment on Real Pendulum (selected parameters)
- [real_pendulum_data_full.mat](main/real_pendulum_data_full.mat) saved data from performed experiment on Real Pendulum (every parameter)
- [rpend_devdriv.mat](main/rpend_devdriv.mat) saved data from performed experiment recommended by the manufacturer on Real Pendulum

### Models:
- [pendulum_test_model.slx](main/pendulum_test_model.slx) initial RP model on which first experiments was conducted
- [pendulum_friction_coefficient_identification_model.slx](main/pendulum_friction_coefficient_identification_model.slx) RP model for pendulum friction coefficients identification
- [rotor_friction_coefficient_identification_model.slx](main/rotor_friction_coefficient_identification_model.slx) RP model for rotor friction coefficients identification
- [linearization_pendulum_model.slx](main/linearization_pendulum_model.slx) RP model for linearization
- [LQR_pendulum_model.slx](main/LQR_pendulum_model.slx) RP model with integrated Linear-Quadratic Regulator
- [ReactionPendulum_Simulation_Model.slx](main/ReactionPendulum_Simulation_Model.slx) final RP model consisting of every models mentioned above

## Results
Results are stored in [ReactionPendulum.pdf](doc/ReactionPendulum.pdf) file.
