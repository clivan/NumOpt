function [c,ceq] = resthpred1(x)
global x1 x2 k
c=[];
h=1e-3;
m=1;
b=0.02;
l=0.5;
g=9.81;
ceq=[x(1)-x1(k)-h*x2(k);
     x(2)-x2(k)-h*(-m*g*l*sin(x1(k))-b*x2(k)+x(3))/(m*l^2)];