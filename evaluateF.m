 
function   fitness=evaluateF(X,fobj)

[dim,N]=size(X);
for i=1:N 
    L=X(:,i)';
    %calculation of objective function
    fitness(i)=fobj(L);
end