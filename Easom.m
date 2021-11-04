% Usando el método del gradiente descendiente, encuentre el minimizador y el mínimo de la función de Easom
clear;
clc;

%% Inicio del programa
syms 'x1' 'x2'

%% Función de Easom
f=-cos(x1)*cos(x2)*exp(-(x1-pi)^2-(x2-pi));

%% Calcular el gradiente de la función objetivo
g=[diff(f, x1), diff(f, x2)];

%% Parámetros del problema
x0=[6, 0]; 
a=0.2;   %α
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
fprintf('k\tx1\tx2\tf(x1, x2)\ter\n')
fprintf('%d\t%f\t%f\t%f\t%f\n', k, x(1), x(2), eval(subs(f, [x1, x2], x)), er)
 
