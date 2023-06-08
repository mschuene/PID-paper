function [px,pygx,pzgx] = dpcoords(pxyz)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    [cardx,cardy,cardz] = size(pxyz);
    px = squeeze(sum(sum(pxyz,3),2));
    pxy = squeeze(sum(pxyz,3));
    pxz = squeeze(sum(pxyz,2));
    pygx = pxy./repmat(px,[1,cardy]);
    pygx(isnan(pygx)) = 0;
    pzgx = pxz./repmat(px,[1,cardz]);
    pzgx(isnan(pzgx)) = 0;
end

