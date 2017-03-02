% function data = model_init_data( name )
function data = model_init_data( name )
switch name
    case 'model1' % 'phospho_with_recruit'
        data.num_histone = 60000; % 60M histone
        data.base_methyl = data.num_histone*3/5;
        data.more_methyl = 200; % 200K methyltransferase binds with h3k9 during mitosis
        data.max_methyl_enzyme = 600; % max number of methyltrasferase and KDMS
        data.max_time_phospho = 30 * data.num_histone;  %num_histone for 30 min
        data.more_phospho = 1000; % 1M more kinase binds to h3s10 during mitosis
        data.max_phosphor_enzyme = 4000; % 4M aurora b kinase, max number of kinase and phosphotase
        % 
        data.a(1) = 0.01; % phosphorylation repels methyltransferase
        data.a(2) = 0.01;  % phosphorylation recruit demethylase
        data.b = 1; % the strength of kinase; 
        %
        data.dt(1) = 40; % min, time to exit mitosis; enter mitosis at 0 min
        data.dt(2) = 300; % min, cell cycle duration  
        %
        data.time_step = 1/60;
    case 'model4' % Follow the references, 3/2/2017
        data.num_histone = 60000; % 60M histone
        data.base_methyl = data.num_histone*0.57; 
        data.max_methyl_enzyme = 1200; % max number of methyltrasferase and KDMS
        data.more_methyl = 600; % more methyltransferase binds with h3k9 during mitosis
        % Kinase:KDM ratio = 5.9:1 
        data.max_phosphor_enzyme = data.max_methyl_enzyme*5.9; % 7.1M aurora b kinase, max number of kinase and phosphotase
        data.more_phospho = 1000; % 1000K more kinase binds to h3s10 during mitosis
        data.max_time_phospho = 30 * data.num_histone;  %num_histone for 30 min
        data.dt(1) = 40; % min, time to exit mitosis; enter mitosis at 0 min
        data.dt(2) = 300; % min, cell cycle duration
        % 
        data.a(1) = 0.03; % phosphorylation repels methyltransferase
        data.a(2) = 0.03;  % phosphorylation recruit demethylase
        data.b = 1; % the strength of kinase; 
        %
        data.time_step = 1/60; % min
end

return;

