function [sq,pd] = fcn_profilesim(mat)
hdl = @(x,y)(mean(x~=y,2));
pd = pdist(mat,hdl);
sq = 1 - squareform(pd);