%% setup optimoptions
options = optimoptions('fmincon');
options.Display = 'iter-detailed';
options.PlotFcn = @optimplotfval;
options.MaxFunctionEvaluations = floor(1e4);

%% first, a simple 2x2x2 problem

%% randomly chosen initial condition
p = generate_sample_dist(2,2,2);
%[py,pxgy,pzgy] = dpcoords(p);
%pstart = starting_dist(py(1:(end-1)),pxgy(:,1:(end-1)),pzgy(:,1:(end-1)));
pstart = p

%% solve with optimized algorithm
options.Algorithm = 'interior-point';
options.FiniteDifferenceType = 'central';
options.FiniteDifferenceStepSize = 1e-8;
options.CheckGradients = true;

[UIX,UIZ,SI,CI,Q,fval,exitflag,output,lambda,grad,hessian,x_orig] = PID(pstart,options);%,options);

[UIX,UIZ,SI,CI]


%% higher dimensions 5x5x5
%% randomly chosen initial condition
p = generate_sample_dist(5,5,5);
[py,pxgy,pzgy] = dpcoords(p);
pstart = starting_dist(py(1:(end-1)),pxgy(:,1:(end-1)),pzgy(:,1:(end-1)));
pstart = p;

%% solve with optimized algorithm
options.Algorithm = 'interior-point';
options.FiniteDifferenceType = 'central';
options.FiniteDifferenceStepSize = 1e-8;
options.CheckGradients = true;

[UIX,UIZ,SI,CI,Q,fval,exitflag,output,lambda,grad,hessian,x_orig] = PID(pstart,options);%,options);

[UIX,UIZ,SI,CI]

%% 10x10x10 Case: 
%% randomly chosen initial condition
p = shiftdim(pmf,2);%generate_sample_dist(10,10,10);
[py,pxgy,pzgy] = dpcoords(p);
pstart = starting_dist(py(1:(end-1)),pxgy(:,1:(end-1)),pzgy(:,1:(end-1)));
%pstart = p;

%% solve with optimized algorithm 
options.Algorithm = 'interior-point';
options.FiniteDifferenceType = 'central';
options.FiniteDifferenceStepSize = 1e-7;
options.CheckGradients = true;
[UIX,UIZ,SI,CI,Q,fval,exitflag,output,lambda,grad,hessian,x_orig] = PID(pstart,options,true);%,options)
[UIX,UIZ,SI,CI]
%% solve with optimized algorithm but without use of hessian matrix
% warning may take pretty long, press stop on the figure that shows the
% progress of the minimization
%[UIX,UIZ,SI,CI,Qnohess,fval,exitflag,output,lambda,grad,hessian,x_orig] = PID(pstart,options,false);%,options)

%abs(Qnohess-Q)

%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Comparison with analytical 2x2x2 Solution %%%%%%%%%%%%%%

run explore_2x2x2_optimization.m
