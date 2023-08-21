% AEFA code v1.1.

function  X=space_bound(X,up,low);

[dim,charge_num]=size(X);
for i=1:charge_num 
    Tp=X(:,i)>up;Tm=X(:,i)<low;X(:,i)=(X(:,i).*(~(Tp+Tm)))+up.*Tp+low.*Tm;
end


end