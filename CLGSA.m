function [Fbest,Lbest,BestChart,MeanChart]=CLGSA(F_index,N,max_it,ElitistCheck,min_flag,Rpower)

%V:   Velocity.
%a:   Acceleration.
%M:   Mass.  Ma=Mp=Mi=M;
%dim: Dimension of the test function.
%N:   Number of agents.
%X:   Position of agents. dim-by-N matrix.
%R:   Distance between agents in search space.
%[low-up]: Allowable range for search space.
%Rnorm:  Norm in eq.8.
%Rpower: Power of R in eq.7.
 
 Rnorm=2; 
 
%get allowable range and dimension of the test function.
[low,up,dim]=test_functions_range(F_index); 
Xmin=low;
Xmax=up;
D=dim;

%random initialization for agents.
X=initialization(dim,N,up,low); 
ps=N, n=dim;
%create the best so far chart and average fitnesses chart.
BestChart=[];MeanChart=[];

V=zeros(N,dim);

for iteration=1:max_it
%     iteration
    
    %Checking allowable range. 
    X=space_bound(X,up,low); 
    %Evaluation of agents. 
    fitness=cec13_func(X',F_index);%evaluateF(X,F_index); 
    pbestval = fitness;
    
% %     if min_flag==1
    [best best_X]=min(fitness); %minimization.
    
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Comprehensive learing 
%         t = 0 : 1 / (ps - 1) : 1;
%         t = 5 .* t;
%         Pc = 0.0 + (0.5 - 0.0) .* (exp(t) - exp(t(1))) ./ (exp(t(ps)) - exp(t(1)));
%          ar = randperm(N);
%          for k=1:N
%            % ai(k, ar(m(k),1)) = 1;
%             fi1 = ceil(ps * rand(N, 1));
%             fi2 = ceil(ps * rand(N, 1));
%             fi = (pbestval(fi1) < pbestval(fi2))' .* fi1 + (pbestval(fi1) >= pbestval(fi2))' .* fi2;
%             bi = ceil(rand(N,1) - 1 + Pc(k));
% % 
% %             if bi == zeros(N,1),
% %                 rc = randperm(N);
% %                 bi(rc(1)) = 1;
% %             end
% 
% %             pbestval(k,:) = bi.*fi + (1 - bi).* pbestval(k,:);
%          end
%          pbestval=fi;
%       [best best_X]=min(pbestval);
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
 
%     else
%     [best best_X]=max(fitness); %maximization.
%     end        
%[N dim]=size(X);
Pc=0.9;X_b=[];
for d=1:dim
    if rand()<Pc
        X1=X(ceil(rand*N),:);
        X2=X(ceil(rand*N),:);
        F1=cec13_func(X1',F_index);% evaluateF(X1,F_index)
        F2=cec13_func(X2',F_index); %evaluateF(X2,F_index);
        
        if F1<F2
            X_b = [X_b X1(d)];
        else
            X_b=[X_b X2(d)];
        end 
        
    else 
        [Fb idz1]=min(fitness);
        X_b=[X_b X(idz1,d)];
    end
end     
 C_F=cec13_func(X_b',F_index);%evaluateF(X_b,F_index)


    if iteration==1
       Fbest=best;Lbest=X(best_X,:);
    end
    if min_flag==1
      if best<Fbest  %minimization.
       Fbest=best;Lbest=X(best_X,:);
      end
    else 
      if best>Fbest  %maximization
       Fbest=best;Lbest=X(best_X,:);
      end
    end
      if C_F<Fbest
          Lbest=X_b;Fbest=C_F; 
         [~, idx5]=max(fitness);
         X(idx5,:)=Lbest;
      end 
BestChart=[BestChart Fbest];
MeanChart=[MeanChart mean(fitness)];

%Calculation of M. eq.14-20
[M]=massCalculation(fitness,min_flag,X,F_index); 

%Calculation of Gravitational constant. eq.13.
G=Gconstant(iteration,max_it); 

%Calculation of accelaration in gravitational field. eq.7-10,21.
a=Gfield(M,X,G,Rnorm,Rpower,ElitistCheck,iteration,max_it);

%Agent movement. eq.11-12
[X,V]=move(X,a,V,Lbest);
end %iteration
gb=[-1400 -1300 -1200 -1100 -1000 -900 -800 -700 -600 -500 -400 -300 -200 -100 100 200 300 400 500 600 700 800 ...
900 1000 1100 1200 1300 1400];
i_d=F_index;
R1=abs(Fbest-gb(F_index));
R2=max(abs(fitness-gb(F_index)));
R3=mean(abs(fitness-gb(F_index)));
R4=std(abs(fitness-gb(F_index)));
RESULT =[R1 R2 R3 R4];
%save('CLGSA_Error_30D_01_Runs.txt', 'RESULT', '-ASCII','-append')
% tim=toc;
% save('T2_50D.txt', 'tim', '-ASCII','-append')








