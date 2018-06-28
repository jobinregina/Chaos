# Importance of modelling chaotic systems
Hi everybody my name is Jobin Sunny, I’m from the University of Regina. This project aims at longterm precition and modelling of nonlinear dynamic systems showing chaotic spectrum using Artificial Neural Networks. In this work I'll explain a little about the background and motivation of my study first, previous studies done in this field, purpose of my research then we see some of the methodologies I have applied on the data and the results obtained. In addition, a consequence study and discussion of the results as a part of evaluation.

![alt text](https://raw.githubusercontent.com/username/projectname/branch/path/to/img.png)

## Background of the study
Let me start with a question? How many of you have seen your EEG signals? Only a few I guess and I really hope you never need to check your EEG at a hospital. I have seen mine, its quite an interesting signal. The picture you are seeing above is one of the EEG recording sessions conducted at our lab. We have setup our own EEG acquisition machine based on OpenBCI. The picture on right side demonstrate how an EEG signal looks like. EEG signals are included in the class of nonlinear dynamic signals. I’ll explain about that term later let’s see some neural diseases, Alzheimer’s, epilepsy and Parkinson’s are some neurodegenerative diseases that affect a lot of people. As the technology has advanced a lot of new ways to detect these diseases has discovered. Measuring EEG is a preferred method to diagnose many neural disorders. Recent studies has proposed that the brain state of a normal person is at the brink of chaos or more clearly in the mathematical sense brain state is more similar to the bifurcation of a complex chaotic system. And research works published on the above mentioned neural diseases proved that there is a notable change in the brain state. Our project goal is to build a wearable device, a small one like a pacemaker which can alter the brain signal patterns. It can be either invasive or non-invasive we haven’t gone that far to in our research yet. Chaotic systems are the closest type of nonlinear dynamic signals we can simulate for EEG signals. Hence our first step is to build a system that can model EEG signals, a simulator where we can test our functionalities. Hence as a trial study we design an Artificial Neural Network based system that can model any natural system given its inputs and outputs and use it to model Rossler’s and Chua’s chaotic system.
## Literature review
1. Conventional equation based modelling techniques are efficient but not suitable for natural systems.
2. For FPGA implementation of ANN 6 bit precision is sufficient
3. Larger number of hidden layer neurons are used.
4. No performance evaluation of modelling ANN is done.
5. Deep Neural Network used for modelling.
6. Study done without considering consequences.
7. Bifurcation study not done
8. Open loop modelling technique

