function [ gamma_basis,igb] = create_gamma_basis(y0,z0,cardx,cardy,cardz)
%create_gamma_basis creates the gamma-basis of ker(A)
%   In each colum, the flattened gamma probability distribution
%   with specified x,y,z, is stored. The association of x,y,z to
%   the column number of the respective gamma basis is stored in igb
    gamma_basis = zeros(cardx*cardy*cardz,cardx*(cardy - 1)*(cardz -1));
    igb = zeros(cardx*(cardy - 1)*(cardz - 1),3); %save what xyz direction is at what position
    i = 0;
    for x = 1:cardx
        for y = 1:cardy
            if(y ~= y0)
                for z = 1:cardz
                    if z ~= z0
                        i = i + 1;
                        gd =  zeros(cardx,cardy,cardz);
                        gd(x,y0,z0) = 1;
                        gd(x,y,z) = 1;
                        gd(x,y0,z) = -1;
                        gd(x,y,z0) = -1;
                        gamma_basis(:,i) = gd(:);
                        igb(i,:) = [x,y,z];
                    end
                end
            end
        end
    end
end

