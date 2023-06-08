function [UIY,UIZ,SI,CI,Q,fval,exitflag,output,lambda,grad,hessian,x_orig] = PID(p,options,use_hessian)
%PID Summary of this function goes here
%   Detailed explanation goes here

% if nargin < 2
%     [Q,fval,exitflag,output,lambda,grad,hessian,x_orig,HISTORY] = Min_MI_X_YZ_gamma(p);
% end
% if ischar(Q) 
%     if nargin == 3
%        [Q,fval,exitflag,output,lambda,grad,hessian,x_orig,HISTORY] = Min_MI_X_YZ_gamma(p,Q,1,1,starting_point);
%     else
%        [Q,fval,exitflag,output,lambda,grad,hessian,x_orig,HISTORY] = Min_MI_X_YZ_gamma(p,Q);
%     end
% end
if nargin < 2
    [Q,fval,exitflag,output,lambda,grad,hessian,x_orig] = Min_MI_X_YZ_gamma(p);
elseif nargin < 3
    [Q,fval,exitflag,output,lambda,grad,hessian,x_orig] = Min_MI_X_YZ_gamma(p,options);
else
    [Q,fval,exitflag,output,lambda,grad,hessian,x_orig] = Min_MI_X_YZ_gamma(p,options,use_hessian);
end

if min(Q(:)) < 0
    disp('warning Q has negative entries, renormalizing')
    Q = Q + max(-min(Q(:),0));
    Q = Q ./ sum(Q(:));
end

CI = real(calc_CI(p,Q));
UIY = real(MI_X_Y_given_Z(Q));
UIZ = real(MI_X_Z_given_Y(Q));
SI = real(MI_X_YZ(p) - CI - UIY - UIZ);

end

