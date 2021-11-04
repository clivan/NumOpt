%% 
clc;
clear;

%% Condiciones de operación para el péndulo
m=0.2; %kg
b=0.8; %kg/(m*s)
g=9.8; %m/s²
l=0.5; %m
f=100;

h=0.01; %Tamaño de paso
tf=10; %Tiempo de simulación
n=tf/h; %Número de muestras

t=linspace(0, tf, n+1); %Vector de tiempo
cx1=zeros(1, n+1); %Primer estado
cx2=zeros(1, n+1); %Segundo estado 
xp1=zeros(1, n+1); %Primer estado (con ruido)
xp2=zeros(1, n+1); %Segundo estado (con ruido)
x1Est=zeros(1, n+1);
%u=zeros(1, n+1); %Entrada al sistema


u=0.029*sin(2*pi*f*t*2)-0.053*cos(2*pi*t*3)+0.03*sin(2*pi*f*t*4)-0.017*cos(2*pi*t*5)+0.0027*sin(2*pi*f*t*6)+0.0083*cos(2*pi*t*7)+0.015*sin(2*pi*f*t*8);
v=-0.023*sin(2*pi*f*t)+0.027*cos(2*pi*t*2)-0.013*sin(2*pi*f*t*3)-0.015*cos(2*pi*t*4)+0.003*sin(2*pi*f*t*5)-0.007*cos(2*pi*t*6)+0.023*sin(2*pi*f*t*7);
cx1(1)=pi/4; %Condiciones iniciales
cx2(1)=0; %
xp1(1)=pi/4; %Condiciones iniciales
xp2(1)=0; %"
cx1(1)=0;

%% Método de Euler
for k=1:n
   
    cx1(k+1)=cx1(k)+h*cx2(k);
    cx2(k+1)=cx2(k)+h*((1/(m*l^2))*u(k)-m*g*l*sin(cx1(k))-b*cx2(k));
    cx3(k+1)=u(k);
    xp1(k)=cx1(k);
    xp2(k)=cx2(k);
    xp3(k)=cx3(k);
    
end

hold on
plot( t, cx1, t, cx2,t, xp1, t, xp2, t, cx3)
%, ,
Nm=length(xp1); %= n

%% Parámetros generales
syms b1 b2 x1  x2 x3 x4 x5 x6
NumN=input('Ingrese el número de neuronas que desea: ' ); %Define el número de neuronas

%% Vector símbólico de pesos 
w = sym([]); %Declarar vector w simbolico
i=1;          %Iniciar i en 1

for i=1:(6*NumN+NumN*2)
   w(i)="w"+i;
   i=i+1;
end

%% Creación de las funciones de las neuronas
for i=1:NumN
            N(i)=b1 + w(6*i-5)*x1 + w(6*i-4)*x2 + w(6*i-3)*x3 + w(6*i-2)*x4 + w(6*i-1)*x5 + w(6*i)*x6; 
            i=i+1;
end
fprintf('Funciones de las neuronas\n \n ');
pretty(N)
fprintf('\n \n ');

%see=eval(subs(N,[w], W0)) %Evaluación de las funciones en las condiciones iniciales dadas
%% Funciones de activacion de las neuronas
for i=1:NumN
            NAct(i)=1/(1+exp(-( N(i) ))); %t=[2, 2.7107],  x0=2
            i=i+1;
end
fprintf('Funciones de activación de las neuronas\n \n\n ');
pretty(NAct)
fprintf('\n \n ');
%see2=eval(subs(NAct,[w], W0)) %Evaluación de las funciones  de activación en las condiciones iniciales dadas
%% Funciones de salida
NOut1=b2;
for i=1:NumN
   % Aux=NumN
            NOut1=NOut1+ w(6*NumN+i)*NAct(i);  %t=[2, 2.7107],  x0=2
            i=i+1;
end
fprintf('Funcion  de salida 1\n \n\n ');        
  pretty(NOut1)
fprintf('\n \n ');

NOut2=b2; 
for i=1:NumN
   % Aux=NumN
            NOut2=NOut2+ w(6*NumN+NumN+i)*NAct(i);  %t=[2, 2.7107],  x0=2
            i=i+1;
end

fprintf('Funcion  de salida 2 \n \n \n');        
  pretty(NOut2)
fprintf('\n \n ');
%seeOuts=[eval(subs(NOut1,[w], W0)),eval(subs(NOut2,[w], W0))]     %Evaluación de las funciones  de activación en las condiciones iniciales dadas


%% Construir la función objetivo
Var=[x1,x2,x3, x4,x5, x6];                    %Variables a evaluar
EVar=[cx1(i), cx2(i), cx3(i), xp1(i), xp2(i), xp3(i)]; %Valores para evaluar las variables

