%%2d simplex
for i=1:10000
    p = sample_unit_simplex([1,2]);
    plot(p(1),p(2),'b.');
    hold on;
end


%% 3d simplex
figure(13)
for i=1:10000
    p = sample_unit_simplex([1,3]);
    plot3(p(1),p(2),p(3),'b.');
    hold on;
end
saveas(gcf,'figures/test_sample_simplex.png')

%% sampling before
%% 3d simplex
figure(13)
for i=1:10000
    p = squeeze(generate_sample_dist(1,1,3));
    plot3(p(1),p(2),p(3),'b.');
    hold on;
end
saveas(gcf,'figures/comparison_sample_normalization.png')
