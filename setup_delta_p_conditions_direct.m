function [ cond_lhs,cond_rhs ] = setup_delta_p_conditions_direct(p)
%UNTITLED2 sets up the conditions for 1
%   Detailed explanation goes here
    s = size(p);
    cardx = size(p,1);cardy = size(p,2);cardz=size(p,3);
    marg_cond_lhs = zeros(cardx*cardy + cardx*cardz,prod(s));
    marg_cond_rhs = zeros(cardx*cardy + cardx*cardz,1);
    i = 0;
    for x = 1:cardx
        for y = 1:cardy
            i = i + 1;
            cond = zeros(s);
            cond(x,y,:) = 1;
            marg_cond_lhs(i,:) = cond(:)';
            marg_cond_rhs(i) = sum(p(x,y,:));
        end
    end
    % condition q(x,z) = p(x,z)
    for x = 1:cardx
        for z = 1:cardz
            i = i + 1;
            cond = zeros(s);
            cond(x,:,z) = 1;
            marg_cond_lhs(i,:) = cond(:)';
            marg_cond_rhs(i) = sum(p(x,:,z));
        end
    end
    norm_cond_lhs = ones(1,prod(s));
    norm_cond_rhs = 1;
    cond_lhs = [marg_cond_lhs;norm_cond_lhs];
    cond_rhs = [marg_cond_rhs;norm_cond_rhs];
end

