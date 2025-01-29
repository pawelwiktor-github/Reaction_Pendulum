# Neural Network as a Friction Coefficient Model

## Table of Contests

1. [General Description](#general-description)
2. [Usage Instructions](#usage-instructions)
3. [File Descriptions](#file-descriptions)
4. [Results](#results)

## General Description
This section is dedicated to the creation and experimental based optimization of Neural Network as a Friction Coefficient Model. This instruction consists of file decsriptions, usage instructions and results.

## Usage Instructions
1. **Prerequisites**:
   - MATLAB 2024b+ or any tool capable of reading (`.m`, `.mat`) files is required. 

2. **Execution**:
   - One version of activation function for NN can be performed at the time.
   - Open simultaneously one version from (`friction_coeff_ReLu.m`, `friction_coeff_sigmoid.m` & `friction_coeff_tanh.m`) for chosing best activation function for your dataset.
   - Once the best activation function is chosen, open `friction_coeff_optimization_algorithm.m` to chose best optimization algorithm from described inside the .m file.
   - Data stored in (`pendulum_swing_45deg_left.mat`, `pendulum_swing_45deg_right.mat`, `pendulum_swing_90deg_left.mat`, `pendulum_swing_90deg_right.mat`) stands for prepared four complete datasets from Reaction Pendulum real object in laboratory which cover almost all of possible behaviour cases for experiments.
   - To load the `data.mat` file into MATLAB, use the following command:
   ```matlab
   load('data.mat');

## File Decriptions
### Scripts:
- [friction_coeff_sigmoid.m](main/friction_coeff_sigmoid.m) is prepared script for testing Sigmoid activation function for Reaction Pendulum mathematical model
- [friction_coeff_tanh.m](main/friction_coeff_tanh.m) is prepared script for testing Hyperbolic Tangent activation function for Reaction Pendulum mathematical model
- [friction_coeff_ReLu.m](main/friction_coeff_ReLu.m) is prepared script for testing Rectified Linear Unit activation function for Reaction Pendulum mathematical model
- [friction_coeff_optimization_algorithm.m](main/friction_coeff_optimization_algorithm.m) is prepared script for testing best optimization algorithm for chosen activation function

Detailed description of activation functions and optimization algorithms is presented in [NNFrictionCoeffModel.pdf](doc/NNFrictionCoeffModel.pdf).

### Data:
- [pendulum_swing_45deg_left.mat](main/pendulum_swing_45deg_left.mat) Reaction Pendulum data for angle deflection by 45 [°] in left direction from equilibrium point
- [pendulum_swing_45deg_right.mat](main/pendulum_swing_45deg_right.mat) Reaction Pendulum data for angle deflection by 45 [°] in right direction from equilibrium point
- [pendulum_swing_90deg_left.mat](main/pendulum_swing_90deg_left.mat) Reaction Pendulum data for angle deflection by 90 [°] in left direction from equilibrium point
- [pendulum_swing_90deg_right.mat](main/pendulum_swing_90deg_right.mat) Reaction Pendulum data for angle deflection by 90 [°] in right direction from equilibrium point

## Results
Results are stored in [NNFrictionCoeffModel.pdf](doc/NNFrictionCoeffModel.pdf) file.