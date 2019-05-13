%%Signals1
1; %Prevent Octave from thinking that this is a function file
function y = mystep1(x)
	y = x;
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
t = -5:1:5; %range var
step0 = mystep1(t);
stem(t,step0);
keyboard;
figure;
%delayed step function:
step0del2 = mystep1(t-2)
stem(t,step0del2);	% time t is a vector..
keyboard;
figure;
y1 = step0 + step0del2;
stem(t,y1);
% Vld. how to define a "delay" block??
%tsim