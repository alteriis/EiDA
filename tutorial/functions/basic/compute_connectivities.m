function matrix = compute_connectivities(data,measure)

if(strcmp(measure,'rsquared'))
    matrix = (corrcoef(data)).^2;
    a=2;
elseif(strcmp(measure,'minfo3'))
    matrix = m_info_matrix(data,3); % this means that if i write "minfo4" i have the same but with 4 as a parameter
end
end