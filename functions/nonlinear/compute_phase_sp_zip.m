function output = compute_phase_sp_zip(tosave)
%COMPUTE_PHASE_SP_ZIP this function calculates
% complexity by just zipping the data and calculating how many bites
% i want it as two vectors one sotto all'altro

save('temporary_8767.mat','tosave');
gzip('temporary_8767.mat');
s = dir('temporary_8767.mat.gz');
filesize = s.bytes;
delete temporary_8767.mat
delete temporary_8767.mat.gz

output = filesize;
end

