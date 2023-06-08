function [S] = sample_unit_simplex(shape)
%SAMPLE_UNIT_SIMPLEX Summary of this function goes here
%   Detailed explanation goes here
    R = rand([prod(shape)-1,1]);
    S = reshape(diff([0,sort(R(:)'),1]),shape);
end

