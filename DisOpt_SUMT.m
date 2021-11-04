%Problema de diesño para un mecanismo de cuatro barras usando SUMT
clear
clc

%Posiciones deseadas
x = [20,20,20,20,20,20];
y = [20,25,30,35,40,45];

%Variables de diseño
%[z0(1), z0(2), z0(3), z0(4), z0(5), z0(6), z0(7), z0(8), z0(9), z0(10),
%z0(11), z0(12), z0(13), z0(14), z0(15), z0(16), z0(17), z0(18), z0(19),
%z0(20), z0(21), z0(22), z0(23), z0(24), z0(25), z0(26), z0(27)]=[r1, r2,
%r3, r4, x0, y0, theta1, u, v, theta2.1, theta2.2, theta2.2, theta2.3,
%theta2.4, theta2.5, theta2.6, theta3.1, theta3.2, theta3.3, theta3.4,
%theta3.4, theta3.6, theta4.1, theta4.2, theta4.3, theta4.4, theta4.5,
%theta4.6]

%CONDICIÓN DE GRASHOFF: LM+Lm<L1+L2
%Vector de entrada
%Prueba 1: z0 =[3, 6, 9, 10, 1, 1, 10, 2, 3, 5, 10, 15, 20, 25, 30, 10, 20, 30, 40, 50, 60, 10, 20, 30, 40, 50, 60];
%Prueba 2: z0=zeros(1, 27);

%Final
z0=[7.2, 24.24, 54.36, 30.48, -3, 24.72, 36.84, 2.16, 13.08, 12.12, 6.24, 18.36, 36.48, 60.6, 90.72, 18.84, 42.9, 79.08, 127.2, 186.12, 258.24, 12.36, 36.48, 60.6, 84.6, 108.72, 132.84];

