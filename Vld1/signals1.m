%%Signals1
1; %Prevent Octave from thinking that this is a function file
function y = mystep1(x)
	%y = x;
	for i = 1:length(x)
		switch(x(i) >= 0)
			case 1	%true
				y(i) = 1;
			otherwise
				y(i) = 0;
		endswitch
	endfor
endfunction
%step function:
t = -5:1:5; %range var, time vector.
step0 = mystep1(t);
stem(t,step0);
title("x[n]"); xlabel('Time vector n');
keyboard;
figure;
%delayed step function:
step0del2 = mystep1(t-2);
stem(t,step0del2);	% time t is a vector..
title("y[n]=x[n-2]"); xlabel('Time vector n');
keyboard;
figure;
y1 = step0 + step0del2;
stem(t,y1); title("y1[n]=x[n]+y[n]=x[n]+x[n-2]"); xlabel('Time vector n');
% Vld. how to define a "delay" block??
%tsim
%%Vld. Ideas: signals defined by a 2 rows matrix (values and time vectors).
%%elementarry function/processing block, with 0 or one inputs and one output.
%%node: connected to one output and multiple inputs.