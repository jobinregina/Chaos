clear;clc;close all;
nnet.guis.closeAllViews();
nntraintool close;
inc=0;
% initial definitions
a=0.2;b=0.2;k=1;
%%
for c=0:1:45
 %training series generator
Rossler=@(t,x) [-x(2)-x(3);x(1)+a*x(2);b+x(3)*(x(1)-c)];
options = odeset('RelTol',1e-4,'AbsTol',1e-4);
[t,xa]=ode45(Rossler,[0 10],[0,0.1,0.2],options);
xa1=(xa(:,1))';
xa2=(xa(:,2))';
xa3=(xa(:,3))';
 %%
vx=zeros(1);j1=1;
for k=2:length(xa2)-1
if ((xa2(k-1)<0)&&(xa2(k)>0))||((xa2(k-1)>0)&&(xa2(k)<0))
    vx(1,j1)=xa1(k);
    j1=j1+1;
end
end
plot(c,abs(vx),'r.','MarkerSize',1)
hold on
xlabel('c','FontSize',10);
ylabel('\itx','FontSize',10);
title('NN Lorenz bifurcation plot');
legend('original signal');
%prepare data input and target vector generation
%%
i=1;
if inc==0
    s=i;
end
for i=1:length(xa1)-3
d1(1,s)=xa1(1,i);
d1(2,s)=xa1(1,i+1);
d1(3,s)=xa1(1,i+2);
d1(4,s)=xa2(1,i);
d1(5,s)=xa2(1,i+1);
d1(6,s)=xa2(1,i+2);
d1(7,s)=a;
j=i+3;
t1(1,s)=xa1(1,j);
t1(2,s)=xa2(1,j);
s=s+1;
end
inc=inc+1;
end
%%
%neural network create and algorithm selection and training
net=network;
net.numInputs = 1;
net.numLayers = 2; 
net.biasConnect = [1; 1];
net.inputConnect = [1; 0];
net.layerConnect = [0 1; 1 0];
net.outputConnect = [0 1];
net.layerWeights{1,2}.delays = [1 2];
net.inputs{1}.size = 7;
net.layers{1}.size = 3;
net.layers{1}.transferFcn = 'tansig';
net.layers{1}.initFcn = 'initnw';
net.layers{2}.initFcn = 'initwb';
net.initFcn = 'initlay';
net.performFcn = 'msereg';
net.trainFcn = 'trainlm';
net.divideFcn = 'dividerand';
net.plotFcns = {'plotperform','plottrainstate'};
net = init(net);
net.trainParam.epochs=1000;
net.trainParam.goal=1e-10;
[net, tr] = train(net,d1,t1);
%%
% %Model view and plot generation and testing
view(net);
figure, plotperform(tr)
figure, plottrainstate(tr)
out=net(d1);
out1=out(1,:);
out2=out(2,:);
l=1;
k1=1;
vx1=zeros(1);
% c2=linspace(80,160);
for m=2:length(out2)-1
if ((out2(m-1)<0)&&(out2(m)>0))||((out2(m-1)>0)&&(out2(m)<0))
    vx1(1,k1)=out1(m);
    k1=k1+1;
end
end
figure;plot(abs(vx1),'r.','MarkerSize',1);
% hold off
xlabel('{\rho}','FontSize',10);
ylabel('\itx','FontSize',10);
title('NN Lorenz bifurcation plot');
legend('train signal');