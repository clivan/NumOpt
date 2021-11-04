%% Condiciones de operación para el péndulo
m=0.2; %kg
b=0.8; %kg/(m*s)
g=9.8; %m/s²
l=0.5; %m
f=100;

h=0.1; %Tamaño de paso
tf=5; %Tiempo de simulación
n=tf/h; %Número de muestras

t=linspace(0, tf, n+1); %Vector de tiempo
cx1=zeros(1, n+1); %Primer estado
cx2=zeros(1, n+1); %Segundo estado 
xp1=zeros(1, n+1); %Primer estado (con ruido)
xp2=zeros(1, n+1); %Segundo estado (con ruido)
xA1=zeros(1, n+1); %Primer estado (con ruido)
xA2=zeros(1, n+1)
%u=zeros(1, n+1); %Entrada al sistema
EVarsTry=[-5.34942972555549,1.78570847187612,0.830097581721396,-5.34942972555549,1.78570847187612,0.830097581721396,-21.7769897711351,-28.5205138133584,-6.49493649498163,-29.1254148087093]
%VarT=[Varg, Var]

u=0.029*sin(2*pi*f*t*2)-0.053*cos(2*pi*t*3)+0.03*sin(2*pi*f*t*4)-0.017*cos(2*pi*t*5)+0.0027*sin(2*pi*f*t*6)+0.0083*cos(2*pi*t*7)+0.015*sin(2*pi*f*t*8);
v=-0.023*sin(2*pi*f*t)+0.027*cos(2*pi*t*2)-0.013*sin(2*pi*f*t*3)-0.015*cos(2*pi*t*4)+0.003*sin(2*pi*f*t*5)-0.007*cos(2*pi*t*6)+0.023*sin(2*pi*f*t*7);
cx1(1)=pi/4; %Condiciones iniciales
cx2(1)=0; %
xp1(1)=pi/4; %Condiciones iniciales
xp2(1)=0; %"


%% Método de Euler
for k=1:n
   
    cx1(k+1)=cx1(k)+h*cx2(k);
    cx2(k+1)=cx2(k)+h*((1/(m*l^2))*u(k)-m*g*l*sin(cx1(k))-b*cx2(k));
    cx3(k+1)=u(k);
    xp1(k)=cx1(k);
    xp2(k)=cx2(k);
    xp3(k)=cx3(k);
    EVarT=[EVarsTry, cx1(k+1),cx2(k+1),cx3(k+1),xp1(k), xp2(k),xp3(k) ];
%     xA1(k+1)=eval(subs(NOut1, [VarT],EVarT ));
%     xA2(k+1)=eval(subs(NOut2, [VarT],EVarT ));
end

hold on
% plot( t, cx1, t, cx2,t, xp1, t, xp2)
% %, ,
% Nm=length(xp1); %= n
% for k=1:n
%     xA1(k+1)=eval(subs(NOut1, [VarT],EVarT ));
%     xA2(k+1)=eval(subs(NOut2, [VarT],EVarT ));
%    end
plot(t, cx1, t, cx2,t, xp1, t, xp2, t, xA1,t, xA2)


%
