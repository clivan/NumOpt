clear;
clc;

%% Inicio del programa
syms 'x' 'y'

%% Función del problema
f=(x^2+y-1)^2+(x+y^2-8)^2;

%% Parámetros del problema
x0=[0; 0];
l=1;
k=0;
X=x0;
e=1e-5; %ε esperado
eh=1e-3; %Tolerancia del valor del gradiente
er=true;

%% Calcular el gradiente de la función objetivo
g=[diff(f, x); diff(f, y)];
h=[diff(diff(f, x), x), diff(diff(f, x), y); diff(diff(f, y), x), diff(diff(f, y), y)];
L=eye(size(h));
hi=-inv(h+l*L);
s=hi*g;
S=eval(subs(s, [x; y], X));

%% Método de Levenberg-Marquadt
fprintf("k\tx\ty\t|f(x+1)-f(x)\n")
while er==true
    hi=-inv(h+l*L);
    s=hi*g;
    x0=X;
    S=eval(subs(s, [x; y], X));
    X=X+S;
    p=eval(subs(f, [x; y], X));
    q=eval(subs(f, [x; y], x0));
    r=norm(eval(subs(g, [x; y], x0)));
    if p<q
        l=l/2;
    else
        l=2*l;
    end
    fprintf("%d\t%f\t%f\t%f\n", k, X(1), X(2), norm(p-q))
    if norm(p-q)>e || r>eh
        er=true;
        k=k+1;
    else
        er=false;
    end
end
fprintf('\n')