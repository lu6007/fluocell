% function data = model_init_data( name )
function data = model_init_data( name )
switch name
    case 'model1' % 'phospho_with_recruit'
        data.num_histone = 60000; % 60M histone
        data.base_methyl = data.num_histone*3/5;
        data.more_methyl = 200; % 200K methyltransferase binds with h3k9 during mitosis
        data.max_methyl_enzyme = 600; % max number of methyltrasferase and KDMS
        data.max_time_phospho = 30 * data.num_histone;  %num_histone for 30 min
        data.more_kinase = 1000; % 1M more kinase binds to h3s10 during mitosis
        data.max_phosphor_enzyme = 4000; % 4M aurora b kinase, max number of kinase and phosphotase
        % 
        data.a(1) = 0.01; % phosphorylation repels methyltransferase
        data.a(2) = 0.01;  % phosphorylation recruit demethylase
        data.b = 1; % the strength of kinase; 
        %
        data.time(1) = 40; % min, time to exit mitosis; enter mitosis at 0 min
        data.time(2) = 400; % min, cell cycle duration  
        %
        data.time_step = 1/60;
    case 'model4' % Follow the references, 3/2/2017
        data.num_histone = 60000; % 60M histone
        data.base_methyl = data.num_histone*0.57; 
        data.max_methyl_enzyme = 1200; % max number of methyltrasferase and KDMS
        data.more_methyl = 600; % more methyltransferase binds with h3k9 during mitosis
        % Kinase:KDM ratio = 5.9:1 
        data.max_phosphor_enzyme = data.max_methyl_enzyme*5.9; % 7.1M aurora b kinase, max number of kinase and phosphotase
        data.more_kinase = 1000; % 1000K more kinase binds to h3s10 during mitosis
        data.max_time_phospho = 60 * data.num_histone;  %num_histone for 60 min
        data.time(1) = 40; % min, time to exit mitosis; enter mitosis at 0 min
        data.time(2) = 1440; % min, cell cycle duration 24 hrs for HeLa cells
        % 
        data.a(1) = 0.03; % min^(-1) phosphorylation repels methyltransferase
        data.a(2) = 0.03;  % min^(-1) phosphorylation recruit demethylase
        data.b = 1; % the strength of kinase; 
        %
        data.time_step = 1/60; % min
end
data.base_phosphor = 0;
data.base_kinase = 1000;
data.base_phosphotase = 1000;
data.base_methyltransferase = 100;
data.base_demethylase = 100;
data.min_demethylase = 100;
return;

