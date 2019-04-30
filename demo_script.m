m = 1;
e = [0,0,0];
t = [0,0,0];
for M = [10,50,100]
tstart = tic;
a = importdata('abalone.data')
x = a.data(:,[1:7])
v = [1:4177];
y = a.data(:,[8])
% load demo data set (1D inputs for easy visualization -
% this script should work fine for multidimensional inputs)

%x = load('train_inputs');
%y = load('train_outputs');
%xtest = load('test_inputs');
xtest = x
me_y = mean(y); y0 = y - me_y; % zero mean the data

[N,dim] = size(x);

%M = 100; % number of pseudo-inputs

% initialize pseudo-inputs to a random subset of training inputs
[dum,I] = sort(rand(N,1)); clear dum;
I = I(1:M);
xb_init = x(I,:);

% initialize hyperparameters sensibly (see spgp_lik for how
% the hyperparameters are encoded)
hyp_init(1:dim,1) = -2*log((max(x)-min(x))'/2); % log 1/(lengthscales)^2
hyp_init(dim+1,1) = log(var(y0,1)); % log size 
hyp_init(dim+2,1) = log(var(y0,1)/4); % log noise

% optimize hyperparameters and pseudo-inputs
w_init = [reshape(xb_init,M*dim,1);hyp_init];
[w,f] = minimize(w_init,'spgp_lik',-200,y0,x,M);
%[w,f] = lbfgs(w_init,'spgp_lik',200,10,y0,x,M); % an alternative
xb = reshape(w(1:M*dim,1),M,dim);
hyp = w(M*dim+1:end,1);


% PREDICTION
[mu0,s2] = spgp_pred(y0,x,xb,xtest,hyp);
mu = mu0 + me_y; % add the mean back on
% if you want predictive variances to include noise variance add noise:
s2 = s2 + exp(hyp(end));


%%%%%%%%%
% Plotting - just for 1D demo - remove for real data set
% Hopefully, the predictions should look reasonable

 f1 = figure();
hold on
plot(v,y,'.m') % data points in magenta
plot(v,mu,'b.') % mean predictions in blue
%plot(v,mu+2*sqrt(s2),'r-') % plus/minus 2 std deviation
                              % predictions in red
%plot(v,mu-2*sqrt(s2),'r-')
% x-location of pseudo-inputs as black crosses
plot(I,-2.75*ones(size(xb)),'k+','markersize',10)
xlabel('x');
ylabel('y');
title('SPGP (M = 10)')
legend({'data','predictions','Markers'},'Location','Best');
hold off
e(m) = sum((mu-y).*(mu-y))/numel(s2)
t(m) = toc(tstart)
m = m+1;
end