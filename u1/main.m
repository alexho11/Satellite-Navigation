clear all;
close all;
clc;
a=[2.23;2.51];
Q_a=[6.29,3.33;3.33,1.8];

%Aufgabe 1
a1=round(a);
% Booststrapping
a2=zeros(2,1);
a2(1)=round(a(1));
a2(2)=round(a(2)-Q_a(1,2)./Q_a(1,1)*(a(1)-a2(1)));

a3=zeros(2,1);
a3(2)=round(a(2));
a3(1)=round(a(1)-Q_a(1,2)./Q_a(2,2)*(a(2)-a2(2)));

%Z-trans
alphai=-round(Q_a(1,2)/Q_a(1,1));
Zi=[alphai,1;1,0];
Z=Zi;
Qi=Zi*Q_a*Zi';
i=1;
while alphai~=0
    alphai=-round(Qi(1,2)/Qi(1,1));
    Zi=[alphai,1;1,0];
    Z=Zi*Z;
    Qi=Zi*Qi*Zi';
    i=i+1;
end
zd=round(Z*a);
ac1=inv(Z)*zd;

load('amb10.mat')
n = 40;
t = zeros(n,1);
for i = 1:n
    tic
    a = rand([i,1]);
    Q = rand(i);
    Q = Q * Q'; % damit Q symmetrisch ist
    [a_ILS,sqnorm] = LAMBDA(a,Q,1,'ncands',2);
    toc
    t(i) = toc;
end

x = 1:40;
x = x';
ft = fittype(@(c,k,x)c*k.^x);
f = fit(x,t, ft,'StartPoint', [1 1]);
figure
hold on
plot(x,t)
plot(f,x,t)
xlabel('Anzahl Elementen')
ylabel('Rechenzeit (s)')