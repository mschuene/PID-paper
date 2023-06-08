function [A,b] = setup_independence_X_Z_given_Y(p,gb,igb,y0,z0)

% encodes constraint A*gb_coords = b such that 
% q(t,x,y) = q(t,x)q(x,y)
[cardx,cardy,cardz] = size(p);
A = zeros(cardx*cardy*cardz,size(gb,2));
b = zeros(cardx*cardy*cardz,1);
pxy = squeeze(sum(p,3));
py = repmat(sum(pxy,1),[cardx,1]);
pxy = pxy./py; %now pxy is pof x given y
pyz = squeeze(sum(p,1));
i = 0;

% [X,Y,Z] = meshgrid(1:cardx,1:cardy,1:cardz);
% rgb contains X,Y,Z,Gamma as axes
rgb = reshape(gb,[cardx,cardy,cardz,size(gb,2)]);
for x = 1:cardx
    x2 = 3-x; %works since x is binary
    for y = 1:cardy
         for z = 1:cardz
                i = i + 1;
                b(i) = pxy(x,y)*pyz(y,z)-p(x,y,z);
                A(i,:) = squeeze(rgb(x,y,z,:))*(1-pxy(x,y))-squeeze(rgb(x2,y,z,:))*pxy(x,y);
         end
     end
end


end