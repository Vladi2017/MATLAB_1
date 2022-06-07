## Copyright (C) 2021 Vladimir Manolescu

## -*- texinfo -*-
## @deftypefn  {} {} eup (@var{outcomes}[, @var{r}[, @var{fig}[, @var{interval}]]])
## @deftypefnx {} {} @var{pdfVec} = eup (@var{outcomes}[, @var{r}[, @var{fig}[, @var{interval}]]])
## @deftypefnx {} {} [@var{pdfVec}, @var{cdfVec}] = eup (@var{outcomes}[, @var{r}[, @var{fig}[, @var{interval}]]])
## Plot probability density function (PDF) and cumulative distribution function (CDF) shape for
## empirical univariate @var{outcomes} at resolution @var{r}. New plots may be added in the same figure
## with @var{fig} parameter.
## eup = empirical_univariate_plot.
##
## @var{r} is natural scalar >= 1, with default value 100 (sub-intervals).
## @var{interval}: [xmin xmax], (study) interval.
## @subheading DEMOs:
## @example
## @group
## Exponential distribution:
## pkg load statistics; #unless loaded already
## lambda = single(1);
## exp1 = exprnd(lambda, 1000);
## lambda = single(1.5);
## exp15 = exprnd(lambda, 1000);
## eup(exp1, :, :, [0 5]); # suppose create figure 2.
## eup(exp15, :, 2, [0 5]); # plot in figure 2 (3rd param).
## eup(exp1, :, :, [0.3 4]); # suppose create figure 1.
## eup(exp15, :, 1, [0.3 4]); # plot in figure 1 (3rd param).
## 
## Uniform distribution:
## urnd = rand(1000, "single");
## eup(urnd);
## eup(urnd, 50, :, [0.2 0.5]);
##
## Normal (Gaussian) distribution:
## (standard) normally distributed random elements (zero mean and variance one):
## nrnd = randn(1000, "single"); # 1e6 elements.
## eup(nrnd);
## eup(nrnd, 50, :, [-1 1]); #zone with 68.2% probability (+/-sigma).
## @end group
## @end example
## @end deftypefn

## Author: MVM <mvmanol@yahoo.com>
## Description: Empirical probability distribution plots.

function [pdfV, cdfV] = eup(outcomes, r = 100, fig = 1000, itv)
  N = numel(outcomes);
  if (nargin == 4)
    assert(size(itv)==[1 2], "the scope must be [min max]");
    min1 = itv(1);  # itv = (study) interval
    max1 = itv(2);
    N2 = length(find((outcomes >= min1) & (outcomes <= max1)));
  else
    min1 = min(min(outcomes));
    max1 = max(max(outcomes));
    N2 = N;
  endif
  if N > numel(unique(outcomes))
    disp("note: There are identical samples..");
  endif
  # if (nargin == 4)
  wndinf = min1; #windowInferior
  delta = (max1 - min1) / r;
  for k = 1 : r
    pdfabs(k) = length(find((outcomes >= wndinf) & (outcomes < wndinf + delta)));
    wndinf += delta;
  endfor
  X = min1 : delta : max1;
  if (numel(pdfabs) < numel(X))
    pdfabs(r+1) = N2 - sum(pdfabs);
  endif
  pdf = pdfabs / N;
  if (fig == 1000)
    figure;
  else
    figure(fig);
    hold on;
  endif
  subplot(2,1,1);
  if (fig != 1000)
    hold on;
  endif
  stairs (X, pdf, "displayname", inputname(1));
  legend off;
  ylim([0 max(pdf)]); title("PDF");
  if nargout >= 1
    pdfV = pdf(1:end-1); #pdfVec, sum(pdfV) should be 1.
  endif
  legend show;
  hold off;
  cdf(1) = pdf(1);
  for k = 2 : r
    cdf(k) = cdf(k-1) + pdf(k); #cdf = ∫pdf
  endfor
  if (numel(cdf) < numel(X))
    cdf(r+1) = cdf(r);
  endif
  subplot(2,1,2);
  if (fig != 1000)
    hold on;
  endif
  stairs (X, cdf); title("CDF");
  hold off;
  if nargout == 2
    cdfV = cdf(1:end-1); #cdfVec, cdfV(end) should be 1.
  endif
endfunction
