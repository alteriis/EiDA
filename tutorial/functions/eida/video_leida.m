function video_leida(leading_eigen)
%VIDEO_LEIDA this fcn does a video of the leading eigenvectors

figure
for i=1:size(leading_eigen,2)
    imagesc(leading_eigen(:,i)*leading_eigen(:,i)');
    pause(0.1);
end

