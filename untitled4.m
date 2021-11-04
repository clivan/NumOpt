clear
clc
objective = @(x) 2*x(1)^2+2*x(2)^2-2*x(1)*x(2)-4*x(1)-6*x(2); %función Objetivo
%x_k = [5/6,5/6];% punto Inicial
%x_k = [0, 0];% punto Inicial
x_k = [1, 5];% punto Inicial
lb = [];
ub = [];
disp(['Initial Objective: ' num2str(objective(x_k))]) % valor inicial de la función
% restricciones
A=[-1, 0; 0, 1; -1, 0; 0, 1];
%A = [1 1;1 5;-1 0;0 -1];
b=[0; 0; 0; 0]
%b = [2;5;0;0];
Aeq = [];
beq = [];
[x,fval,exit_flag,output,lambda,Grad,Hess] = fmincon(objective,x_k,A,b,Aeq,beq,lb,ub);
%Función Objetivo
disp(['Final Objective: ' num2str(fval)])