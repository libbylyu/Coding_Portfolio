rng("default");

n = 20;
r = 5; 
t = 50; 
s = 2; 

roi_data = randn(n, r, t, s);

behavior = randn(1, n);

mean_ts = calcMeanTimeSeries(roi_data);
%%

% Pairwise temporal ISC
pairwise_temporal_ISC = zeros(n, n, r);
for i = 1:r
    for subj1 = 1:n
        for subj2 = 1:n
            ts1 = squeeze(mean_ts(subj1, i, :));
            ts2 = squeeze(mean_ts(subj2, i, :));
            pairwise_temporal_ISC(subj1, subj2, i) = corr(ts1, ts2);
        end
    end
end
%%

% Leave-one-out temporal ISC
loo_temporal_ISC = zeros(n, r);
for i = 1:r
    for subj = 1:n
        other_mean_ts = mean(mean_ts(setdiff(1:n, subj), i, :), 1);
        other_mean_ts = squeeze(other_mean_ts);
        subj_ts = squeeze(mean_ts(subj, i, :));
        loo_temporal_ISC(subj, i) = corr(subj_ts, other_mean_ts);
    end
end
%%

% Dynamic ISC with sliding window
w = 10; 
step_size = 10; 
num_windows = floor(t / w);
loo_dynamic_ISC = zeros(n, r, num_windows);

for i = 1:r
    for subj = 1:n
        others = true(1, n);
        others(subj) = false;
        for window = 1:num_windows
            start_idx = (window - 1) * step_size + 1;
            end_idx = start_idx + w - 1;
            subj_window_ts = squeeze(mean_ts(subj, i, start_idx:end_idx));
            others_window_ts = squeeze(mean(mean_ts(others, i, start_idx:end_idx), 1));
            loo_dynamic_ISC(subj, i, window) = corr(subj_window_ts, others_window_ts);
        end
    end
end

% Plot the change in temporal ISC for the first subject and first ROI
h = figure;
plot(1:num_windows, squeeze(loo_dynamic_ISC(1, 1, :)), 'o-', 'LineWidth', 2);
xlabel('Time Window');
ylabel('Correlation');
title('Dynamic ISC for Subject 1, ROI 1');

%%

% Spatial ISC with leave-one-out approach
loo_spatial_ISC = zeros(n, 1);

% Average the ROI data over time for each subject
subj_averages = squeeze(mean(roi_data, 3)); 
subj_averages = mean(subj_averages, 3); 

% Loop over each subject to perform leave-one-out
for subj = 1:n
    other_subjs = [1:subj-1, subj+1:n];
    group_average = mean(subj_averages(other_subjs, :), 1);

    loo_spatial_ISC(subj) = corr(subj_averages(subj, :)', group_average');
end

%%
intrasubject_temporal_ISC = zeros(n, r);

for subj = 1:n
    for roi = 1:r
        session1_ts = squeeze(roi_data(subj, roi, :, 1)); 
        session2_ts = squeeze(roi_data(subj, roi, :, 2)); 
        intrasubject_temporal_ISC(subj, roi) = corr(session1_ts, session2_ts);
    end
end

%%
loo_ISFC = zeros(n, r, r);

for subj = 1:n
    subj_mean_ts = squeeze(mean(roi_data(subj, :, :, :), 4));
    
    for roi1 = 1:r
        others_mean_ts = squeeze(mean(mean(roi_data(setdiff(1:n, subj), :, :, :), 4), 1));
        
        for roi2 = 1:r
            if roi1 ~= roi2
                loo_ISFC(subj, roi1, roi2) = corr(subj_mean_ts(:, roi1), others_mean_ts(:, roi2));
            end
        end
    end
end


%%
% Relate ISC to behavioral similarity
behavioral_similarity = zeros(n, n);

% Euclidean distance
for subj1 = 1:n
    for subj2 = 1:n
        behavioral_similarity(subj1, subj2) = 1 / (1 + norm(behavior(subj1) - behavior(subj2)));
    end
end

% Hypothesis: Higher behavioral similarity leads to higher ISC.
% Test this hypothesis by correlating pairwise_temporal_ISC with behavioral_similarity
for i = 1:r
    isc_behav_correlation = corr(reshape(pairwise_temporal_ISC(:,:,i), [], 1), reshape(behavioral_similarity, [], 1));
    fprintf('ROI %d: Correlation between ISC and behavioral similarity is %f\n', i, isc_behav_correlation);
end
%%
% Function to calculate mean time-series for each subject and each ROI
function mean_ts = calcMeanTimeSeries(roi_data)
    mean_ts = squeeze(mean(roi_data, 4));
end

