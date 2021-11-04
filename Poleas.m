clear;
clc;
N=350; %rpm
%% CONDICIONES 1
d=[5, 6, 8, 10]; %in
w=2; %in
p=0.284;
P=0.75;
Ni=[750, 450, 250, 150]; %rpm
mu=0.2; %Coeficiente de fricción
a=20; %Distancia entre centros
s=166;
t=1.2;
e=1e-5;
beta=1.01;
gama=1e7;

format long
for i=1:max(size(d))
    C(i)=((pi*d(i))/2)*(1+(Ni(i)/N))+(((Ni(i)/N)-1)^2*d(i)^2)/(4*a)+2*a;
    th(i)=pi-2*asin ((Ni(i)/N-1)*d(i)/(2*a));
    T1(i)=s*t*w*(1-exp(-mu*(th(i))))*pi*d(5-i)*(N/33000);
    T(i)=(T1(i)-P);
    RT(i)=((exp(mu*th(i)))-2);
    Rx(i)=d(i);
    R(i)=(T1(i)-s*t*w);
end
Rw=w;
vec=[T(1), T(2), T(3), T(4), RT(1), RT(2), RT(3), RT(4), Rx(1), Rx(2), Rx(3), Rx(4), Rw, R(1), R(2), R(3), R(4)];
nmax=max(size(vec));
for i=1:nmax
    vmax(i)=max(0, vec(i));
end

alfa=((C(1)-C(2))^2+(C(1)-C(3))^2+(C(1)-C(4))^2)+sum(vmax)^2;
k=0;
x=[d, w];

while gama*alfa>e
    f=@(x) (p*x(5)*(pi/4)*((x(1)^2*(1+(Ni(1)/N)^2)+(x(2)^2*(1+(Ni(2)/N)^2)+(x(3)^2*(1+(Ni(3)/N)^2)+(x(4)^2*(1+(Ni(4)/N)^2)))))))+(gama*alfa);
    x=fminunc(f, x);
    Auxgama=gama;
    gama=beta*gama;
    alfa=((C(1)-C(2))^2+(C(1)-C(3))^2+(C(1)-C(4))^2)+sum(vmax)^2;
    fun=@(x) (p*x(5)*(pi/4)*((x(1)^2*(1+(Ni(1)/N)^2)+(x(2)^2*(1+(Ni(2)/N)^2)+(x(3)^2*(1+(Ni(3)/N)^2)+(x(4)^2*(1+(Ni(4)/N)^2)))))));
    ff=fun(x);
    disp(x)
    disp(gama*alfa)
    disp(ff)
    k=k+1;
    disp(k)
end