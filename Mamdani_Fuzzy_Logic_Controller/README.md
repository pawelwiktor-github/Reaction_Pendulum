# Mamdani Fuzzy Logic Controller

## Table of Contests

1. [General Description](#general-description)
2. [Usage Instructions](#usage-instructions)
3. [File Descriptions](#file-descriptions)
4. [Results](#results)

## General Description
This section is dedicated to the creation and iterative tuning of the MISO Mamdani-Type Fuzzy Logic Controller. This instruction consists of file decsriptions, usage instructions and results.

## Usage Instructions
1. **Prerequisites**:
   - MATLAB 2024b+ or any tool capable of reading (`.m`, `.mat`, `.slx`) files is required. Additionaly Simulink and FuzzyLogicDesigner extensions are obligatory.

2. **Execution**:
   - One Fuzzy Creation version can be performed at the time.
   - Open simultaneously one version from (`PendulumControl_Mamdani_ver1.m`, `PendulumControl_Mamdani_ver2.m` & `PendulumControl_Mamdani_ver3.m`) and `ReactionPendulum_Simulation_Model.slx` which generates results.
   - Data stored in (`firstFuzzy.mat`, `secondFuzzy.mat` & `thirdFuzzy.mat`) stands for simulation of previously mentioned versions of Fuzzy. It can be loaded and used for printing results.
   - To load the `data.mat` file into MATLAB, use the following command:
   ```matlab
   load('data.mat');

## File Decriptions
Files (`PendulumControl_Mamdani_ver1.m`, `PendulumControl_Mamdani_ver2.m` & `PendulumControl_Mamdani_ver3.m`) are main executive. It will create three versions of Fuzzy Logic Controller with data aquisition from simulink model as well as visualizations.

File `ReactionPendulum_Simulation_Model.slx` is a prepared simulink model which generates simulation and results into workspace.

Data `exp_data_RP.mat` is data which is required to supplement all model elements of Reaction Pendulum.

Data (`firstFuzzy.mat`, `secondFuzzy.mat` & `thirdFuzzy.mat`) are saved executions of every created version of Fuzzy.

Data (`repeating_sequence_02.mat`, `repeating_sequence_02_length15mm.mat` & `repeating_sequence_02_dcvel100.mat`) are saved disturbance conditions that the latest version of Fuzzy was tested on.

## Results
Results are stored in [MamdaniFuzzyLogic_for_ReactionPendulum.pdf](doc/MamdaniFuzzyLogic_for_ReactionPendulum.pdf) file.