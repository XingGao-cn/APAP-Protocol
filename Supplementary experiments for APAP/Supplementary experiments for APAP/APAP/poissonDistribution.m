close all; 
clear,clc;
% MATLAB演示泊松分布(Poisson Distribution)
% 泊松分布(Poisson Distribution):X~P(lamda)

R=500;
N=1000;
r=30;
density=N/(pi*R^2);
neighbors=pi*r^2*density;
dis=300;%
lamda = 5;%avge data packets
n = 20;

f = zeros(1,n+1);
for k = 0:1:n
    f(k+1) = lamda^k/factorial(k)*exp(-lamda);
end

figure;
x = 0:1:n;
bar(x,f,'r');
title('Poisson Distribution');
xlabel('Number of data');
ylabel('Probability estimate');