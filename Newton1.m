% Método de Newton para el primer problema.
clear;
clc;

%% Inicio del programa
syms 'x' 'y'

%% Función de Easom
f=3*x^2+y^2-x^4-12;

%% Calcular el gradiente de la función objetivo
g=[diff(f, x); diff(f, y)];
h=[diff(diff(f, x), x), diff(diff(f, x), y); diff(diff(f, y), x), diff(diff(f, y), y)];
hi=inv(h);
dx=hi*g;
dx=-dx;

%% Parámetros del problema
x0=[1/3, 1];
k=0;
X=x0';
e=1e-5; %ε esperado
er=100;  %ε actual

%% Método de Newton
while er>=e
    r=eval(subs(dx, [x; y], X));
    er=norm(eval(subs(g, [x; y], X)));
    fprintf("k=%d\t(x, y)=(%f,\t%f)\t|g(x, y)|=%f\n", k, X(1), X(2), er)
    m=eval(subs(h, [x;y], X));
    fprintf("Hessiano\n")
    disp(m)
    fprintf("\n")
    if issymmetric(m)
        n=eig(m);
        if all(n>0)
            fprintf("Definida positiva")
        else
            fprintf("No es definida positiva")
        end
    end
    fprintf("\n")
    X=X+r;
    k=k+1;
end
fprintf('\n')
