%Functie de gr.2 cu parametru m: f(x)=x^2-2mx+m+1. Problema 1/172 manual Algebra
%cls.9
figure(1);
grid on;
x=linspace(-10,10,1000);
%whos;
m=-2;
f=x.^2-2*m*x+m+1;
plot(x,f);
grid on;
m=-1;
f=x.^2-2*m*x+m+1;
hold on;
plot(x,f);
m=(1+sqrt(5))/2;
f=x.^2-2*m*x+m+1;
hold on;
plot(x,f);
m=2;
f=x.^2-2*m*x+m+1;
hold on;
plot(x,f);
keyboard; %pass with (command) return;
close(1);%it seems close 'Figure 1'
clear all;
%Plot symbolic expression, equation, or function
syms x;
m=-1;
f=x^2-2*m*x+m+1;
f
ezplot(f);
grid on;
m=2;
f
f=x^2-2*m*x+m+1;
f
hold on;
ezplot(f);
m=-2;
f
f=x^2-2*m*x+m+1;
hold on;
ezplot(f);
keyboard;close(1);%it seems close 'Figure 1'
clear all;