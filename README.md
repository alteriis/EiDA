# EiDA
Eigenvector Dynamic Analysis of Functional Connectivity Patterns in Timeseries. 

Please see the paper: 
https://www.biorxiv.org/content/10.1101/2023.02.27.529688v2.abstract

for the description of the method. Note that the method described in the paper works with narrowband signals, like fMRI. If you are not working with a narrow-band signal, please select a (narrow) band of interest and filter your data before applying EiDA. Note that we are releasing soon a version of EiDA that works with any kind of signal, without assumptions about the band. Stay updated!

# READ HERE FOR A TOY EXAMPLE OF APPLICATION OF EiDA




# READ HERE IF YOU WANT TO REPLICATE THE RESULTS OF THE PAPER

"functions" contains the functions to compute quantities of interest for the paper. 
In particular: 

- compute_2_leading_eigen is the function to compute the two eigenvectors analytically. They are normalized, stacked (1st eigenvector and then 2nd eigenvector) and wheighed by the square root of the eigenvalue. This means that if you want to rebuild the iPL matrix you just have to do v1*v1'+v2*v2', because the eigenvalues are already included. Remember that an eigenvector is still an eigenvector if you multiply it by any number. 

- discrete_eida is the function to perform clustering
- visualize_phase_space_connectivity_eigenvalues performs Continuous EiDA with the two separate eigenvectors (figure 6 of the paper) 
- visualize_phase_space_connectivity_iPL performs Continuous EiDA with the iPL matrix (figure 5 of the paper)

"compute_metrics_scripts" computes the measures of interest "create figures" takes the data to create the figures and outputs the statistics. 


