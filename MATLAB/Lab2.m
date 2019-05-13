%% Audio IO
% web http://www.ee.columbia.edu/~ronw/adst-spring2010/lectures/matlab/lecture1.html -browser
% V: autonomous cell;
filename = 'flute-C4.wav';
[x2 sr2] = wavread(filename);
% Get the time axis right.
t2 = linspace(0, length(x2) / sr2, length(x2));
soundsc(x2, sr2);
plot(t2, x2);
xlabel('Time (sec)');
%% Resampling
% V: this cell depend on "Audio IO" cell(s).
sr3 = 4000; % Hz
x3 = resample(x2, 8000, sr3);
subplot(211); title('Flute'); plot(x2)
subplot(212); plot(x3); title('Resampled flute'); xlabel('Time (samples)');
soundsc(x3, 2*sr2);
pause; clear all; close all;
%% FourierTransform_1
% V: autonomous cell;
% Pick a sampling rate.
sr = 8000;
% Define the time axis.
dur = 1; % sec
t = linspace(0, dur, dur * sr);
freq = 440; % Hz
x = sin(2*pi*freq*t);
% Fourier Transform
X = fft(x);
% Whats the frequency axis?
f = linspace(0, sr, length(X));
subplot(211);plot(f, 1/length(t)*abs(X));title('Magnitude');%V:see scaling factor 1/N
subplot(212);plot(f, angle(X));title('Phase [radians]');xlabel('Frequency (Hz)');
% Recall that for real-valued signals the DFT is always symmetric around
% sr/2 (or 0), so we only need to plot the first half.
pause; clear all; close all;
%% fundamental_frequency
% V: autonomous cell;
%  This time for x2 signal (.wav from file)
filename = 'flute-C4.wav';
[x2 sr2] = wavread(filename);
X2 = fft(x2(1:1024));
f2 = linspace(0, sr2, length(X2));
% Recall that for real-valued signals the DFT is always symmetric around
% sr/2 (or 0), so we only need to plot the first half.
subplot(211);plot(f2(1:end/2+1), abs(X2(1:end/2+1)));title('Magnitude');
subplot(212);plot(f2(1:end/2+1), angle(X2(1:end/2+1)));title('Phase [rad]');xlabel('Frequency (Hz)');
setAlwaysOnTop(gcf,true);
% Whats the (approximate) fundamental frequency of the flute note (C4)?
% Just find the bin corresponding to the first peak in the magnitude spectrum.
mag = abs(X2);
% Ignore redundant second half.
mag = mag(1:end/2+1);
% Find all local maxima.
peaks = (mag(1:end-2) < mag(2:end-1)) & mag(2:end-1) > mag(3:end);
length(peaks)
keyboard;
% But we only want the peaks above a threshold to ensure that we ignore the noise.
peaks1 = peaks & mag(2:end-1) > 0.5;
% disp('.. and the fundamental frequency is:');
['.. and the fundamental frequency is: ', num2str(f2(peaks1)), 'Hz'] % V: print out in Matlab Command window.
% f2(peaks) % V: very clever, vector filter based on logical (vector indices);
% K>> peaks(f2) Subscript indices must either be real positive integers or logicals.
peaks = peaks & mag(2:end-1) > 0.2;
['.. and main spectral components are: ', num2str(f2(peaks)), ' Hz']
keyboard; clear all; close all;
%% FIR1
% V: autonomous cell;
% some preparing:
% Pick a sampling rate.
sr = 8000;
% Define the time axis.
dur = 1; % sec
t = linspace(0, dur, dur * sr);
f = linspace(0, sr, length(t)); %V: build f vector
% Make some noise.
% rand generates uniformly distributed random values between 0 and 1.
n = rand(1, length(t)) - 0.5;
% Simple FIR filter: h[n] = 0.5*d[n] + 0.5*d[n-1] (V: vhere d[n] is unit impulse)
filt = [0.5, 0.5]; %V: filter impulse response (well known as h[n]).
% Lets filter some noise buy convolving it with the impulse response.
% Recall that the convolution of two signals with length N1 and N2 is
% N1 + N2 - 1.  The 'same' argument just tells conv to truncate the
% convolved signal at N1 samples.
y = conv(n, filt, 'same');
N = fft(n); % without scaling factor 1/N
Y = fft(y);
idx = 1:length(n) / 2 + 1;
subplot(211); plot(f(idx), abs(N(idx))); title('WhiteNoise spectrum');
subplot(212); plot(f(idx), abs(Y(idx))); xlabel('Frequency (Hz)'); title('FilteredNoise');
setAlwaysOnTop(gcf,true);
%% IIR1
% V: this cell depend on "FIR1" cell(s).
% [b a] = butter(2, [400 1500]/sr); V: this is original, but seems more
% appropriate to "normalize" to half sampling rate (see help butter)
[b a] = butter(2, [400 1500]/(sr/2)) % Butterworth 4th order bandpass filter with passband  W1 < W < W2.
% [b,a] are filter coefficients in length order+1 vectors B (numerator) and A (denominator).
y = filter(b, a, n);
% The filter is a "Direct Form II Transposed" implementation of the standard difference equation:
% a(1)*y(n) = b(1)*x(n) + b(2)*x(n-1) + ... + b(nb+1)*x(n-nb)
%                       - a(2)*y(n-1) - ... - a(na+1)*y(n-na)
Y = fft(y);
subplot(212); plot(f(idx), abs(Y(idx))); xlabel('Frequency (Hz)'); grid on;
% (You can use filter for FIR filters too, just be sure that the second
% argument is a scalar). ??!!n V: Which is 2nd argument?
keyboard;
% Matlab has a special function to plot a filter's frequency response.
clf; freqz(b, a);
fprintf('\nWe have [b a] = butter(2, [400 1500]/(sr/2)) with sampling rate sr=8000\n%s\n%s\n%s\n%s\n',...
    'How to read the Magnitude[dB] plot (with figure Data Cursor feature):',...
    'X=1 = 1/2 sampling rate (sr)',...
    'X=1500/(sr/2)=1500/4000=0.375, Y=-3.01dB; High cutoff f=1500',...
    'X=400/(sr/2)=400/4000=0.1 (X=0.09961), Y=-3.067dB; Low cutoff f=400.');
