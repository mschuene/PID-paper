function [ x_orig ,Q] = binary_analytical(a,b,c,d,e)
%binary_ANALYTICAL analytical solution for the 2x2x2 case

    pstart = starting_dist(a,[b;c],[d;e]);
    GB = create_gamma_basis(1,1,2,2,2);

    
    g1_min = - min(a*b*d,a*(1-b)*(1-d));
    g1_max =   min(a*b*(1-d),a*(1-b)*d);
    g2_min = - min((1-a)*c*e,(1-a)*(1-c)*(1-e));
    g2_max =   min((1-a)*c*(1-e),(1-a)*(1-c)*e);   
    
    if (b == c) || (d == e)
        x_orig = [0;0];
    else
        g1_I = a*d*(b-c)*(1-d)/(d-e);
        g2_I = e*(b-c)*(1-a)*(1-e)/(d-e);

        if g1_min <= g1_I && g1_I <= g1_max && g2_min <= g2_I && g2_I <= g2_max
            x_orig=[g1_I;g2_I];
        else 
            g1_II = a*b*(d - e)*(1-b)/(b-c);
            g2_II = c*(d-e)*(1-a)*(1-c)/(b-c);
            if g1_min <= g1_II && g1_II <= g1_max && g2_min <= g2_II && g2_II <= g2_max
                x_orig=[g1_II;g2_II];
            else 

                h_min_min = calc_HY_XZ(reshape(pstart(:) + GB*[g1_min;g2_min],[2,2,2]));
                h_max_max = calc_HY_XZ(reshape(pstart(:) + GB*[g1_max;g2_max],[2,2,2]));
                if h_min_min <= h_max_max
                    x_orig = [g1_max;g2_max];
                else
                    x_orig = [g1_min;g2_min];
                end
            end
        end
    end

    Q = reshape(pstart(:) + GB*x_orig,[2,2,2]);
end

