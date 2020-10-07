function [e,enorm,h] = fcn_node_entropy(ci,u,v,n)
h = zeros(n,max(ci));
for i = 1:n 
    idx = u == i | v == i;
    h(i,:) = hist(ci(idx),1:max(ci));
end
p = bsxfun(@rdivide,h,sum(h,2));
e = -nansum(p.*log2(p),2);
enorm = e/log2(max(ci));