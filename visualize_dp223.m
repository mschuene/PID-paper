% draw separately support of gamma_x=1 and gamma_x=2 and visualize point
% on boundary. 

Figure(1,(19.2/16)*[16,12]);%(nf)
set(0,'defaulttextinterpreter','latex')
set(0,'defaultAxesTickLabelInterpreter','latex');  
set(0,'defaultLegendInterpreter','latex');
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultAxesFontName', 'CMU Serif')



options = optimoptions('fmincon');
options.Algorithm = 'interior-point';%'sqp';%'active-set';
options.Display = 'iter-detailed';
options.HonorBounds = true;
options.PlotFcn = @optimplotfval;
options.OptimalityTolerance = 1e-16;
options.ConstraintTolerance = 1e-16;
%p = generate_sample_dist(2,2,3);
[x,fval,x_orig,gb,igb,V,inner,arank,unique] = Min_MI_X_YZ_binary_T(p,options,true,false,true);
[x2,fval2,exitflag,output,lambda,grad,hessian,x_orig2] = Min_MI_X_YZ_gamma(p,options);
disp(inner);

[condleq_lhs,condleq_rhs] = setup_delta_p_conditions_gamma(p,gb);
[condleq_lhs,condleq_rhs] = setup_delta_p_conditions_gamma(p,gb);
Figure()
for i=1:2
    gbp = gb(:,igb(:,1)==i);
    gbp1 = reshape(gbp(:,1),[size(p)]);
    gbp1 = squeeze(gbp1(i,:,:));

    gbp2 = reshape(gbp(:,2),size(p));
    gbp2 = squeeze(gbp2(i,:,:));


    A = [gbp1(:),gbp2(:)];

    resolution = linspace(-0.2,0.2,200);
    [X,Y] = meshgrid(resolution,resolution);

    p1 = squeeze(p(i,:,:));
    pt = bsxfun(@(a,b) arrayfun(@(c) all((p1(:) + A*[a;c])>=0),b),resolution,resolution');
    subplot(1,2,i);
    axis equal;
    contour(X,Y,double(pt),1,'black','LineWidth',5);
    
    if i == 1
        xlabel('lambda 1 (x=1)')
        ylabel('lambda 2 (x=1)')
    else
        xlabel('lambda 3 (x=2)')
        ylabel('lambda 4 (x=2)')
    end
    hold on;
    scatter(x_orig(2*i-1),x_orig(2*i),500,'r.')
    scatter(x_orig2(2*i-1),x_orig2(2*i),500,'g.')
    for j = 1:size(V,1)
        scatter(V(j,2*i-1),V(j,2*i),1000,'k.')
    end
end
arank
%arank lower than size(x_orig) means non-uniqueness:)
%arank = 0 means solution found numerically on boundary
suptitle(strcat('fval fval2 diff augmented rank unique: ',num2str([fval,fval2,fval-fval2,arank,unique])))