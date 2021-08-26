## Copyright (C) 2021 Vladimir Manolescu

## -*- texinfo -*-
## @deftypefn  {} {} epp (@var{outcomes}[, @var{r}])
## @deftypefnx {} {} @var{pdfVec} = epp (@var{outcomes}[, @var{r}])
## @deftypefnx {} {} [@var{pdfVec}, @var{cdfVec}] = epp (@var{outcomes}[, @var{r}])
## Plot probability density function (PDF) and cumulative DF (CDF) shape for
## empirical univariate @var{outcomes} at resolution @var{r}. epp = empirical_pdf_plot.
##
## @var{r} is natural scalar >= 1, with default value 64.
## @subheading Usage example:
## @example
## @group
## exp1 = exprnd(1, 1000);
## epp(exp1, 128);
## @end group
## @end example
## @end deftypefn

## Author: MVM <mvmanol@yahoo.com>
## Description: Empirical PDF shape.

function [pdfV, cdfV] = epp1(outcomes, r = 64)
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
  X = min1 : delta : max1;
  figure;
  subplot(2,1,1);
  stairs (X, pdf);
  ylim([0 max(pdf)]); title("PDF");
  if nargout >= 1
    pdfV = pdf(1:end-1); #pdfVec, sum(pdfV) should be 1.
  endif
  cdf(1) = pdf(1);
  for k = 2 : r
    cdf(k) = cdf(k-1) + pdf(k); #cdf = ∫pdf
  endfor
  cdf(r+1) = cdf(r);
  subplot(2,1,2);
  stairs (X, cdf); title("CDF");
  if nargout == 2
    cdfV = cdf(1:end-1); #cdfVec, cdfV(end) should be 1.
  endif
endfunction
