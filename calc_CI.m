function [ CI ] = calc_CI( p,Q )
%CALC_CI Summary of this function goes here
%   Detailed explanation goes here

    CI = MI_X_YZ(p) - MI_X_YZ(Q);

end

