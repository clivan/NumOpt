clear;
clc;

%% Inicio del programa
syms w1 w2 w3 w4 w5 w6 w7 w8 b1 b2

%% Vectores con los valores de x e y
px=[0.05, 0.01];
py=[0.010, 0.09];

%% Funciones de activación
%Primer capa
h1=w1*px(1)+w2*px(2)+b1;
sh1=1/(1+exp(-h1));
h2=w3*px(1)+w4*px(2)+b1;
sh2=1/(1+exp(-h2));
%Segunda capa
o=[w5*sh1+w6*sh2+b2, w7*sh1+w8*sh2+b2];

%% Construir la función objetivo
f=0;
for i=1:1:length(px)
    f=f+(1/(1+exp(-o(i)))-py(i))^2;
     
end

%% Calcular el gradiente de la función objetivo
g=[diff(f, w1), diff(f, w2), diff(f, w3), diff(f, w4), diff(f, w5), diff(f, w6), diff(f, w7), diff(f, w8), diff(f, b1), diff(f, b2)];
h=[diff(g, w1); diff(g, w2); diff(g, w3); diff(g, w4); diff(g, w5); diff(g, w6); diff(g, w7); diff(g, w8); diff(g, b1); diff(g, b2)];

%% Parámetros del problema
wb0=[0.99,0.99,0.99,0.99,-1.11,-1.11,0.441,0.441,0.857,-2.989];
al=0.2;    %alfa
k=0;
wb=wb0;
e=0.000001; %epsilon
er=100;  %error
 
%% Método de pasos descendentes
while er>=e
    r=eval(subs(g, [w1, w2, w3, w4, w5, w6, w7, w8, b1, b2], wb));
    wb=wb-al*r ;
    er=norm(r);
    k=k+1;
   end
k
min=eval(subs(f, [w1, w2, w3, w4, w5, w6, w7, w8, b1, b2], wb));
aux=1/(1+exp(-o(1))); aux2=1/(1+exp(-o(2)));
oc1=eval(subs(aux, [w1, w2, w3, w4, w5, w6, w7, w8, b1, b2], wb));
oc2=eval(subs(aux2, [w1, w2, w3, w4, w5, w6, w7, w8, b1, b2], wb)); 
%%
fprintf('Minimizador', wb)
fprintf('Mínimo', min)
fprintf('Valores de salida', oc1,oc2)
