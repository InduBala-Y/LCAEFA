
function a=Kfield(Q,X,K,Rnorm,Rpower,ElitistCheck,iteration,Max_Iteration);

[dim,N]=size(X);
 final_per=2; %In the last iteration, only 2 percent of agents apply force to the others.

%%%%total force calculation
 if ElitistCheck==1
     kbest=final_per+(1-iteration/Max_Iteration)*(100-final_per); 
     kbest=round(N*kbest/100);
 else
     kbest=N; 
 end
    [Qs ds]=sort(Q,'descend');

 for i=1:N
     E(:,i)=zeros(1,dim);
     for ii=1:kbest
         j=ds(ii);
         if j~=i
            R=norm(X(:,i)-X(:,j),Rnorm); %Euclidian distanse.
         for k=1:dim 
             E(k,i)=E(k,i)+rand*(Q(j))*((X(k,j)-X(k,i))/(R^Rpower+eps));
              %note that Qp(i)/Qi(i)=1
         end
         end
     end
 end

%%acceleration
a=E.*K; %note that Qp(i)/Qi(i)=1