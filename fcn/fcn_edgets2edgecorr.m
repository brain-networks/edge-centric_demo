function e = fcn_edgets2edgecorr(a)
% fcn_edgets2edgecorr
%
%   e = fcn_edgets2edgecorr(a)
%
%   Edge functional connectivity (eFC) is the normalized dot product
%   between two edge times series
%
%   Inputs:
%       a, 
%           edge time series, size: (time)x(edge)
%
%   Outputs:
%       e,
%           eFC matrix, size: (edge)x(edge)
% 

b = a'*a;                       % inter product
c = sqrt(diag(b));              % square root of variance
d = c*c';                       % normalization matrix
e = b./d;                       % divide to get correlation