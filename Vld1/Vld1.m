# Complex plane.
compass([1,j,1+j]); title("compass([1,j,1+j])"); keyboard; ##pause;
compass([1,1*j]); title("compass([1,1*j])"); keyboard;
compass([pi/6*j]); title("compass([pi/6*j])"); keyboard;
compass([pi/6*j, exp(pi/6*j)]);title("compass([pi/6*j, exp(pi/6*j)])"); keyboard;
compass([pi/6*j, exp(pi/6*j), exp(pi/6*j)*j]);
title("compass([pi/6*j, exp(pi/6*j), exp(pi/6*j)*j])\n...
multply by j means pi/2 forward."); keyboard;
compass([pi/6*j, exp(pi/6*j), exp(pi/6*j)*j, exp(pi/6*j)/j]);
title("compass([pi/6*j, exp(pi/6*j), exp(pi/6*j)*j, exp(pi/6*j)/j])\n...
division by j mens pi/2 backwards."); keyboard;
compass(cos(pi/6)); keyboard;
compass([cos(pi/6), j*sin(pi/6)]); keyboard;
compass([cos(pi/6), j*sin(pi/6), cos(pi/6)+j*sin(pi/6)]);
title("compass([cos(pi/6), j*sin(pi/6), cos(pi/6)+j*sin(pi/6)])"); keyboard;
compass([cos(pi/3),cos(pi/3)*exp(-j*pi/6)]);
title("compass([cos(pi/3),cos(pi/3)*exp(-j*pi/6)]);");