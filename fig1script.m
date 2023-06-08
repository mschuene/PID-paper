% draw separately support of gamma_x=1 and gamma_x=2 and visualize point
% on boundary. 


for scenario=1:3
    
basename = 'fig1_';
%scenario = 2;
pdescr = {'unique_int','unique_boundary','non-unique'};

filename = strcat(basename,pdescr{scenario});
load(strcat('p_',pdescr{scenario},'.mat'));


options = optimoptions('fmincon');
options.Algorithm = 'interior-point';%'sqp';%'active-set';
%options.Display = 'iter-detailed';
options.HonorBounds = true;
options.PlotFcn = @optimplotfval;
options.OptimalityTolerance = 1e-16;
options.ConstraintTolerance = 1e-16;
%p = generate_sample_dist(2,2,3);
[x,fval,x_orig,gb,igb,V,inner,arank,unique] = Min_MI_X_YZ_binary_T(p,options,true,false,true);
[x2,fval2,exitflag,output,lambda,grad,hessian,x_orig2] = Min_MI_X_YZ_gamma(p,options);
disp(inner);


Figure(1,[13,6]);%(nf)
set(0,'defaulttextinterpreter','latex')
set(0,'defaultAxesTickLabelInterpreter','latex');  
set(0,'defaultLegendInterpreter','latex');
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultAxesFontName', 'CMU Serif')


[condleq_lhs,condleq_rhs] = setup_delta_p_conditions_gamma(p,gb);
[condleq_lhs,condleq_rhs] = setup_delta_p_conditions_gamma(p,gb);
px = sum(p,[2,3]);

for i=1:2
    gbp = gb(:,igb(:,1)==i);
    gbp1 = reshape(gbp(:,1),[size(p)]);
    gbp1 = squeeze(gbp1(i,:,:));

    gbp2 = reshape(gbp(:,2),size(p));
    gbp2 = squeeze(gbp2(i,:,:));


    A = [gbp1(:),gbp2(:)];

    resolution = linspace(-0.5,0.5,300);
    [X,Y] = meshgrid(resolution,resolution);

    p1 = squeeze(p(i,:,:));
    pt = bsxfun(@(a,b) arrayfun(@(c) all((p1(:) + px(i)*A*[a;c])>=0),b),resolution,resolution');
    axs(i) = subplot(1,2,i);
    axis equal;
    contour(X,Y,double(pt),1,'black','LineWidth',2);
    
    if i == 1
        xlabel('$g_{0,0,0}$')
        ylabel('$g_{0,0,1}$')
    else
        xlabel('$g_{1,0,0}$')
        ylabel('$g_{1,0,1}$')
    end
    hold on;
    %scatter(x_orig(2*i-1)/px(i),x_orig(2*i)/px(i),500,'r.')
    if size(V,1) < 2
        scatter(x_orig2(2*i-1)/px(i),x_orig2(2*i)/px(i),30,'MarkerFaceColor','#666666')
    else
        %     for j = 1:size(V,1)
%         scatter(V(j,2*i-1)/px(i),V(j,2*i)/px(i),1000,'g.')
%     end
        scatter(V(1,2*i-1)/px(i),V(1,2*i)/px(i),30,'MarkerFaceColor','#666666')
        scatter(V(2,2*i-1)/px(i),V(2,2*i)/px(i),30,'MarkerFaceColor','#666666')

        plot([V(1,2*i-1)/px(i),V(2,2*i-1)/px(i)],...
             [V(1,2*i)/px(i),V(2,2*i)/px(i)],'color','#555555','LineWidth',3,'LineStyle',':');
    end 
end
arank;
linkaxes(axs)
%arank lower than size(x_orig) means non-uniqueness:)
%arank = 0 means solution found numerically on boundary
%suptitle(strcat('fval fval2 diff augmented rank unique: ',num2str([fval,fval2,fval-fval2,arank,unique])))
%print(gcf,filename,'-dpdf','-r0')
saveas(gcf,strcat(filename,'.eps'),'epsc');
end
