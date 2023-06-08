%observations:
% for higher cardy,cardz more solutions on boundary
% only for cardy,cardz = 2,2 or = 2,3 ranks can be equal to dim. of deltap
% generically (for randomly sampled dists. at least). For 2x2x2 only rank 2
% is found numerically. starting with 2x3x3 there is only one lower rank observed 


ks = [13:20]';

cards = [3,2;3,3];%[2,2;2,3;2,4;2,5;3,3;3,4;3,5;4,4;4,5;5,5];%[2,2;2,3;2,4;2,5]%[2,6;2,10;2,15;2,20];%[2,2;2,3;2,4;2,5;3,3;3,4;3,5;4,4;4,5;5,5];%[2,2;2,3;3,3;5,10;10,10];
sc = size(cards,1);
num_rep = 1000;
inners = zeros(num_rep,sc);

ranks = zeros(num_rep,sc);
uniques = zeros(num_rep,sc);
num_errors = zeros(sc,1);

for ic =1:size(cards,1) 
    disp(ic)
cardy = cards(ic,1) ;
cardz = cards(ic,2);

i=1
while i<num_rep
    %p = generate_sample_dist(2,cardy,cardz);
    p = sample_unit_simplex([2,cardy,cardz]);
    try
    [~,~,~,~,~,~,inners(i,ic),ranks(i,ic),uniques(i,ic)] = Min_MI_X_YZ_binary_T(p,optimoptions('fmincon'),true,true,false);
    catch ME
        num_errors(ic) = num_errors(ic)+1;
    end
    if inners(i,ic)
       uniques(i,ic) = ranks(i,ic)<2*(cardy-1)*(cardz-1); 
    end
    ic
    i=i+1
end

% figure()
% subplot(1,2,1);
% histogram(inners(:,ic));
% title('counts boundary/inner')
% xlabel('inner')
% subplot(1,2,2);
% % histogram(ranks)
% % title(strcat('rank counts. dim. of dp = ',num2str(2*(cardy-1)*(cardz-1))))
% % xlabel('rank')
% % subplot(1,3,3);
% u = uniques(:,ic);
% histogram(u(u<2));
% title('uniqueness of solution in interior'); 
% suptitle(strcat('binary pid cardy cardz:  ',num2str([cardy,cardz])))
%save('statistics_22k_more')
%save('statistics_new')
end

