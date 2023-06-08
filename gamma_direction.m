function [ gamma ] = gamma_direction(x,y0,y,z0,z,cardx,cardy,cardz)
%UNTITLED6 beware of 1 based indexing!
%   Detailed explanation goes here

if(nargin < 6)
    cardx = 2;cardy = 2;cardz = 2;
end

gamma = zeros(cardx,cardy,cardz);
gamma(x,y0,z0) = 1;
gamma(x,y,z) = 1;
gamma(x,y0,z) = -1;
gamma(x,y,z0) = -1;
end

