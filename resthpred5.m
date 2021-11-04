function [c,ceq] = resthpred5(x)
global x1 x2 k
c=[];
h=1e-3;
m=1;
b=0.02;
l=0.5;
g=9.81;
ceq=[x(1)-x1(k)-h*x2(k);
     x(2)-x(1)-h*x(6);
     x(3)-x(2)-h*x(7);
     x(4)-x(3)-h*x(8);
     x(5)-x(4)-h*x(9);
     x(6)-x2(k)-h*(-m*g*l*sin(x1(k))-b*x2(k)+x(11))/(m*l^2);
     x(7)-x(6)-h*(-m*g*l*sin(x(1))-b*x(6)+x(12))/(m*l^2);
     x(8)-x(7)-h*(-m*g*l*sin(x(2))-b*x(7)+x(13))/(m*l^2);
     x(9)-x(8)-h*(-m*g*l*sin(x(3))-b*x(8)+x(14))/(m*l^2);
     x(10)-x(9)-h*(-m*g*l*sin(x(4))-b*x(9)+x(15))/(m*l^2)];