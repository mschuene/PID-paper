function [ Q ] = starting_dist(px,pygx,pzgx,full_distrib)
%STARTING_DIST pygx pzgx still have x values along the first dimension
    cardx = size(px,1) + 1;
    cardy = size(pygx,2) + 1;
    cardz = size(pzgx,2) + 1;
    px(cardx,:) = 1 - sum(px);
    pygx(:,cardy) = 1 - sum(pygx,2);
    pzgx(:,cardz) = 1 - sum(pzgx,2);

    Q = zeros(cardx,cardy,cardz);
    
    for x = 1:cardx
        for y = 1:cardy
            for z = 1:cardz
                Q(x,y,z) = px(x)*pygx(x,y)*pzgx(x,z);
            end
        end
    end
end

