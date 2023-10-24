function plot_wavelet_correlation(timeseries)

N = size(timeseries,1);
times = get_divided_time(N);

figure

xlim([1 N]);
ylim([0 8]);
xticks('');
yticks('');


p = get(gca, 'Position');

for i=1:numel(times)
    for j= 1:size(times{i},1)
        
        if (i>3)
            desiredlenx = p(3)*0.8*numel(times{i}(j,:))/N;
            desiredleny = p(4)*0.08;
            desiredx = mean(times{i}(j,1));
            desiredx = p(1) + (desiredx/N)*(p(3))-desiredlenx/2;
            desiredy = i;
            desiredy = p(2) + (desiredy/8)*(p(4))-desiredleny/2;
            
            
            axes('Position',[desiredx desiredy desiredlenx desiredleny])
            box on
            imagesc(corrcoef(timeseries(times{i}(j,:),:)));
            xticks('');
            yticks('');
        else
            desiredlenx = 0.0425;
            desiredleny = p(4)*0.08;
            desiredx = mean(times{i}(j,:));
            desiredx = p(1) + (desiredx/N)*(p(3))-desiredlenx/2;
            desiredy = i;
            desiredy = p(2) + (desiredy/8)*(p(4))-desiredleny/2;
            
            
            axes('Position',[desiredx desiredy desiredlenx desiredleny])
            box on
            imagesc(corrcoef(timeseries(times{i}(j,:),:)))
            xticks('');
            yticks('');
        end
        
    end
end
end


