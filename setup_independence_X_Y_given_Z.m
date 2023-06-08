function [A,b] = setup_independence_X_Y_given_Z(p,gb,igb,y0,z0)

% encodes constraint A*gb_coords = b such that 
% q(t,x,y) = q(t,x)q(x,y)
[cardx,cardy,cardz] = size(p);
A = zeros(cardx*cardy*cardz,size(gb,2));
b = zeros(cardx*cardy*cardz,1);
pxz = squeeze(sum(p,2))
pz = repmat(sum(pxz,1),[cardx,1]);
pxz = pxz./pz; %noy pxz is pof x given z
pyz = squeeze(sum(p,1));
i = 0;
% y_p = 1:cardy;
% y_p = y_p(y_p~=y0);
% 
% z_p = 1:cardz;
% z_p = z_p(z_p~=z0);

[X,Y,Z] = meshgrid(1:cardx,1:cardy,1:cardz);
% rgb contains X,Y,Z,Gamma as axes
rgb = reshape(gb,[cardx,cardy,cardz,size(gb,2)]);
for x = 1:cardx
    x2 = 3-x; %works since x is binary
    for y = 1:cardy
         for z = 1:cardz
                i = i + 1;
                b(i) = pxz(x,z)*pyz(y,z)-p(x,y,z);
                r = squeeze(rgb(x,y,z,:))*(1-pxz(x,z))-squeeze(rgb(x2,y,z,:))*pxz(x,z);
                A(i,:) = r;
%                 if (y==y0 && z==z0)
%                     [Y,Z] = meshgrid(y_p,z_p);
%                     inds1 = zeros(cardy-1+cardz-1,3);
%                     inds1(:,1) = x;
%                     inds1(:,2:3) = [Y(:),Z(:)];
%                     A(i,ismember(igb,inds1,'rows')) = 1-pxz(x,z);
%                     inds2 = inds1;
%                     inds2(:,1) = x2;
%                     A(i,ismember(igb,inds2,'rows')) = -pxz(x,z);
%                     continue;    
%                 end
%                 if (y==y0)
%                     inds1 = zeros(cardy-1,3);
%                     inds1(:,1) = x;
%                     inds1(:,2) = y_p;
%                     inds1(:,3) = z;
%                     A(i,ismember(igb,inds1,'rows')) = -(1-pxz(x,z));
%                     inds2 = inds1;
%                     inds2(:,1) = x2;
%                     A(i,ismember(igb,inds2,'rows')) = pxz(x,z);
%                     continue;    
%                 end
%                 if (z==z0)
%                     inds1 = zeros(cardz-1,3);
%                     inds1(:,1) = x;
%                     inds1(:,3) = z_p;
%                     inds1(:,2) = y;
%                     A(i,ismember(igb,inds1,'rows')) = -(1-pxz(x,z));
%                     inds2 = inds1;
%                     inds2(:,1) = x2;
%                     A(i,ismember(igb,inds2,'rows')) = pxz(x,z);                    
%                     continue; 
%                 end
%                 A(i,ismember(igb,[x,y,z],'rows')) = (1-pxz(x,z));
%                 A(i,ismember(igb,[x2,y,z],'rows')) = -pxz(x,z);
         end
     end
end


end