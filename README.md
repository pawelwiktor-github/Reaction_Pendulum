# Reaction Pendulum Repository

## Table of Contests

1. [Introduction](#introduction)
2. [Usage Instructions](#usage-instructions)
3. [Section Descriptions](#section-descriptions)

## Introduction
This repository refers to the research carried out for Reaction Pendulum laboratory test bench. If you are in possession of the Reaction Pendulum test bench you can perform  experiments by your self (guide of which experiments are recommended is in [documentation](/ReactionPendulumIdentification/doc/ReactionPendulum.pdf)). If not, you can go straight to sections dedicated after identification process and execute further experiments on created simulation model.
Additional informations of Reaction Pendulum test bench are stored in [User Manual Instruction](/ReactionPendulumIdentification/doc/RPend_User_Manual.pdf) file.

![ReactionPendulum](/ReactionPendulumIdentification/screenshots/reaction_pendulum.png)

## Usage Instructions
1. **Prerequisites**:
   - MATLAB 2024b+ or any tool capable of reading (`.m`, `.mat`, `.slx`) files is required. Additional needed extensions are mentioned in README of every section.
   - If you are using tool which cannot operate on Simulink models, you can directly simulate the model from .m file using following command:
    ```matlab
   sim('simulink_model_name');
Every configuration parameter should be described in documentations or set as constant value inside the models.

## Section Decriptions

Repository consists of five different sections. 

Section [Reaction Pendulum Idenficitaion](/ReactionPendulumIdentification/) refers to the identification process of mentioned above Reaction Pendulum. Identification should be understood as creating simulation model based on calculations of friction coefficients, moments of inertia and another forces included in motion of an object with four state variables. Final product is a properly working [Simulink model](/ReactionPendulumIdentification/main/ReactionPendulum_Simulation_Model.slx) on which further experiments can be conducted.

Sections [Mamdani Fuzzy Logic Controller](/Mamdani_Fuzzy_Logic_Controller/), [Takagi-Sugeno Fuzzy Logic Controller](/Takagi-Sugeno_Fuzzy_Logic_Controller/), [NARX_Velocity_Observer](/NARX_Velocity_Observer/) and [NN Friction Coeff Model](/NN_Friction_Coeff_Model/) should be understood as Multi Method Innovative Approach to Reaction Pendulum Control. Further describtions are stored in [MamdaniFuzzyLogic_for_ReactionPendulum](/Mamdani_Fuzzy_Logic_Controller/doc/MamdaniFuzzyLogic_for_ReactionPendulum.pdf),  [TakagiSugenoFuzzyLogic_for_ReactionPendulum](/Takagi-Sugeno_Fuzzy_Logic_Controller/doc/TakagiSugenoFuzzyLogic_for_ReactionPendulum.pdf), [NARXVelocityObserver](/NARX_Velocity_Observer/doc/NARXVelocityObserver.pdf), [NNFrictionCoeffModel](/NN_Friction_Coeff_Model/doc/NNFrictionCoeffModel.pdf) documentations as well as usage instructions and file descriptions explained in README of every section.
