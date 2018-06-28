% Program: The Rossler attractor.
clear; clc;
a=0.2;b=0.5;c=5.7;
Rossler=@(t,x) [-x(2)-x(3);x(1)+a*x(2);b+x(3)*(x(1)-c)];
options = odeset('RelTol',1e-4,'AbsTol',1e-4);
[t,xa]=ode45(Rossler,[100 663.5],[0,0.1,0.2],options);
% xa1=(xa(:,1))';
% subplot(3,1,1);
% plot(xa1);
% xlabel('Samples');
% ylabel('y1');
% title('Rossler Attractor y(0) = [0 0.1 0.2]');
% xa2=(xa(:,2))';
% subplot(3,1,2);
% plot(xa2,'g');
% ylabel('y2');
% xlabel('Samples');
% xa3=(xa(:,3))';
% subplot(3,1,3);
% plot(xa3,'r');
% xlabel('Samples');
% ylabel('y3');
figure;
plot3(xa(:,1),xa(:,2),xa(:,3),'.-r');grid on;
title('The Rossler Attractor')
xlabel('x(t)','Fontsize',10);
ylabel('y(t)','Fontsize',10);
zlabel('z(t)','FontSize',10);