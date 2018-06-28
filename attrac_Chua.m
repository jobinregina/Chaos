% Program: The Chua's attractor.
close all;clear;clc;
alpha = 15.6; beta = 25.87;
a = -8/7; b = -5/7; c = 1;
fsize=15;
Chua=@(t,x) [alpha*(x(2)-x(1)-(b*x(1)+(1/2)*(a-b)*(abs(x(1)+c)-abs(x(1)-c))));x(1)-x(2)+x(3);-beta* x(2)];
options = odeset('RelTol',1e-4,'AbsTol',1e-4);
[t,xa]=ode45(Chua,[0 317.2],[0.7 0 0],options);
plot3(xa(:,1),xa(:,2),xa(:,3),'r.');grid on;
title('The Chua Attractor')
xlabel('x(t)','Fontsize',fsize);
ylabel('y(t)','Fontsize',fsize);
zlabel('z(t)','FontSize',fsize);
% subplot(3,1,1);
% plot(xa(:,1));
% xlabel('samples');
% ylabel('y1');
% title('Chua attractor y0) = [0.7 0 0]');
% subplot(3,1,2);
% plot(xa(:,2),'.r');
% xlabel('samples');
% ylabel('y2');
% subplot(3,1,3);
% plot(xa(:,3),'.g');
% xlabel('samples');
% ylabel('y3');