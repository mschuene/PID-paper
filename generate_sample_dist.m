function [ p ] = generate_sample_dist( cardx,cardy,cardz )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    
    p = rand(cardx,cardy,cardz);
    p = p ./ sum(p(:));

end

