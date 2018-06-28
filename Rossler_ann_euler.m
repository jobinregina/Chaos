% Created 08-Aug-2017 16:38:44
%%
clear;clc;close all;
nnet.guis.closeAllViews();
nntraintool close;
inc=0;
% initial definitions
%  Solve an Autoregression Problem with External Input with a NARX Neural Network
% Script generated by Neural Time Series app
% Created 08-Aug-2017 16:38:44
%
% clear;clc;close all;
% nnet.guis.closeAllViews();
% nntraintool close;
% inc=0;
x=0.1; y=0.1; z=0.1;
dt=0.01; num=20000;

for i = 1:num
    time_series(:, i) = [x;y;z];
    [x,y,z] = next_rossler(x, y, z, dt);
end
xa1=time_series(1,1:num/2);
xa2=time_series(2,1:num/2);
xa3=time_series(3,1:num/2);
% plot3(xa1,xa2,xa3);
%%
d1 = time_series(:, 1:num/2-1);
t1 = time_series(:, 2:num/2);
%%
%neural network create and algorithm selection and training
net=network;
net.numInputs = 1;
net.numLayers = 2; 
net.biasConnect = [1; 1];
net.inputConnect = [1; 0];
net.layerConnect = [0 0; 1 0];
net.outputConnect = [0 1];
net.layers{1}.size = 8;
net.layers{1}.transferFcn = 'tansig';
net.layers{1}.initFcn = 'initnw';
net.layers{2}.size = 3;
net.layers{2}.initFcn = 'initnw';
net.initFcn = 'initlay';
net.performFcn = 'msereg';
net.trainFcn = 'trainlm';
net.divideFcn = 'divideblock';
net.plotFcns = {'plotperform','plottrainstate'};
net = init(net);
net.trainParam.epochs=1000;
net.trainParam.goal=1e-10;
[net, tr] = train(net,d1,t1);
figure, plotperform(tr)
%%
 %Model view and plot generation and testing
% view(net);
xb1=time_series(1,num/2+1:num);
xb2=time_series(2,num/2+1:num);
xb3=time_series(3,num/2+1:num);
% plot3(xb1,xb2,xb3);
%%
d2 = time_series(:, num/2+1:num-1);
% t2 = time_series(:, 2:5000);
out=net(d2);
out1=out(1,:);
out2=out(2,:);
out3=out(3,:);
figure;
plot3(out1,out2,out3);
hold on
plot3(xb1,xb2,xb3);
xlabel('x(t)','FontSize',10);
ylabel('y(t)','FontSize',10);
zlabel('z(t)','FontSize',10);
% title(['Rossler attractor at a = ' num2str(a) ',b = ' num2str(b) ',c = ' num2str(c); ''])