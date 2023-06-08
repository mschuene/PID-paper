function [ MI ] = MI_X_Z_given_Y( Q,cardx,cardy,cardz )
%MI_X_Z_GIVEN_Y Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 2
        if numel(size(Q)) == 2
            cardx = 2; cardy = 2; cardz = 2;
        else 
            [cardx,cardy,cardz] = size(Q);
        end
    end
    Q = reshape(Q,[cardx,cardy,cardz]);
    MI = MI_X_Y_given_Z(permute(Q,[1,3,2]));

end

