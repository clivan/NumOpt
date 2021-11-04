clear;
clc;

%% Condiciones de operación para el péndulo
m=0.2; %kg
b=0.72; %kg/(m*s)
g=9.8; %m/s²
l=0.5; %m

h=0.008; %Tamaño de paso
tf=5; %Tiempo de simulación
n=tf/h; %Número de muestras

t=linspace(0, tf, n+1); %Vector de tiempo
x1=zeros(1, n+1); %Primer estado (con ruido)
x2=zeros(1, n+1); %Segundo estado (con ruido)
X1=zeros(1, n+1); %Primer estado (sin ruido)
X2=zeros(1, n+1); %Segundo estado (sin ruido)
u=zeros(1, n+1); %Entrada al sistema

x1(1)=pi/2; %Condiciones iniciales
x2(1)=0; %"
X1(1)=pi/2; %"
X2(1)=0; %"

%% Método de Euler
for k=1:n
    if rand>0.5
        s=1;
    else
        s=-1;
    end
    x1(k+1)=x1(k)+h*x2(k)+0.0075*s*rand;
    x2(k+1)=x2(k)+h*((1/(m*l^2))*u(k)-m*g*l*sin(x1(k))-b*x2(k))+0.005*s*rand;
    X1(k+1)=X1(k)+h*X2(k);
    X2(k+1)=X2(k)+h*((1/(m*l^2))*u(k)-m*g*l*sin(X1(k))-b*X2(k));
end

%Derivar el segundo estado
x2p=diff(x2);
x2p=[0, x2p];
X2p=diff(X2);
X2p=[0, X2p];

hold on
subplot(2, 1, 1)
plot(t, x1, t, x2)
subplot(2, 1, 2)
plot(t, X1, t, X2)

%% Construir la función objetivo
syms 'B'

f=0;
for i=1:1:length(x1)
 f=f+(x2(i)+((1/(m*l^2))*u(i)-m*g*l*sin(x1(i))-B*x2(i))-(X2(i)+((1/(m*l^2))*u(i)-m*g*l*sin(X1(i))-b*X2(i))))^2;
end

%% Obtener gradiente y Hessiano
g=diff(f, B);
h=diff(g, B);

%% Resolver problema de optimización usando la Función fminunc
fh=matlabFunction(f); %Convertir función simbólica en función anónima
bb=fminunc(fh, 0); %%Miniizador
bbb=fh(bb); %Mínimo

%% Parámetros del problema
x0=0;
a=0.0001;    %α
k=0;
x=x0;
e=1e-5; %ε esperado
er=100;  %ε actual
 
%% Método de pasos descendentes
while er>=e
    r=eval(subs(g, [B], x));
    x=x-a*r;
    er=norm(r);
    k=k+1;
end

%% Variables auxiliares para el método de Newton
hi=inv(h);
dx=hi*g;
dx=-dx;

%% Parámetros del problema
X0=0;
K=0;
X=X0;
e=1e-5; %ε esperado
er=100;  %ε actual

%% Método de Newton
while er>=e
    r=eval(subs(dx, [B], X));
    er=norm(eval(subs(g, [B], X)));
    m=eval(subs(h, [B], X));
    X=X+r;
    K=K+1;
end

fprintf('Minimizando con Matlab: %f\n', bb)
fprintf('Minimizando con pasos descendentes: %f\n', x)
fprintf('Minimizando con método de Newton: %f\n', X)
fprintf('\n')
