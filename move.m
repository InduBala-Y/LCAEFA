
function [X,V]=move(X,a,V)

%movement.
[dim,N]=size(X);
V=rand(dim,N).*V+a; 
X=X+V;