f=0;
for i=1:Nm-1
    x1Est(i)=subs(NOut1, [Var], EVar); %x1 estimada
    x2Est(i)= subs(NOut2, [Var], EVar);; %x2 estimada
    f=f+norm([xp1(i);xp2(i)]-[x1Est(i); x2Est(i)]); %Creo que aquí iría la norma 2
   i=i+1; 
   
  end

%% Calcular el gradiente de la función objetivo
Varg=[w, b1, b2];                    %Variables a evaluar en el gradiente
%EVar=[xm1(i), xm2(i), xm4(i), xm5(i)]; %Valores para evaluar las variables
g = sym([]);
for i=1:(length(w)+2)
   g(i)=diff(f, Varg(i));
   i=i+1;
end
g=[diff(f, w1), diff(f, w2), diff(f, w3), diff(f, w4), diff(f, w5), diff(f, w6), diff(f, w7), diff(f, w8), diff(f, b1), diff(f, b2)];

%% Vector de condiciones iniciales para los pesos 
for i=1:(6*NumN+NumN*2)
   W0(i)=0.8; %Establecer la misma condición inicial para todos los w
   i=i+1;
end
W0
%% Condiciones iniciales para las compensaciones
B1=0.8; B2=0.5;
%w=[w1, w2, w3, w4, w5, w6];

%% Parametros generales para el método David
 l=1;
 k=0;
 e=1e-5; %ε esperado
 eh=1e-3; %Tolerancia del valor del gradiente
 er=true;
%% Aproximar el Hessiano
H = eye(length(w)+2);
h=[diff(g, w1); diff(g, w2); diff(g, w3); diff(g, w4); diff(g, w5); diff(g, w6); diff(g, w7); diff(g, w8); diff(g, b1); diff(g, b2)];
%% Parámetros para calculos 
L=eye(size(H));
hi=-inv(H+l*L);
s=hi*g;
eps=1e-5;
alpha=0.5;
Vars=[Varg];
EVarS=[W0, B1, B2]; 
S=eval(subs(s, [Vars], EVarS));
G=eval(subs(g, [Varg], EVarS));y=1;
%% Método de Davison
while norm(eval(subs(G,[Varg],EVarS)))>eps
    d=-H*G';
    s=alpha*d;
    EVarS=EVarS+s';
    Ga=G;
    GAux=eval(subs(g, [Varg], EVarS));
    YAux=y;
    y=GAux-Ga;
    Cambio=y-YAux
    H=H-(H*y'*y*H)/(y*H*y');
    %H=H+((s*s')/(s*y))-(H*y'*y*H)/(y*H*y');
  end
fprintf('\n')

for i=1:Nm-1
     XSubs=[cx1(i),cx2(i),cx3(i),xp1(i),xp2(i),xp3(i)];
    x1Est(i)=eval(subs(NOut1, [Varg], EVarS)); %x1 estimada
    x2Est(i)= eval(subs(NOut2, [Varg], EVarS)); %x2 estimada
   X1EST(i)=eval(subs((x1Est(i)),[Var],XSubs));
   X2EST(i)=eval(subs((x1Est(i)),[Var],XSubs));
   i=i+1; 
end
XSubs=[cx1(i),cx2(i),cx3(i),xp1(i),xp2(i),xp3(i)];EVarT=[EVarS,XSubs]

ii=1;
 for ii=1:Nm-1
     XSubs=[cx1(ii),cx2(ii),cx3(ii),xp1(ii),xp2(ii),xp3(ii)]
     VarT=[Varg, Var];
     EVarT=[EVarS,XSubs]
     x1Est(ii)=eval(subs(NOut1, [VarT], EVarT)); %x1 estimada
    x2Est(ii)= eval(subs(NOut2, [VarT], EVarT)); %x2 estimada
    Z(ii)=eval(subs((x1Est(ii)),[VarT],EVarT))
    ii=ii+1; 
 end
Z=eval(subs((x1Est(8)),[Var],EVar))

 ii=1;
 for ii=1:5
     XSubs=[cx1(ii),cx2(ii),cx3(ii),xp1(ii),xp2(ii),xp3(ii)];
     VarT=[Varg, Var];
     EVarT=[EVarS,XSubs];
     x1Est(ii)=eval(subs(NOut1, [VarT], EVarT)) %x1 estimada
    %x2Est(ii)= eval(subs(NOut2, [VarT], EVarT)); %x2 estimada
    %Z(ii)=eval(subs((x1Est(ii)),[VarT],EVarT))
    ii=ii+1; 
 end
