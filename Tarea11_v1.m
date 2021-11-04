clear
clc

%Variables de diseño
%z0(1)=r1
%z0(2)=r2
%z0(3)=r3
%z0(4)=r4
%z0(5)=x0
%z0(6)=y0
%z0(7)=theta1
%z0(8)=u
%z0(9)=v
%z0(10)=theta2.1
%z0(11)=theta2.2
%z0(12)=theta2.3
%z0(13)=theta2.4
%z0(14)=theta2.5
%z0(15)=theta2.6
%z0(16)=theta3.1
%z0(17)=theta3.2
%z0(18)=theta3.3
%z0(19)=theta3.4
%z0(20)=theta3.5
%z0(21)=theta3.6
%z0(22)=theta4.1
%z0(23)=theta4.2
%z0(24)=theta4.3
%z0(25)=theta4.4
%z0(26)=theta4.5
%z0(27)=theta4.6

%Posiciones deseadas
x = [20,20,20,20,20,20];
y = [20,25,30,35,40,45];

%CONDICIÓN DE GRASHOFF: LM+Lm<L2+L3
%Vector de entrada
%Prueba 1, f(z)=0.1621
%z0 = [3,6,9,10,1,1,10,2,3,5,10,15,20,25,30,10,20,30,40,50,60,10,20,30,40,50,60];

% Prueba 2, f(z)= 0.1016
 z0 = zeros(1, 27);

%ESTA B)
%Prueba 3, f(z)=0.0138
%  z0 = [20,25,35,37,1,1,10,2,3,5,10,15,20,25,30,10,20,30,40,50,60,10,20,30,40,50,60];

% for i=10:15
% %Posicion del punto C con respecto al marco de referencia
% cx = z(5)+z(2)*cos(z(i))+z(8)*cos(z(i+6))-z(9)*sin(z(i+6));
% cy = z(6)+z(2)*sin(z(i))+z(8)*sin(z(i+6))-z(9)*cos(z(i+6));
% 
% %Funcion objetivo
% f=@(z) f+(x(i-9)-cx)^2+(y(i-9)-cy)^2;
% end

f = @(z)(x(1)-(z(5)+z(2)*cos(z(10))+z(8)*cos(z(16))-z(9)*sin(z(16))))^2+...
    (y(1)-(z(6)+z(2)*sin(z(10))+z(8)*sin(z(16))+z(9)*cos(z(16))))^2+...
    (x(2)-(z(5)+z(2)*cos(z(11))+z(8)*cos(z(17))-z(9)*sin(z(17))))^2+...
    (y(2)-(z(6)+z(2)*sin(z(11))+z(8)*sin(z(17))+z(9)*cos(z(17))))^2+...
    (x(3)-(z(5)+z(2)*cos(z(12))+z(8)*cos(z(18))-z(9)*sin(z(18))))^2+...
    (y(3)-(z(6)+z(2)*sin(z(12))+z(8)*sin(z(18))+z(9)*cos(z(18))))^2+...
    (x(4)-(z(5)+z(2)*cos(z(13))+z(8)*cos(z(19))-z(9)*sin(z(19))))^2+...
    (y(4)-(z(6)+z(2)*sin(z(13))+z(8)*sin(z(19))+z(9)*cos(z(19))))^2+...
    (x(5)-(z(5)+z(2)*cos(z(14))+z(8)*cos(z(20))-z(9)*sin(z(20))))^2+...
    (y(5)-(z(6)+z(2)*sin(z(14))+z(8)*sin(z(20))+z(9)*cos(z(20))))^2+...
    (x(6)-(z(5)+z(2)*cos(z(15))+z(8)*cos(z(21))-z(9)*sin(z(21))))^2+...
    (y(6)-(z(6)+z(2)*sin(z(15))+z(8)*sin(z(21))+z(9)*cos(z(21))))^2;

%Restricciones lineales
Aeq = [];
beq = [];
A = [];
b = [];

%Rango de valores permitidos
lb = [1 1 1 1 -60 -60 0 -60 -60 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
ub = [60 60 60 60 60 60 360 60 60 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360 360];

%Restricciones no lineales
nonlincon=@nlcon_ext;

% optimize with fmincon
%[X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN]
% = fmincon(fun,z0,A,B,Aeq,Beq,lb,ub,Nonlcon,Options)
options = optimoptions('fmincon');
[z,fval,exit_flag,output,lambda,Grad,Hess] = fmincon(f,z0,A,b,Aeq,beq,lb,ub,nonlincon, options);

disp(['Solución: ']);
z

%num2str(z)
RC=[2*(max(A)+min(A))-(z(1)+z(2)+z(3)+z(4));
    z(10)-z(11);
    z(11)-z(12);
    z(12)-z(13);
    z(13)-z(14);
    z(14)-z(15)];

Rq=[z(2)*cos(z(10))+z(3)*cos(z(16))-z(1)*cos(z(7))-z(4)*cos(z(22));
    z(2)*cos(z(11))+z(3)*cos(z(17))-z(1)*cos(z(7))-z(4)*cos(z(23));
    z(2)*cos(z(12))+z(3)*cos(z(18))-z(1)*cos(z(7))-z(4)*cos(z(24));
    z(2)*cos(z(13))+z(3)*cos(z(19))-z(1)*cos(z(7))-z(4)*cos(z(25));
    z(2)*cos(z(14))+z(3)*cos(z(20))-z(1)*cos(z(7))-z(4)*cos(z(26));
    z(2)*cos(z(15))+z(3)*cos(z(21))-z(1)*cos(z(7))-z(4)*cos(z(27));
    z(2)*sin(z(10))+z(3)*sin(z(16))-z(1)*sin(z(7))-z(4)*sin(z(22));
    z(2)*sin(z(11))+z(3)*sin(z(17))-z(1)*sin(z(7))-z(4)*sin(z(23));
    z(2)*sin(z(12))+z(3)*sin(z(18))-z(1)*sin(z(7))-z(4)*sin(z(24));
    z(2)*sin(z(13))+z(3)*sin(z(19))-z(1)*sin(z(7))-z(4)*sin(z(25));
    z(2)*sin(z(14))+z(3)*sin(z(20))-z(1)*sin(z(7))-z(4)*sin(z(26));
    z(2)*sin(z(15))+z(3)*sin(z(21))-z(1)*sin(z(7))-z(4)*sin(z(27))];
disp(['Función evaluada en z: ' num2str(f(z))]);