keyboard;
% Pole-zero plots too:
zplane(b, a);
fprintf('\n\nPlotting: zplane(b, a);\n%s\n%s\n%s\n%s\n',...
'zplane(B,A) where B and A are row vectors containing transfer function',...
'polynomial coefficients plots the poles and zeros of B(z)/A(z).',...
'As we can see, we have 4zeros (2 in 1 and 2 in -1) and 4 poles (4th order bandpass filter).',...
'All the poles are inside unity circle, so there are chances the filter to be stable.');
fprintf('\nLast updated %s\n', datestr(7.3508e+05));
keyboard; clear all; close all;
%% UnstableFilter
% V: autonomous cell;
% Lets make an unstable filter.
b = 1;
a = [1 2];
zplane(b, a); keyboard;
% That pole is definitely outside of the unit circle. What is its impulse response?
[h, t] = impz(b, a, 100);  % Get first 100 samples of impulse response
plot(t, h)
title('h[n]'); xlabel('Time (samples)');
fprintf('\nUnstable filter!!\nSee h[n] huge magnitude (x10^29).\n');
keyboard; clear all; close all;
%% Spectrogram1
% V: autonomous cell;
% V: Spectrogram plot the (real??) signal spectral analyses over time
filename = 'flute-C4.wav';
[x2 sr2] = wavread(filename);
nwin = 512; % samples in (direct fft) time [n] window
noverlap = 256; %samples overlap with previous time [n] window
nfft = 512; %samples
spectrogram(x2, nwin, noverlap, nfft, sr2, 'yaxis');
colorbar;
keyboard;
clf;
specgramdemo(x2, sr2); % V: much interactive..
keyboard; clear all; close all;