%Restricciones lineales
%Aeq = [];
%beq = [];
%A = [];
%b = [];
%Límites
lb=[1, 1, 1, 1, -60, -60, 0, -60, -60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
ub=[60, 60, 60, 60, 60, 60, 360, 60, 60, 360, 360, 360, 360, 360, 360, 360, 360, 360, 360, 360, 360, 360, 360, 360, 360, 360, 360];

%% Parámetros del problema
k=0;
e=1e-6; %ε esperado
beta=0.9;
gama=50;
er=true;

alpha=max(0,2*(max([z0(1) z0(2) z0(3) z0(4)])+min([z0(1) z0(2) z0(3) z0(4)]))-(z0(1)+z0(2)+z0(3)+z0(4)))^2....
    +max(0,z0(10)-z0(11))^2 +max(0,z0(11)-z0(12))^2 +max(0,z0(12)-z0(13))^2 +max(0,z0(13)-z0(14))^2 +max(0,z0(14)-z0(15))^2 ....
    +(z0(2)*cos(z0(10))+z0(3)*cos(z0(16))-z0(1)*cos(z0(7))-z0(4)*cos(z0(22)))^2 +(z0(2)*cos(z0(11))+z0(3)*cos(z0(17))-z0(1)*cos(z0(7))-z0(4)*cos(z0(23)))^2....
    +(z0(2)*cos(z0(12))+z0(3)*cos(z0(18))-z0(1)*cos(z0(7))-z0(4)*cos(z0(24)))^2 +(z0(2)*cos(z0(13))+z0(3)*cos(z0(19))-z0(1)*cos(z0(7))-z0(4)*cos(z0(25)))^2....
    +(z0(2)*cos(z0(14))+z0(3)*cos(z0(20))-z0(1)*cos(z0(7))-z0(4)*cos(z0(26)))^2 +(z0(2)*cos(z0(15))+z0(3)*cos(z0(21))-z0(1)*cos(z0(7))-z0(4)*cos(z0(27)))^2....
    +(z0(2)*sin(z0(10))+z0(3)*sin(z0(16))-z0(1)*sin(z0(7))-z0(4)*sin(z0(22)))^2 +(z0(2)*sin(z0(11))+z0(3)*sin(z0(17))-z0(1)*sin(z0(7))-z0(4)*sin(z0(23)))^2....
    +(z0(2)*sin(z0(12))+z0(3)*sin(z0(18))-z0(1)*sin(z0(7))-z0(4)*sin(z0(24)))^2 +(z0(2)*sin(z0(13))+z0(3)*sin(z0(19))-z0(1)*sin(z0(7))-z0(4)*sin(z0(25)))^2....
    +(z0(2)*sin(z0(14))+z0(3)*sin(z0(20))-z0(1)*sin(z0(7))-z0(4)*sin(z0(26)))^2 +(z0(2)*sin(z0(15))+z0(3)*sin(z0(21))-z0(1)*sin(z0(7))-z0(4)*sin(z0(27)))^2;

%% Método de SUMT
while gama*alpha>e
    %b=rest(z, lb, ub, Rc, Rq);
    f=@(z)(x(1)-(z(5)+z(2)*cos(z(10))+z(8)*cos(z(16))-z(9)*sin(z(16))))^2+...
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
    (y(6)-(z(6)+z(2)*sin(z(15))+z(8)*sin(z(21))+z(9)*cos(z(21))))^2+...
    gama*...
    (max(0,2*(max([z(1) z(2) z(3) z(4)])+min([z(1) z(2) z(3) z(4)]))-(z(1)+z(2)+z(3)+z(4)))^2....
        +max(0,z(10)-z(11))^2 +max(0,z(11)-z(12))^2 +max(0,z(12)-z(13))^2 +max(0,z(13)-z(14))^2 +max(0,z(14)-z(15))^2 ....
        +(z(2)*cos(z(10))+z(3)*cos(z(16))-z(1)*cos(z(7))-z(4)*cos(z(22)))^2 +(z(2)*cos(z(11))+z(3)*cos(z(17))-z(1)*cos(z(7))-z(4)*cos(z(23)))^2....
        +(z(2)*cos(z(12))+z(3)*cos(z(18))-z(1)*cos(z(7))-z(4)*cos(z(24)))^2 +(z(2)*cos(z(13))+z(3)*cos(z(19))-z(1)*cos(z(7))-z(4)*cos(z(25)))^2....
        +(z(2)*cos(z(14))+z(3)*cos(z(20))-z(1)*cos(z(7))-z(4)*cos(z(26)))^2 +(z(2)*cos(z(15))+z(3)*cos(z(21))-z(1)*cos(z(7))-z(4)*cos(z(27)))^2....
        +(z(2)*sin(z(10))+z(3)*sin(z(16))-z(1)*sin(z(7))-z(4)*sin(z(22)))^2 +(z(2)*sin(z(11))+z(3)*sin(z(17))-z(1)*sin(z(7))-z(4)*sin(z(23)))^2....
        +(z(2)*sin(z(12))+z(3)*sin(z(18))-z(1)*sin(z(7))-z(4)*sin(z(24)))^2 +(z(2)*sin(z(13))+z(3)*sin(z(19))-z(1)*sin(z(7))-z(4)*sin(z(25)))^2....
        +(z(2)*sin(z(14))+z(3)*sin(z(20))-z(1)*sin(z(7))-z(4)*sin(z(26)))^2 +(z(2)*sin(z(15))+z(3)*sin(z(21))-z(1)*sin(z(7))-z(4)*sin(z(27)))^2);
    
    [z0,fz]=fminunc(f,z0);
    gama=beta*gama;
    alpha=max(0,2*(max([z0(1) z0(2) z0(3) z0(4)])+min([z0(1) z0(2) z0(3) z0(4)]))-(z0(1)+z0(2)+z0(3)+z0(4)))^2....
    +max(0,z0(10)-z0(11))^2 +max(0,z0(11)-z0(12))^2 +max(0,z0(12)-z0(13))^2 +max(0,z0(13)-z0(14))^2 +max(0,z0(14)-z0(15))^2 ....
    +(z0(2)*cos(z0(10))+z0(3)*cos(z0(16))-z0(1)*cos(z0(7))-z0(4)*cos(z0(22)))^2 +(z0(2)*cos(z0(11))+z0(3)*cos(z0(17))-z0(1)*cos(z0(7))-z0(4)*cos(z0(23)))^2....
    +(z0(2)*cos(z0(12))+z0(3)*cos(z0(18))-z0(1)*cos(z0(7))-z0(4)*cos(z0(24)))^2 +(z0(2)*cos(z0(13))+z0(3)*cos(z0(19))-z0(1)*cos(z0(7))-z0(4)*cos(z0(25)))^2....
    +(z0(2)*cos(z0(14))+z0(3)*cos(z0(20))-z0(1)*cos(z0(7))-z0(4)*cos(z0(26)))^2 +(z0(2)*cos(z0(15))+z0(3)*cos(z0(21))-z0(1)*cos(z0(7))-z0(4)*cos(z0(27)))^2....
    +(z0(2)*sin(z0(10))+z0(3)*sin(z0(16))-z0(1)*sin(z0(7))-z0(4)*sin(z0(22)))^2 +(z0(2)*sin(z0(11))+z0(3)*sin(z0(17))-z0(1)*sin(z0(7))-z0(4)*sin(z0(23)))^2....
    +(z0(2)*sin(z0(12))+z0(3)*sin(z0(18))-z0(1)*sin(z0(7))-z0(4)*sin(z0(24)))^2 +(z0(2)*sin(z0(13))+z0(3)*sin(z0(19))-z0(1)*sin(z0(7))-z0(4)*sin(z0(25)))^2....
    +(z0(2)*sin(z0(14))+z0(3)*sin(z0(20))-z0(1)*sin(z0(7))-z0(4)*sin(z0(26)))^2 +(z0(2)*sin(z0(15))+z0(3)*sin(z0(21))-z0(1)*sin(z0(7))-z0(4)*sin(z0(27)))^2;
    %disp(z)
    %disp(gama)
    disp(alpha*gama)
    k=k+1;
end
fprintf('\n')
disp(['Solución: ']);
z0
disp(['Función evaluada en z: ' num2str(f(z0))]);



