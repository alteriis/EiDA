function save_figure(fig,titolo,week)  % DA LAVORARCI ANCORA...DA CAPIRE COME PRENDO IL TITOLO
%SAVE_FIGURE this function takes a figure and saves it into the folder with
%the name of the monday of the week. If no title or xlable ylable it asks
%for it

filename = [sprintf('/home/k21208334/rat_ageing/matlab/dealteriis/figs/week%d/',week) titolo];
% 
% date = datetime('dd.MM.yyyy');  magheggi strani per inerire il nome delle
% acrtella della settimana automaticaente...lo faro piano piano 
% day = str2num(date(1:2));
% month = str2num(date(4:5));
% year = str2num(date(7:10));
%  
% ...calendar...

savefig(fig,filename);

end


