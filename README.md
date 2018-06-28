# Predition and modelling of chaotic systems

Hi everybody my name is Jobin Sunny, I’m from the University of Regina. This project aims at longterm precition and modelling of nonlinear dynamic systems showing chaotic spectrum using Artificial Neural Networks. In this work I'll explain a little about the background and motivation of my study first, previous studies done in this field, purpose of my research then we see some of the methodologies I have applied on the data and the results obtained. In addition, a consequence study and discussion of the results as a part of evaluation.

## Background of the study
![EEG](https://raw.githubusercontent.com/jobinregina/Chaos/master/joan.png)
***Image2:*** *Open BCI based EEG collecting equipment mounted on a person during experiment and representational diagram of EEG signals*

Let me start with a question? How many of you have seen your EEG signals? Only a few I guess and I really hope you never need to check your EEG at a hospital. I have seen mine, its quite an interesting signal. The picture you are seeing above is one of the EEG recording sessions conducted at our lab. We have setup our own EEG acquisition machine based on OpenBCI. The picture on right side demonstrate how an EEG signal looks like. EEG signals are included in the class of nonlinear dynamic signals. I’ll explain about that term later let’s see some neural diseases, Alzheimer’s, epilepsy and Parkinson’s are some neurodegenerative diseases that affect a lot of people. As the technology has advanced a lot of new ways to detect these diseases has discovered. Measuring EEG is a preferred method to diagnose many neural disorders. Recent studies has proposed that the brain state of a normal person is at the brink of chaos or more clearly in the mathematical sense brain state is more similar to the bifurcation of a complex chaotic system. And research works published on the above mentioned neural diseases proved that there is a notable change in the brain state. Our project goal is to build a wearable device, a small one like a pacemaker which can alter the brain signal patterns. It can be either invasive or non-invasive we haven’t gone that far to in our research yet. Chaotic systems are the closest type of nonlinear dynamic signals we can simulate for EEG signals. Hence our first step is to build a system that can model EEG signals, a simulator where we can test our functionalities. Hence as a trial study we design an Artificial Neural Network based system that can model any natural system given its inputs and outputs and use it to model Rossler’s and Chua’s chaotic system.

## Literature review
In this section we will see some of the recent literatures that have done similar studies:

_1. Jesse Schmitz, Lei Zhang, Rossler based Chaotic communication system implemented on FPGA :30th Canadian Conference on Electrical and Computer Engineering (CCECE),IEEE. 2017_

**Conventional equation based modelling techniques are efficient but not suitable for empirical systems.**

_2. M. Alcin, I. Pehlivan, and smail Koyuncu, “Hardware design and implementation of a novel ann-based chaotic generator in fpga,” Optik - International Journal for Light and Electron Optics, vol. 127, no. 13, pp. 5500 – 5505, 2016._

**For FPGA implementation of ANN 6 bit precision is sufficient**

_3. Archana R, A. Unnikrishnan R. Gopikakumari, M.V Rajesh, An Intelligent Computational Algorithm based on Neural Networks for the Identification of Chaotic systems :Recent Advances in Intelligent Computational Systems (RAICS),IEEE. 2011._

**Larger number of hidden layer neurons are used.**
**No performance evaluation of modelling ANN is done.**

_4. Lei Zhang, Artificial Neural Network Model Design and Topology Analysis for FPGA Implementation of Lorenz Chaotic Generator :30th Canadian Conference on Electrical and Computer Engineering(CCECE),IEEE. 2017._

**Study done without considering consequences.**
**Deep Neural Network used for modelling.**

_5. Razieh Falahian,Maryam Mehdizadeh Dastjerdi,et.al, Artificial neural network-based modeling of brain response to flicker light :Nonlinear Dyn,IEEE. 2015._ 

**Bifurcation study not done.**
**Open loop modelling technique.**

## Purpose of this work
1. A comprehensive study on prediction and modelling using (1) Feedforward Neural Networks  (2) Feedback Neural networks.
2. How well the validation performance improves with increase in the number of hidden layer neurons?
3. Which algorithm suites best for modelling complex nonlinear time series?
4. Does the results hold for other dynamic systems?
5. How well the modelled system performs in areas of timing and outputs?

## Methodology

Entire coding is done in MATLAB Neural Network Toolbox is used. MATLAb is wrapped version of Caffe.2 types of Neural Networks in FFNN (i) MLP (ii) RBFN and 2 types of feedback Neural Networks (i) TDNN (ii) RNN. Single hidden layer is deployed for all the Neural Networks. Training/Testing and Validation ratio used is 70:15:15. Loss function used is MSE and performance goals are calculated based on previous studies. Three dimensions of chaotic system are used for training & windowing method is used to generate training samples.

## MLP vs RBFN modelling

First 10k training samples are ignored in order to remove any transient noise. Hyperbolic tangent sigmoid and linear linear activation are used for hidden and output layer of MLP respectively. Gaussian activation function is used in the funtional layer of Radial Basis Function Network. Each experiment run for 1000 epochs and multiple trials to avoid gradient hitting local minima with 6 validation stops. RBFN MSE is calculated for different values of spread & value with minimum MSE chosen.

## Results FFNN
For all architectures the testing performance improves as the hidden layer neurons increase.
MSE comparison between MLP and RBFN is done at 2.00E-06. MLP took 5 neurons while RBFN took 20 neurons to reach same performance.
Out of the three algorithm tested LM algorithm is found as the best algorithm: (i) rate of convergence (ii) training time.
Testing performance doesn't improve a lot after 8 hidden neurons. Chua’s system results followed Rossler’s. FFNN MSE3E-04.

## Results FBNN
Time delayed Neural Network  The Nonlinear Auto-Regressive(NAR) for generating an iterative model.
Dynamic Recurrent Neural Network Nonlinear Auto-Regressive with Exogenous Inputs (NARX).
Single input to the NARX is the bifurcation parameter of Rossler’s map.
Input delay and target delay are experimentally calculated as 1 time step.

## Evaluation study




