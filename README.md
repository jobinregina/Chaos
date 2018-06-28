# Nonlinear dynamic systems

Dynamic systems are systems whose state varies over time, such systems obey one dimensional differential equations including time derivatives. If they exhibit nonlinear nature they are called nonlinear differential equations. Nonlinear systems display wide variety of dynamics including magnificent chaotic state. There are a lot of natural systems which shows chaotic dynamics around us. In the mechanical field we have the double pendulum, medical field we have EEG signals and if we look into the environment we have weather patterns, or solar system. Chaotic systems are defined maintain extreme sensitivity to initial conditions, deterministic in nature means there is no noise involved in the production of chaotic data, but long-term prediction is impossible. Finally, they have fractal dimensions and display fractal nature. Since we only know the input and output data, the best tool available for modelling is the Artificial Neural Network based on the training time and flexibility in training.

![](https://raw.githubusercontent.com/jobinregina/Chaos/master/Ross.jpg)

***Image1:*** *Complex chaotic attractor of Rossler's dynamic system*

![](https://raw.githubusercontent.com/jobinregina/Chaos/Data/ross_1d.png)

***Image1:*** *1D time series of Rossler's dynamic system*

![](https://raw.githubusercontent.com/jobinregina/Chaos/Data/chu.png)

***Image1:*** *Complex chaotic attractor of Chua's dynamic system*

![](https://raw.githubusercontent.com/jobinregina/Chaos/Data/chu_1d.png)

***Image1:*** *1D time series of Chua's dynamic system*

## Data generate and Preprocessing
Rossler's and Chua's time series are generated using ODE45 integration method. Three dimensions of chaotic systems are 
used for both input & target vector during ANN training. From a single dimensional time series x, input vector is created
as the one step delayed time series while target vector is the one step ahead time series. This is achieved by windowing
method where consecutive values of time series are assigned one value as input and another as target. To avoid improper 
starting point off the trajectory the first 10000 samples are discarded. 
