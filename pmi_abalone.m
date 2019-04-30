tstart = tic;
tbl = readtable('abalone.data','Filetype','text',...
     'ReadVariableNames',false);
tbl.Properties.VariableNames = {'Sex','Length','Diameter','Height',...
     'WWeight','SWeight','VWeight','ShWeight','NoShellRings'};
 gprMdl = fitrgp(tbl,'NoShellRings','KernelFunction','ardsquaredexponential',...
      'FitMethod','sr','PredictMethod','fic','Standardize',1);
  [ypred,ysd] = resubPredict(gprMdl);
  figure();
plot(tbl.NoShellRings,'r.');
hold on
plot(ypred,'b.');
xlabel('x');
ylabel('y');
legend({'data','predictions'},'Location','Best');
axis([0 4300 0 30]);
hold off;

sd = (tbl.NoShellRings-ypred).^2;
sum(sd)/numel(sd)
toc(tstart)