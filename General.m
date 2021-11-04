%% Control predictivo de un pendulo simple

clear all
close all
global x1 x2 k

%% Parámetros
m = 1;
bf = 0.02;
g = 9.81;
l = 0.5;
h = 1e-3;
tf = 10;
n = tf/h;

%% Selector de problema
np = input('\n Elija el tipo de problema: \n *1.-Donde y=pi/2\n *2.-Donde y=pi/2 + pi*sin(pi*t)/8\n \n');

%% Selector de caso
nhp = input('Elija un horizonte de predicción: \n *1\n *5\n *10\n');


%% Inicializacion tiempo, estados y control
t  = linspace(0,tf,n+1);
x1 = zeros(1,n+1);
x2 = zeros(1,n+1);
u  = zeros(1,n+1);

%% Condiciones iniciales
x1(1)=0;
x2(1)=0;
u(1)=0;

%% Resto de las iteraciones
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch np
    case 1
        y=pi/2*ones(size(t));
    case 2
        y=pi/2 + pi*sin(pi*t)/8;
    otherwise
        disp('Selección inválida')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch nhp
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 1
          %Para horizonte de predicción=1
for k=1:9991
    x0=[x1(k)*ones(1,1),x2(k)*ones(1,1),zeros(1,1)];
    fun = @(x) (y(k+1)-x(1))^2;
    nonlcon=@resthpred1;
    Aeq = [];
    beq = [];
    A = [];
    b = [];
    lb=[-100*ones(1,2),-15*ones(1,1)];
    up=-1*lb;
    [x,fval,exitflag,output,lfambda,grad,hessian]=fmincon(fun,x0,A,b,Aeq,beq,lb,up,nonlcon);
    u(k+1)=x(3);
    x1(k+1)=x1(k)+h*x2(k);
    x2(k+1)=x2(k)+h*(-m*g*l*sin(x1(k))-bf*x2(k)+u(k+1))/(m*l^2);
end   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
      
    case 5
      % Para horizonte de predicción=5
for k=1:9991
    x0=[x1(k)*ones(1,5),x2(k)*ones(1,5),zeros(1,5)];
    fun = @(x) (y(k+1)-x(1))^2+(y(k+2)-x(2))^2+(y(k+3)-x(3))^2+(y(k+4)-x(4))^2+(y(k+5)-x(5))^2;
    nonlcon=@resthpred5;
    Aeq = [];
    beq = [];
    A = [];
    b = [];
    lb=[-100*ones(1,10),-15*ones(1,5)];
    up=-1*lb;
    [x,fval,exitflag,output,lfambda,grad,hessian]=fmincon(fun,x0,A,b,Aeq,beq,lb,up,nonlcon);
    u(k+1)=x(11);
    x1(k+1)=x1(k)+h*x2(k);
    x2(k+1)=x2(k)+h*(-m*g*l*sin(x1(k))-bf*x2(k)+u(k+1))/(m*l^2);
end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 10
      % Para horizonte de predicción=10
for k=1:9991
    x0=[x1(k)*ones(1,10),x2(k)*ones(1,10),zeros(1,10)];
    fun = @(x) (y(k+1)-x(1))^2+(y(k+2)-x(2))^2+(y(k+3)-x(3))^2+(y(k+4)-x(4))^2+(y(k+5)-x(5))^2+(y(k+6)-x(6))^2+(y(k+7)-x(7))^2+(y(k+8)-x(8))^2+(y(k+9)-x(9))^2+(y(k+10)-x(10))^2;
    nonlcon=@resthpred10;
    Aeq = [];
    beq = [];
    A = [];
    b = [];
    lb=[-100*ones(1,20),-15*ones(1,10)];
    up=-1*lb;
    [x,fval,exitflag,output,lfambda,grad,hessian]=fmincon(fun,x0,A,b,Aeq,beq,lb,up,nonlcon);
    u(k+1)=x(21);
    x1(k+1)=x1(k)+h*x2(k);
    x2(k+1)=x2(k)+h*(-m*g*l*sin(x1(k))-bf*x2(k)+u(k+1))/(m*l^2);
end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    otherwise
        disp('Selección inválida')
end
%
%% Graficación
figure
plot(t,x1, t,y)
    
figure
plot(t,u)
    
