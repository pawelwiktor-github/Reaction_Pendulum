# NARX Neural Network as a pendulum velocity observer

## Table of Contests

1. [General Description](#general-description)
2. [Usage Instructions](#usage-instructions)
3. [File Descriptions](#file-descriptions)
4. [Results](#results)

## General Description
This section is dedicated to the creation and iterative tuning of the NARX Neural Network. This instruction consists of file decsriptions, usage instructions and results.

## Usage Instructions
1. **Prerequisites**:
   - MATLAB 2024b+ or any tool capable of reading (`.m`, `.mat`, `.slx`) files is required. Additionaly Simulink and DeepLearningToolbox extensions are obligatory

2. **Execution**:
   - One NARX NN version can be performed at the time
   - Open `Training_NARX.m` to create and train NARX Neural Network
   - Open `simulation.m` to create dataset (data is downloaded from `ReactionPendulum_Simulation_Model.slx`)
   - Open `NARX_observer.m` to validate the data on created and trained NARX Neural Network version
   - To load the `data.mat` file into MATLAB, use the following command:
   ```matlab
   load('data.mat');

## File Decriptions
### Scripts:
- [Training_NARX.m](main/Training_NARX.m) create and train NARX NN
- [simulation.m](main/simulation.m) data aquisition from model [ReactionPendulum_Simulation_Model.slx](main/ReactionPendulum_Simulation_Model.slx)
- [NARX_observer.m](main/NARX_observer.m) validation of NARX NN

### Data:
#### Model execution data:
- [exp_data_RP.mat](main/exp_data_RP.mat) is data which is required to supplement all model elements of Reaction Pendulum
- [fisMam.mat](main/fisMam.mat) is data with created Fuzzy Logic Controller 
#### Training data for NN:
- [data_positive_max_swing.mat](main/data_positive_max_swing.mat) single pendulum swing of angular position equal to 30 [◦] (maximum)
- [data_2_max_swings.mat](main/data_2_max_swings.mat) double pendulum swing of angular position equal to −30 [◦] and 30 [◦]
- [data_complex.mat](main/data_complex.mat) multiple pendulum swing of angular position equal from −30 [◦] to 30 [◦] omitting 0 [◦]
#### Validation data for NN:
- [data_single_30deg.mat](main/data_single_30deg.mat) single pendulum swing of angular position equal to 30 [◦]
- [data_double_-25deg_25deg.mat](main/data_double_-25deg_25deg.mat) double pendulum swing of angular position equal to −25 [◦] and 25 [◦] diffed by 20 [s]
- [data_double_15deg_20deg.mat](main/data_double_15deg_20deg.mat) double pendulum swing of angular position equal to 15 [◦] and 25 [◦] diffed by 20 [s]
- [data_triple_-5deg_15deg_-25deg.mat](main/data_triple_-5deg_15deg_-25deg.mat) triple pendulum swing of angular position equal to −5 [◦], 15 [◦] and −25 [◦] diffed by 20 [s]
#### Trained net data:
- [trained_net_1.mat](main/trained_net_1.mat) first version of trained network
- [trained_net_2.mat](main/trained_net_2.mat) second version of trained network
- [trained_net_3.mat](main/trained_net_3.mat) third version of trained network
- [trained_net_4.mat](main/trained_net_4.mat) fourth version of trained network
- [trained_net_5.mat](main/trained_net_5.mat) fifth version of trained network
- [trained_net_6.mat](main/trained_net_6.mat) sixth version of trained network

### Model:
- [ReactionPendulum_Simulation_Model.slx](main/ReactionPendulum_Simulation_Model.slx) is a prepared simulink model which generates simulation and results into workspace.

## Results
Results are stored in [NARXVelocityObserver.pdf](doc/NARXVelocityObserver.pdf) file.