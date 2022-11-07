% Write Excel output from matrix data
function output_xlsx(break_bool,break_time,tend,wel,mul,tl,Folder_sufs,i_folder,Output_File)
    we_list = myreshape(wel);
    mu_list = myreshape(mul);
    t_list = myreshape(tl);
    Break_Boolean = myreshape(break_bool);
    Break_Time = myreshape(break_time);
    t_end_of_simulation = myreshape(tend);
    
    T = table(we_list,mu_list,t_list,Break_Boolean,t_end_of_simulation,Break_Time);
    writetable(T,Output_File,'Sheet',Folder_sufs{i_folder},'Range','A1')
end