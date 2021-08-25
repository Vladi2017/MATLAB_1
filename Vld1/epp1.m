## Copyright (C) 2021 Vladimir Manolescu

## -*- texinfo -*-
## @deftypefn  {} {} epp (@var{outcomes}, @var{r})
## @deftypefnx {} {} epp (@var{outcomes}, @var{X})
## Plot probability density function (PDF) shape for empirical univariate
## @var{outcomes} at resolution @var{r}. epp = empirical_pdf_plot.
##
## @var{r} is natural scalar >= 1.
## When 2nd argument @var{X} is a vector, resolution is length(@var{X}).
## @subheading Usage example:
## @example
## @group
## exp1 = exprnd(1, 1000);
## epp(exp1, 20);
## @end group
## @end example
## @end deftypefn

## Author: MVM <mvmanol@yahoo.com>
## Description: Empirical PDF shape.

function epp1(outcomes, r)
  min1 = min(min(outcomes));
  max1 = max(max(outcomes));
  N = numel(outcomes);
  if N > numel(unique(outcomes))
    disp("There are identical samples..");
  endif
  wndinf = min1; #windowInferior
  delta = (max1 - min1) / r;
  for k = 1 : r - 1
    pdfabs(k) = length(find((outcomes >= wndinf) & (outcomes < wndinf + delta)));
    wndinf += delta;
  endfor
  pdfabs(r) = N - sum(pdfabs);
  pdfabs(r+1) = pdfabs(r);
  pdf = pdfabs / N;
  X = 0 : r;
  stairs (X, pdf);
  ylim([0 max(pdf)]);
endfunction
