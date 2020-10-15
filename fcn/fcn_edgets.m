function [a,u,v] = fcn_edgets(ts,zflag)
% fcn_edgets    
%
%   [a,u,v] = fcn_edgets(ts,zflag) 
%
%   Edge time series are a time-resolved account of the co-fluctuation
%   between nodes. These time series are an intermediate step in the 
%   calculation of Pearson correlation. 
%
%   Inputs:
%       ts, 
%           time series, size: (time)x(node)
%       zflag, 
%           do z-score? (time series should be z-scored to obtain ets)
%
%   Outputs:
%       a, 
%           edge time series (ets), size: (time)x(edge)
%       u,v, 
%           variables that are helpful for indexing the resultant ets
% 

if nargin == 1
    zflag = true;
end
[~,n] = size(ts);               % number samples/nodes
if zflag
    z = zscore(ts);                 % z-score
else
    z = ts;
end
[u,v] = find(triu(ones(n),1));  % get edges
a = z(:,u).*z(:,v);             % edge ts products
