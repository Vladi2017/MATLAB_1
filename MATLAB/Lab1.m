%% Sinusoids1
% V: autonomous cell;
% web http://aulaglobal.upf.edu/mod/resource/view.php?id=280755 -browser
% Generate two 3000 hertz sinusoids with different amplitudes and phases.
% x1(t)=A1cos(2pi3000t+angle1); x2(t)=A2cos(2pi3000t+angle2);
freq=3000; angle1=pi/4; angle2=-pi/6; spp=20; sr=freq*spp;
A1=1; A2=1;
per = 1.0 / freq; % period sec
% spp = per*sr; % samples_per_period
% t=linspace(0-2*spp,2*spp,4*spp);
t=linspace(0-2*per,2*per,4*spp);
x1=A1*cos(2*pi*freq*t+angle1);
x2=A2*cos(2*pi*freq*t+angle2);
% (c) Verify that the phase of the two signals x1(t) and x2(t) is correct at t = 0, and also verify that
% each one has the correct maximum amplitude.
plot(t,x1); title(['x1=',int2str(A1),'cos(2pi*',int2str(freq),'*t+pi/4)']); grid on;
keyboard;
figure(2); plot(t,x2); title(['x2=',int2str(A2),'cos(2pi*',int2str(freq),'*t-pi/6)']); grid on; xlabel('Time');
keyboard;
% % (e) Create a third sinusoid as the sum: x3(t) = x1(t) + x2(t).
% (f) Measure the magnitude and phase of x3(t) directly from the plot. In your lab report, explain how
% the magnitude and phase were measured by making annotations on each of the plots.
x3=x1+x2; figure(3);
plot(t,x3); title(['x3=x1+x2=',int2str(A1),'cos(2pi*',int2str(freq),'*t+pi/4)+'...
    int2str(A2),'cos(2pi*',int2str(freq),'*t-pi/6)']);
grid on;
keyboard; close all; clear all;