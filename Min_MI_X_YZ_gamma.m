function [x,fval,exitflag,output,lambda,grad,hessian,x_orig] = Min_MI_X_YZ_gamma(p,options,use_hess)
%MIN_MI_X_YZ_GAMMA Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 2
        options = optimoptions('fmincon');
        options.Algorithm = 'interior-point';%'sqp';%'active-set';
        options.Display = 'iter-detailed';
        options.HonorBounds = true;
        options.PlotFcn = @optimplotfval;
        options.OptimalityTolerance = 1e-6;
        options.ConstraintTolerance = 1e-6;

    end
    if nargin < 3
        use_hess = true;
    end
    y0 = 1; z0 = 1;
    [cardx,cardy,cardz] = size(p);
    [gb,igb] = create_gamma_basis(y0,z0,cardx,cardy,cardz);
    [condleq_lhs,condleq_rhs] = setup_delta_p_conditions_gamma(p,gb);
    initial_value = zeros(size(gb,2),1); 
       
 
    f = @(x) gamma_objective_gradient(x,p,gb,y0,z0);
    options.SpecifyObjectiveGradient = true;
    if use_hess
        options.HessianFcn = @(x,~) hess_gamma(x,p,gb,igb,y0,z0);
    end

    [x_orig,fval,exitflag,output,lambda,grad,hessian] = ...
        fmincon(f,initial_value,condleq_lhs,condleq_rhs,[],[],[],[],[],options);
    if exitflag == -2 
        options.Algorithm = 'sqp';
        disp('WARNING! first algorithm did not find feasible point,trying again with sqp')
%         [x_orig,fval,exitflag,output,lambda,grad,hessian] = ...
%         fmincon(f,initial_value,condleq_lhs,condleq_rhs, ...
%                 [],[],[],[],[],options);
    end
    x = p + reshape(gb * x_orig,size(p));
end

