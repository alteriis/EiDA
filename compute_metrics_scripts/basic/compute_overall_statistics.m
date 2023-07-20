clear
addpath('../../saved_calculations/basic');
addpath('../../functions/basic');
addpath('../../functions/nonlinear');
load('global_parameters.mat');

%% first statistic is frobenius norm of connecivity matrix 

average_frobenius_connectivities = calculate_statistic_vectors(n_time_scans,n_subjects,@calculate_norm_connectivity);
save('../../saved_calculations/basic/average_frobenius_connectivities.mat','average_frobenius_connectivities');

overall_var_vectors = calculate_statistic_vectors(n_time_scans,n_subjects,@overall_var_data);
save('../../saved_calculations/basic/overall_var_vectors.mat','overall_var_vectors');

%% non linear 

addpath('../../functions/nonlinear');
overall_hursts_vectors = calculate_statistic_vectors(n_time_scans,n_subjects,@overall_hurst);
save('../../saved_calculations/nonlinear/overall_hursts_vectors.mat','overall_hursts_vectors');

overall_perm_en_2_vectors = calculate_statistic_vectors(n_time_scans,n_subjects,@overall_perm_en_2);
save('../../saved_calculations/nonlinear/overall_perm_en_2_vectors.mat','overall_perm_en_2_vectors');

overall_sam_en_2_vectors = calculate_statistic_vectors(n_time_scans,n_subjects,@overall_sam_en_2);
save('../../saved_calculations/nonlinear/overall_sam_en_2_vectors.mat','overall_sam_en_2_vectors');

overall_connectivity_zip_vectors = calculate_statistic_vectors(n_time_scans,n_subjects,@overall_connectivity_zip);
save('../../saved_calculations/nonlinear/overall_connectivity_zip_vectors.mat','overall_connectivity_zip_vectors');

overall_zip_vectors = calculate_statistic_vectors(n_time_scans,n_subjects,@overall_zip);
save('../../saved_calculations/nonlinear/overall_zip_vectors.mat','overall_zip_vectors');

overall_connectivity_zip_leida_vectors = calculate_statistic_vectors(n_time_scans,n_subjects,@overall_connectivity_zip_leida);
save('../../saved_calculations/nonlinear/overall_connectivity_zip_leida_vectors.mat','overall_connectivity_zip_leida_vectors');
