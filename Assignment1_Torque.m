close all
clear all
clc

u=4*pi*10^-7
N=250
i=3
h=20*10^-3

for xteta=0:1:360
    teta = mod(xteta,180)
if teta < 74
    r=12*10^-3
    g=0.5*10^-3
    angle = ((74 - teta)*2*pi)/360
    R=(2*g)/(u*h*(r+0.5*g)*angle)
    L=N^2/R   %(N^2*u*h*(r+0.5*g)*angle)/(2*g)  
    T=(u*N^2*i^2*h*(r+0.5*g))/(4*g)
    if L<((N^2*u*h*(11.5*10^-3))/(2*2.5*10^-3))  %Limiting
        L=((N^2*u*h*(11.5*10^-3))/(2*2.5*10^-3)) 
    end
elseif teta >= 74 & teta <=106 
    r=10*10^-3
    g=2.5*10^-3
    angle = ((teta - 74)*2*pi)/360
    R=(2*g)/(u*h*(r+0.5*g))
    L=N^2/R
    T=0;
else
    r=12*10^-3
    g=0.5*10^-3
    angle = ((teta - 106)*2*pi)/360
    R=(2*g)/(u*h*(r+0.5*g)*angle)
    L=N^2/R
    T=-(u*N^2*i^2*h*(r+0.5*g))/(4*g)
    if L<((N^2*u*h*(11.5*10^-3))/(2*2.5*10^-3))  %Limiting
        L=((N^2*u*h*(11.5*10^-3))/(2*2.5*10^-3)) 
    end
end
figure(1)
plot((xteta*2*pi)/360,L,'.')
grid
hold on
figure(2)
plot((xteta*2*pi)/360,T,'.')
grid
hold on
end
