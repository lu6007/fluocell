% test multiple_comparison

%
group_name = {'MS      ', 'MS_GdCI3', 'MS+BAPTA', 'MS+CytoD', 'MS+Noc  ', 'MS+ML-7 '};
num_groups = length(group_name);

ca_peak = cell(num_groups, 1);
ca_peak{1} = [3.04442025; 3.281764568; 2.91983875; 2.91983875; 2.009418; 2.432; ...
3.261364; 4.200956667; 4.047076];
ca_peak{2} = [1.434765; 1.141284; 2.360822; 1.297479];
ca_peak{3} = [1.02058; 0.933378; 1.016254; 1.032566; 1.027812];
ca_peak{4} = [1.005922636; 2.578332; 1.551994973; 1.717145344; 1.807729];
ca_peak{5} = [1.005071; 1.004736; 1.004935; 1.213691];
ca_peak{6} = [3.310219; 1.521649; 1.026484; 1.090409];
ca_value = ca_peak;
%
% ca_frequency = cell(num_groups, 1);
% ca_frequency{1} = [0.393442623; 0.295081967; 0.393442623; 0.295081967; 0.110091743; ...
%     0.229299363; 0.173913043; 0.4; 0.197368421];
% ca_frequency{2} = [0.087463557; 0.103448276; 0; 0];
% ca_frequency{3} = [0; 0; 0 ; 0; 0];
% ca_frequency{4} = [0; 0.24; 0.101694915; 0.101694915; 0.084745763];
% ca_frequency{5} = [0; 0; 0; 0.101694915];
% ca_frequency{6} = [0.149625935; 0.146341463; 0; 0];
% ca_value = ca_frequency; 

% % Another group of data
% % Taejin paper 08/15/2014
% group_name = {'PMS             ', 'PMS + Ca2 + free', 'PMS + 2-APB     ', 'PMS + Neomycin  ', 'PMS + Nifedipine'};
% num_groups = length(group_name);
% ca_frequency = cell(num_groups, 1);
% ca_frequency{1} = [0.393443; 0.295082; 0.393443; 0.295082; 0.110092; 0.229299; 0.173913; 0.4; 0.197368];
% ca_frequency{2} = [0; 0; 0];
% ca_frequency{3} = [0.133333; 0; 0];
% ca_frequency{4} = [0.111111; 0.1; 0.125];
% ca_frequency{5} = [0.268657; 0.222222; 0.214286];
% ca_value = ca_frequency;

num_entries = length(ca_value{1});
for i = 2: num_groups,
    num_entries = num_entries + length(ca_value{i});
end
ca_value_array = zeros(num_entries, 1);
index = 1;
for i = 1:num_groups,
    n = length(ca_value{i});
    ca_value_array(index:index+n-1) = ca_value{i};
    index = index+n;
end
tag = get_tag(ca_value{1}, group_name{1});
for i = 2:num_groups,
    tag = [tag; get_tag(ca_value{i}, group_name{i})];
end;
multiple_comparison(ca_value_array, tag);





