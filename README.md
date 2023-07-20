# EiDA
Eigenvector Dynamic Analysis of Functional Connectivity Patterns in Timeseries

"functions" contains the functions to compute quantities of interest for the paper. 
In particular, 

compute_2_leading_eigen is the function to compute the two eigenvectors analytically
discrete_eida is the function to perform clustering
visualize_phase_space_connectivity_eigenvalues performs Continuous EiDA with the two separate eigenvectors
visualize_phase_space_connectivity_iPL does it with the iPL matrix

"compute_metrics_scripts" computes the measures of interest "create figures" takes the data to create the figures and output the statistics

Once everything is computed, 
