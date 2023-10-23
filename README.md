# EiDA
Eigenvector Dynamic Analysis of Functional Connectivity Patterns in Timeseries. 

Please see the paper: 
https://www.biorxiv.org/content/10.1101/2023.02.27.529688v2.abstract

for the description of the method. Note that the method described in the paper works with narrowband signals, like fMRI. If you are not working with a narrow-band signal, please select a (narrow) band of interest and filter your data before applying EiDA. Note that we are releasing soon a version of EiDA that works with any kind of signal, without assumptions about the band. Stay updated!

# READ HERE FOR A SIMPLE TUTORIAL OF APPLICATION OF EiDA

We suggest to run this to understand how Continuous and Discrete EiDA work. 

Please go to the "tutorial" folder. Put your data in a folder in the "data" folder. We provided you with an example fmri data (example_fmri). 
Note that the scripts are automated. You have to insert the data in the right folder, and the output will automatically compute discrete and continuous EiDA for all the data in the folder. The only thing you have to care about is 1) specifying the right folders in the script 2) the data must be in the shape (time,dimension). So, each row is a different time point, each column is a signal. 

Basically the core of EiDA is just 3 functions: 

- compute_eigen_timeseries takes the (filtered) signals and computes the stacked eigenvectors (and 1st eigenvalue if required). They are normalized, stacked (1st eigenvector and then 2nd eigenvector) and wheighed by the square root of the eigenvalue. This means that if you want to rebuild the iPL matrix you just have to do v1*v1'+v2*v2', because the eigenvalues are already included. Remember that an eigenvector is still an eigenvector if you multiply it by any number.
- continuous_eida takes the eigenvectors in input and outputs positions (=1st and 2nd eigenvalues) and reconfiguration speeds (of the first and the second eigenvector, respectively). Note that the 1st eigenvector is already a possible output of the previous function. The 2nd is always = N-1st eigenvector
- discrete_eida performs clustering as described in the paper

If you want to try the EiDA pipeline: 

- run "tutorial/scripts/compute/compute_eigenvectors_for_every_subj.m" to compute eigenvectors and save them in the folder specified in the script
- run "tutorial/scripts/compute/compute_discrete_EiDA_for_every_subj.m" to run clustering
- run "tutorial/scripts/compute/compute_continous_EiDA_for_every_subj.m" for the continuous EiDA measures


# READ HERE IF YOU WANT TO REPLICATE THE RESULTS OF THE PAPER

"functions" contains the functions to compute quantities of interest for the paper. 
In particular: 

- compute_2_leading_eigen is the function to compute the two eigenvectors analytically. They are normalized, stacked (1st eigenvector and then 2nd eigenvector) and wheighed by the square root of the eigenvalue. This means that if you want to rebuild the iPL matrix you just have to do v1*v1'+v2*v2', because the eigenvalues are already included. Remember that an eigenvector is still an eigenvector if you multiply it by any number. 

- discrete_eida is the function to perform clustering
- visualize_phase_space_connectivity_eigenvalues performs Continuous EiDA with the two separate eigenvectors (figure 6 of the paper) 
- visualize_phase_space_connectivity_iPL performs Continuous EiDA with the iPL matrix (figure 5 of the paper)

"compute_metrics_scripts" computes the measures of interest "create figures" takes the data to create the figures and outputs the statistics. 


