function [ condleq_lhs,condleq_rhs ] = setup_delta_p_conditions_gamma(p,gamma_basis)
%setup_delta_p_conditions_gamma  specifies the constraint that all
%components of p + GB*gamma have to be bigger equal to zero. By
%normalization of p+GB*gamma which is guaranteed by p and GB this
%check is sufficient to establish that p+GB*gamma is a valid
%probability distribution
    condleq_lhs = -gamma_basis;
    condleq_rhs = p(:);
end

