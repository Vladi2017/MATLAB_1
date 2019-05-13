%% power1
% V: autonomous cell; 5:11 PM 1/2/2018
r = 0.2:0.1:2; % load resistance in Ohm
U=4.8; % powerSupply constant dc voltage
P=(U^2)./r;
plot(r,P);grid on;
keyboard; close all; clear all;