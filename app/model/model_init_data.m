function data = model_init_data( name )
switch name,
    case 'with_feedback',
        data.a(1) = 0.1; 
        data.a(2) = 0.1; 
        data.num_kdms = 5;
        data.max_kdms = 100; % 100K demethylase 
        %20K KDMS also show nonlinear behavior
        data.num_histones = 6000; % 6M histone
        data.dt(1) = 120; % min, time to exit mitosis
        data.dt(2) = 300; % min, cell cycle duration
    case 'no_feedback',
        data.a(1) = 0;
        data.a(2) = 0;
        data.num_kdms = 100;
        data.max_kdms = 100; % 100K demethylase
        data.num_histones = 6000; % 6M histone
        data.dt(1) = 120; % min, time to exit mitosis
        data.dt(2) = 300; % min, cell cycle duration
end

% In cells there are 60M histone
% If we multiply everything by 100x1e2 and set data.a(1) = data.a(2) = 1.
% Set time step = 1/100. There is a chance that we can find the threshold
% values for triggering KDMS concentration and total KDMS concentration.
% So far, I have not found the threshold yet. 
% Maybe we need to reduce dt and decrease the triggering amount of KDMS by
% a much larger fraction. 

