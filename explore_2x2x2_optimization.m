options = optimoptions('fmincon');
options.Display = 'iter-detailed';
options.Algorithm='interior-point';
options.MaxFunctionEvaluations = floor(1e4);

global HISTORY;
HISTORY.x = [];
HISTORY.fval = [];
options.OutputFcn = @store_optimization_path;

a = rand;b=rand;c=rand;d=rand;e=rand;

flb = -min([a.*b.*d,a.*(1-b).*(1-d)]),fub = min([a.*b.*(1-d),a.*(1-b).*d])
glb = -min([(1-a).*c.*e,(1-a).*(1-c).*(1-e)]),gub=min([(1-a).*c.*(1-e),(1-a).*(1-c).*e])

fl = linspace(flb,fub,100);
gl = linspace(glb,gub,100);
[f,g] = ndgrid(fl,gl);

pand_start = starting_dist(a,[b;c],[d;e]);
GB = create_gamma_basis(1,1,2,2,2);

[UIY,UIZ,SI,CI,Q,fval,exitflag,output,lambda,grad,hessian,x_orig] = PID(pand_start,options);
Q;

x_orig
grad;

[x_orig2,Q2] = binary_analytical(a,b,c,d,e);

x_orig2
Q2;

% 
% gg = arrayfun(@(f,g) calculate_gamma_gradient(pand_start(:) + GB*[f;g]),f,g,'UniformOutput',false);
% 
% 
% res = arrayfun(@(x)x{:}(1),gg);
% res2 = arrayfun(@(x)x{:}(2),gg);

%res = log2(((a.*b.*d + f).*(a.*(1 - b).*(1 - d) + f))./((a .* (1 - b).*d - f).*(a .* b .* (1 - d) - f)) .* ((a.*(1 - b).*d + (1 - a).*(1 - c).*e - f-g) .* (a.*b.*(1 - d) + (1 - a).*c.*(1 - e) - f - g))./((a.*b.*d + (1 - a).*c.*e + f + g).*(a.*(1 - b).*(1 - d) + (1 - a).*(1 - c).*(1 - e) + f + g)));
%res2 = log2((((1-a).*c.*e + g).*((1-a).*(1 - c).*(1 - e) + g))./(((1 - a) .* (1 - c).*e - g).*((1-a) .* c .* (1 - e) - g)) .* ((a.*(1 - b).*d + (1 - a).*(1 - c).*e - f-g) .* (a.*b.*(1 - d) + (1 - a).*c.*(1 - e) - f - g))./((a.*b.*d + (1 - a).*c.*e + f + g).*(a.*(1 - b).*(1 - d) + (1 - a).*(1 - c).*(1 - e) + f + g)));

% plot res
path = HISTORY.x';
hold off
% figure(1) 
% surf(fl,gl,res)
% xlabel('f');
% ylabel('g');
% zlim([-10,10]);
% caxis([-10,10]);
% colorbar;
% hold on;
% plot3(path(:,1),path(:,2),2*ones(size(HISTORY.x,2)),'r')
% figure(2)
% hold off;
% surf(fl,gl,res2)
% xlabel('f');
% ylabel('g');
% zlim([-10,10]);
% caxis([-10,10]);
% colorbar;
% hold on;
% plot3(path(:,1),path(:,2),2*ones(size(HISTORY.x,2)),'r')
% figure(3)
% Z = zeros(size(res));
% Z(res2 < 0 & res < 0) = 1;
% Z(res2 >= 0 & res < 0) = 2;
% Z(res2 < 0 & res >= 0) = 3;
% Z(res2 >= 0 & res >= 0) = 4;
% caxis([0,4])
% surf(gl,fl,Z)
% xlabel('g')
% ylabel('f')
% colorbar
% hold on;
% plot3(path(:,2),path(:,1),4.1*ones(size(HISTORY.x,2)),'r')
% hold off
% figure(2)
% hold off
% figure(1)
% hold off
p = pand_start./repmat(sum(pand_start,1),[2,1,1]);
Qxgyz = Q./repmat(sum(Q,1),[2,1,1]);
Qyzgx = Q./repmat(sum(sum(Q,3),2),[1,2,2]);


MI = bsxfun(@(a,b) arrayfun(@(c) MI_X_YZ(pand_start(:) + GB*[a;c]),b),fl,gl');
surfc(fl,gl,MI);
view(2)
title(strcat('[a,b,c,d,e] = ',num2str([a,b,c,d,e])))
xlabel('\lambda_1');
ylabel('\lambda_2');
colorbar;
hold on;
plot3(path(:,1),path(:,2),ones(size(HISTORY.x,2)),'r')
plot3(x_orig2(1),x_orig2(2),1,'rx','markers',12)
hold off;