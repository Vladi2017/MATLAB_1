%The Scientist and Engineer's Guide in Digital Signal Processing, chapter 31, pg.567 (see also chapter 8, The DFT).
%Vld. We'll try to synthesis x[n], after apply equations 31-1/pg567 (so, from ReX[k]) and ImX[k] arrays).
x=[0,0,0,43,-18,-10,-5,-2,0,0,0,0,0,0,0,0]; %see fig.8-1a/chapter.8/pg.142
n=0:1:15; %n vector (range)
stem(n,x);
title("x[n]"); xlabel('Time row vector n, N points, 0 - N-1');
N=length(x);%number of samples in x[n] signal.
ReX=zeros(1,N/2+1);%one line with N/2+1 columns, see eq.31-1/pg.567, k span [0:N/2)
ImX=zeros(1,N/2+1);% --""--
circ_k1 = 2*pi*n/N; %N points row vector on unitCircle for frequency k=1, span [0 - 2pi-(1/N)pi]
for k = 0:1:N/2 %N/2+1 values, see eq.31-1/pg.567, k span [0:N/2);
  ReX(k+1) = 2/N*sum(x.*cos(circ_k1*k));%it should be ReX(k), but we don't have 0 based indexing support
  ImX(k+1) = 2/N*sum(x.*sin(circ_k1*k));
endfor;
ReX(0+1) = ReX(0+1)/2;%see eq.8-3/page.153
ReX(N/2+1) = ReX(N/2+1)/2;% --""--. Remember, we don't have 0 based indexing support, so we must "+1".
figure; stem(0:k,ReX); title("ReX[k]"); xlabel('Frequency row vector k, N/2+1 points, 0 - N/2');
figure; stem(0:k,ImX); title("ImX[k]"); xlabel('Frequency row vector k, N/2+1 points, 0 - N/2');
disp("Frequency kMax = N/2. I suppose it is in relation with Nyquist theorem. To check..");
disp("Now synthesis xSyn based on frequencies ReX and ImX vectors, and compare with x.");
xSyn = zeros(1,N);
k = 0:N/2;
circ_n1=2*pi*k/N;%k points (N/2+1) row vector for time i=1, span [0 - pi]
for i = 0:1:N-1
  xSyn(i+1) = sum(ReX.*cos(circ_n1*i)) + sum(ImX.*sin(circ_n1*i));
endfor;
figure; stem(n,xSyn); title("xSyn[n]. compare with x[n]."); xlabel('Time row vector n, N points, 0 - N-1');
%>> sum(cos(circ_k1*3).*cos(circ_k1*5))
%ans =   -1.0825e-15 Vld. orthogonality property of basis functions signals