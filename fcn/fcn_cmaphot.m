function cmaphot = fcn_cmaphot(len)
% colormap used in paper

if nargin == 0
    len = 256;
end
cmaphot = [ones(1,3)*0.25; ones(1,3)*0.55; ones(1,3)*0.85;  1 1 0; 1.0 0.5 0; 1 0 0]; cmaphot = interp1(linspace(0,1,size(cmaphot,1)),cmaphot,linspace(0,1,len));