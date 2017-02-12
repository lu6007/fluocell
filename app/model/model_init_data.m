% function data = model_init_data( name )
function data = model_init_data( name )
switch name
    case 'model1' % 'phospho_with_recruit'
        data.num_histone = 60000; % 60M histone
        data.basal_methyl = data.num_histone*3/5;
        data.max_methyl = 600; % max number of methyltrasferase and KDMS
        data.more_methyl = 200; % 200K methyltransferase binds with h3k9 during mitosis
        data.max_time_phospho = 30 * data.num_histone;  %num_histone for 30 min
        data.more_phospho = 1000; % 1M more kinase binds to h3s10 during mitosis
        data.max_mol = 4000; % 4M aurora b kinase, max number of kinase and phosphotase
        data.dt(1) = 45; % min, time to exit mitosis; enter mitosis at 0 min
        data.dt(2) = 300; % min, cell cycle duration
        % 
        data.a(1) = 0.01; % phosphorylation repels methyltransferase
        data.a(2) = 0.01;  % phosphorylation recruit demethylase
        data.b = 1; % the strength of kinase; 
    case 'model2' % 'phospho_with_recruit'
        data.num_histone = 60000; % 60M histone
        data.basal_methyl = data.num_histone*3/5;
        data.max_methyl = 600; % max number of methyltrasferase and KDMS
        %%%
        data.more_methyl = 0; % MT not increases when entering mitosis
        %%%
        data.max_time_phospho = 30 * data.num_histone;  %num_histone for 30 min
        data.more_phospho = 1000; % 1M more kinase binds to h3s10 during mitosis
        data.max_mol = 4000; % 4M aurora b kinase, max number of kinase and phosphotase
        data.dt(1) = 45; % min, time to exit mitosis; enter mitosis at 0 min
        data.dt(2) = 300; % min, cell cycle duration
        % 
        data.a(1) = 0.01; % phosphorylation repels methyltransferase
        data.a(2) = 0.01;  % phosphorylation recruit demethylase
        data.b = 1; % the strength of kinase; 
end

