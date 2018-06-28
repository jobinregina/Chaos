% Programs 14a: The Lorenz attractor.
close all;clear;clc;
sigma=10;r=28;b=8/3;
Lorenz=@(t,x) [sigma*(x(2)-x(1));r*x(1)-x(2)-x(1)*x(3);x(1)*x(2)-b*x(3)];
options = odeset('RelTol',1e-4,'AbsTol',1e-4);
[t,xa]=ode45(Lorenz,[0 50],[15,20,30],options);
figure;
plot3(xa(:,1),xa(:,2),xa(:,3),'r.-')
title('The Lorenz Attractor')
xlabel('x(t)');
ylabel('y(t)');
zlabel('z(t)');