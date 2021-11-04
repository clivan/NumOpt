% Usando el método de gradientes descendientes, encuentre los valores de a, b, c que ajusten los datos del sistema.
clear;
clc;

%% Inicio del programa
syms 'a' 'b' 'c'

%y=ax²+bx+c

%% Vectores con los valores de x e y
px=[2.1, 6, 9.1, 7.5];
py=[8.9, 1.2, 15.7, 6.5];

%% Construir la función objetivo
f=0;
for i=1:1:length(px)
    f=f+(a*px(i)*px(i)+b*px(i)+c-py(i))^2;
end

%% Calcular el gradiente de la función objetivo
g=[diff(f, a), diff(f, b), diff(f, c)];

%% Parámetros del problema
abc0=[3, 5, 8];
al=5e-5;    %α
k=0;
abc=abc0;
e=1e-3; %ε esperado
er=100;  %ε actual
 
%% Método de pasos descendentes
while er>=e
    r=eval(subs(g, [a, b, c], abc));
    abc=abc-al*r;
    er=norm(r);
    k=k+1;
end

%% Imprimir resultados
fprintf("k\ta\tb\tc\tf(x1, x2)\ter\n")
fprintf("%d\t%f\t%f\t%f\t%f\t%f\n", k, abc(1), abc(2), abc(3), eval(subs(f, [a, b, c], abc)), er)

%% Graficar curva ajustada
hold on
plot(px, py, 'k*')
X=[0:0.1:10];
%abc=[0.934776, -9.475551, 24.645363]
Y=abc(1)*x.^2+abc(2)*x+abc(3);
plot(X, Y, 'b-')
