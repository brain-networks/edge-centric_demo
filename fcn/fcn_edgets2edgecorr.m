function e = fcn_edgets2edgecorr(a)
b = a'*a;                       % inter product
c = sqrt(diag(b));              % square root of variance
d = c*c';                       % normalization matrix
e = b./d;                       % divide to get correlation