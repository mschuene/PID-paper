function [ MI ] = MI_X_YZ(Q,cardx,cardy,cardz)
%MI_X_YZ Mutual information between X and (Y,Z). Q is XxYxY proability
%matrix
    if nargin < 2
        if size(Q,2) == 1
            cardx = 2; cardy = 2; cardz = 2;
        else 
            [cardx,cardy,cardz] = size(Q);
        end
    end
        
     Q = reshape(Q,[cardx,cardy,cardz]);%todo better
     Q_X = repmat(sum(sum(Q,3),2),[1,cardy,cardz]);
     Q_YZ = repmat(sum(Q,1),[cardx,1,1]);
     
     MI = Q.*(log2(Q) - log2(Q_X) - log2(Q_YZ));
     MI(isnan(MI)) = 0;
     MI = real(sum(MI(:)));
end

