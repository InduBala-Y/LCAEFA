%  Traning Feed-forward Neural Networks using LCAEFA   %
 
function o=Levy_new(n,dim)

beta=2; %3/2, 1

sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
u=randn(1,dim)*sigma;
v=randn(1,dim);
step=u./abs(v).^(1/beta);
%     stepsize=0.01*step.*(X-best);
%     s=s+stepsize.*randn(size(s));

o=0.01*step;%0.01