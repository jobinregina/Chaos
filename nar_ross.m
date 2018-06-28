% Solve an Autoregression Time-Series Problem with a NAR Neural Network

clear;clc;close all;
nnet.guis.closeAllViews();
nntraintool close;
%   t1 - feedback time series.
load('t1');
T = tonndata(t1,true,false);

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

% Create a Nonlinear Autoregressive Network
feedbackDelays = 1;
hiddenLayerSize = 14;
net = narnet(feedbackDelays,hiddenLayerSize,'open',trainFcn);

% Choose Feedback Pre/Post-Processing Functions
% Settings for feedback input are automatically applied to feedback output
% For a list of all processing functions type: help nnprocess
net.input.processFcns = {'removeconstantrows','mapminmax'};

% Prepare the Data for Training and Simulation
% The function PREPARETS prepares timeseries data for a particular network,
% shifting time by the minimum amount to fill input states and layer
% states. Using PREPARETS allows you to keep your original time series data
% unchanged, while easily customizing it for networks with differing
% numbers of delays, with open loop or closed loop feedback modes.
[x,xi,ai,t] = preparets(net,{},{},T);

% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivide
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'time';  % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = 'mse';  % Mean Squared Error

% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate', 'ploterrhist', ...
    'plotregression', 'plotresponse', 'ploterrcorr', 'plotinerrcorr'};

% Train the Network
net.trainParam.epochs=1000;
net.trainParam.goal=1e-10;
[net,tr] = train(net,x,t,xi,ai);

% Test the Network
% y = net(x,xi,ai);
% e = gsubtract(t,y);
% performance = perform(net,t,y)

% Recalculate Training, Validation and Test Performance
% trainTargets = gmultiply(t,tr.trainMask);
% valTargets = gmultiply(t,tr.valMask);
% testTargets = gmultiply(t,tr.testMask);
% trainPerformance = perform(net,trainTargets,y)
% valPerformance = perform(net,valTargets,y)
% testPerformance = perform(net,testTargets,y)

% View the Network
% view(net)

% Plots
% Uncomment these lines to enable various plots.
figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotregression(t,y)
%figure, plotresponse(t,y)
%figure, ploterrcorr(e)
%figure, plotinerrcorr(x,e)

% Closed Loop Network
% Use this network to do multi-step prediction.
% The function CLOSELOOP replaces the feedback input with a direct
% connection from the outout layer.
% netc = closeloop(net);
% netc.name = [net.name ' - Closed Loop'];
% view(netc)
% [xc,xic,aic,tc] = preparets(netc,{},{},T);
% yc = netc(xc,xic,aic);
% closedLoopPerformance = perform(net,tc,yc)

% Multi-step Prediction
% Sometimes it is useful to simulate a network in open-loop form for as
% long as there is known data T, and then switch to closed-loop to perform
% multistep prediction. Here The open-loop network is simulated on the
% known output series, then the network and its final delay states are
% converted to closed-loop form to produce predictions for 5 more
% timesteps.
% [x1,xio,aio,t] = preparets(net,{},{},T);
% [y1,xfo,afo] = net(x1,xio,aio);
% [netc,xic,aic] = closeloop(net,xfo,afo);
% [y2,xfc,afc] = netc(cell(0,5),xic,aic);
% Further predictions can be made by continuing simulation starting with
% the final input and layer delay states, xfc and afc.

% Step-Ahead Prediction Network
% For some applications it helps to get the prediction a timestep early.
% The original network returns predicted y(t+1) at the same time it is
% given y(t+1). For some applications such as decision making, it would
% help to have predicted y(t+1) once y(t) is available, but before the
% actual y(t+1) occurs. The network can be made to return its output a
% timestep early by removing one delay so that its minimal tap delay is now
% 0 instead of 1. The new network returns the same outputs as the original
% network, but outputs are shifted left one timestep.
% nets = removedelay(net);
% nets.name = [net.name ' - Predict One Step Ahead'];
% view(nets)
% [xs,xis,ais,ts] = preparets(nets,{},{},T);
% ys = nets(xs,xis,ais);
% stepAheadPerformance = perform(nets,ts,ys)

% Deployment
% Change the (false) values to (true) to enable the following code blocks.
% See the help for each generation function for more information.
% if (false)
    % Generate MATLAB function for neural network for application
    % deployment in MATLAB scripts or with MATLAB Compiler and Builder
    % tools, or simply to examine the calculations your trained neural
    % network performs.
%     genFunction(net,'myNeuralNetworkFunction');
%     y = myNeuralNetworkFunction(x,xi,ai);
% end
% if (false)
    % Generate a matrix-only MATLAB function for neural network code
    % generation with MATLAB Coder tools.
%     genFunction(net,'myNeuralNetworkFunction','MatrixOnly','yes');
%     x1 = cell2mat(x(1,:));
%     xi1 = cell2mat(xi(1,:));
%     y = myNeuralNetworkFunction(x1,xi1);
% end
% if (false)
    % Generate a Simulink diagram for simulation or deployment with.
    % Simulink Coder tools.
%     gensim(net);
% end
