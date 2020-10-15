function [sq,pd] = fcn_profilesim(mat)
% fcn_profilesim
%   
%   [sq,pd] = fcn_profilesim(mat)
%
%   The community profile similarity measures the similarity of edge
%   communities at each node
% 
%   Inputs:
%       mat, 
%           edge communits in the nxn space
%   Outputs:
%       sp,
%           community similarity, squareform
%       pd,
%           community similarity, vector form
% 

hdl = @(x,y)(mean(x~=y,2));
pd = pdist(mat,hdl);
sq = 1 - squareform(pd);