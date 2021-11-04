clear;
clc;

%% Inicio del programa
syms 'x1' 'x2'

k=[20, 10, 30, 35]; %kg/s²
F=[100, 200]; %N

%% Energía potencial
V=0.5*(k(1)*x2^2 + k(2)*x2^2+ k(3)*x1^2 + k(4)* (x2-x1)^2)-F(1)*x1 -F(2)*x2;

%% Calcular el gradiente de la función objetivo
g=[diff(V, x1), diff(V, x2)];

%% Parámetros del problema
x0=[-100, -1000]; %1.5 4.5
a=2e-3;   %α
k=0;
x=x0;
e=1e-5; %ε esperado
er=100;  %ε actual

%% Método de pasos descendentes
while er>=e
    r=eval(subs(g, [x1, x2], x));
    x=x-a*r;
    er=norm(r);
    k=k+1;
end

%% Imprimir resultados
fprintf("k\tx1\tx2\tV(x1, x2)\ter\n")
fprintf('%d\t%f\t%f\t%f\t%f\n', k, x(1), x(2), eval(subs(V, [x1, x2], x)), er)