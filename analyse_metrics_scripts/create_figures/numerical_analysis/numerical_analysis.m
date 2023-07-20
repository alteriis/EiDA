% i can do it logarithmically 

N = 100;
N_iter = 20;
sizes = logspace(1,5,N);

times_anal = zeros(N_iter,N);
times_cabral = zeros(N_iter,N);
%%
for i = 1:N
    for iter  = 1:N_iter
    delta = randn(round(sizes(i)),1);
    
    tic
    [vv,xx]=eigs(cos(delta-delta'),2);
    times_cabral(iter,i) = toc;

    tic
    s = sin(delta);
    c = cos(delta);
    sigma = s'*s;
    gamma = c'*c;
    xi = s'*c;
    b1 = sigma-gamma + sqrt((sigma-gamma)^2+4*xi^2);
    b1 = b1/(2*xi);
   
    b2 = sigma-gamma - sqrt((sigma-gamma)^2+4*xi^2);
    b2 = b2/(2*xi);
   
    v1_anal = c+ b1*s;
    v2_anal = c+ b2*s;
   
    e1_anal = gamma + b1*xi;
    e2_anal = gamma + b2*xi;
    times_anal(iter,i) = toc;
    
    
    
    end
end
%%

f = figure;
loglog(sizes,mean(times_anal),'color','red','linewidth',1.25);
hold on
loglog(sizes,mean(times_anal)-std(times_anal),'color','red','linewidth',0.5);
hold on
loglog(sizes,mean(times_anal)+std(times_anal),'color','red','linewidth',0.5);
hold on
loglog(sizes,mean(times_cabral),'color','black','linewidth',1.25);
hold on
loglog(sizes,mean(times_cabral)-std(times_cabral),'color','black','linewidth',0.5);
hold on
loglog(sizes,mean(times_cabral)+std(times_cabral),'color','black','linewidth',0.5);
set(gca,'fontname','arial') 
set(gca,'fontsize',8.5)
f.Position = [100 100 267 228];
xlabel('size matrix');
ylabel('time for computation (s)');
grid on
saveas(f,'numerical_analysis.fig');

%%
save('times','times_cabral','times_anal');
