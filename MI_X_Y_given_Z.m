function [ MI ] = MI_X_Y_given_Z(Q,cardx,cardy,cardz)
%MI_X_Y_GIVEN_Z Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 2
        if numel(size(Q)) == 2
            cardx = 2; cardy = 2; cardz = 2;
        else 
            [cardx,cardy,cardz] = size(Q);
        end
    end
    Q   = reshape(Q,[cardx,cardy,cardz]);
    QZ  = repmat(sum(sum(Q,1),2),[cardx,cardy,1]);
    QXZ = repmat(sum(Q,2),[1,cardy,1]);
    QYZ = repmat(sum(Q,1),[cardx,1,1]);
    
    MI = real(Q.*(log2(QZ) + log2(Q) - log2(QXZ) - log2(QYZ)));
    MI(isnan(MI)) = 0;
    MI = real(sum(MI(:)));

end

