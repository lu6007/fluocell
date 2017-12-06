% test_statistics
function test_statistics()
yf = [1	1	1	1	1	1]';
yfa = [1.165444306	3.340361233	2.863719211	1.540165376	1.870444119	2.27271605]';
wt = [1.056015038	1.743653574	6.652449468	1.326782384	2.17655309	1.960880655]';
wta = [1.046648983	11.65720056	3.781625171	4.032968967	2.241358852	1.894490331]';

my_fun = my_function();
my_fun.statistic_test(yf, wt, 'method', 'ranksum', 'group', 'yf and wt');
my_fun.statistic_test(yf, yfa, 'method', 'ranksum', 'group', 'yf and yfa');
my_fun.statistic_test(wt, wta, 'method', 'ranksum', 'group', 'wt and wta');
% n = 6; p-value = 0.0022 between YF and WT/YFA/WTA. 

% yf_tag = get_tag(yf, 'YF ');
% yfa_tag = get_tag(yfa, 'YFA');
% wt_tag = get_tag(wt, 'WT ');
% wta_tag = get_tag(wta, 'WTA');
% %
% data=cat(1, yf, yfa, wt, wta);
% tag = cat(1, yf_tag, yfa_tag, wt_tag, wta_tag);
% multiple_comparison(data, tag);
return;

% %% Jie Sun and Lei Lei's paper Fig. 1E
% % By the exact randomized permutation test, p=0.0014 for all 3 groups we
% % tested. So the adjusted p < 0.01 **. [Dwass M 1957 Ann Math Statist,
% % Modified Randomization Tests for Nonparametric Hypotheses]. 
% disp('For Fig. 1E')
% group_name = {'iSNAP', 'iSNAP_Src', 'FF', 'FF+Src'};
% value = cell(4,1);
% value{1} = [457	392	354]';
% value{2} = [1645 1498 2034]';
% value{3} = [331	322	319]';
% value{4} = [363	342	341]'; 
% zz = zeros(3,1);
% test_pair = [2 1; 2 3; 2 4];
% 
% num_test = size(test_pair, 1);
% p = zeros(num_test, 1);
% % The ranksum function implements the Mann-Witney U-test which is good for small sample size 
% % and does not require the samples to have normal distribution like the t-test. 
% for i = 1:num_test
%     tp = test_pair(i, :);
%     %p(i) = ranksum(value{tp(1)}-value{tp(2)}, zz); 
%     %[~,p(i), ~] = fishertest([value{tp(1)}'; value{tp(2)}']);
%     %fprintf('%s vs. %s: p = %f \n', group_name{tp(1)}, group_name{tp(2)}, p(i));
%     clear tp; 
% end
% fprintf('\n');
% 
% %% Fig. 2C
% disp('For Fig. 2C')
% % clear all;
% group_name = {'CD47 IgG', 'CD47', 'IgG', 'FF'};
% value = cell(4,1);
% value{1} = [1.01308489	1.025392065	1.044185308	1.041675783	1.13466887	1.101529975	1.094054391 ...
%     0.980869476	0.970294936	1.018364713	1.028345157	0.970040758	1.1631695	1.079702015	...
%     1.133441746	1.059504619	1.073548631	1.153675596	1.090441085	1.054418574	1.129742118	...
%     1.119318351	1.15749426	1.025254103	1.047008354	1.169823677	1.126579233	1.25124145	...
%     1.129164115	1.131974312	1.102137064	1.207099262]';
% value{2} = [1.115276134	1.071423325	1.024659134	1.040699428	1.06899223	1.096872598	1.089561323	...
%     1.033750192	1.096908772	1.117349449	1.03876629	1.126344275	1.203018334	1.212151674	...
%     1.091887319	1.126579233]';
% value{3} = [0.961726145	0.967352346	0.974467067	0.994147449	0.984994042	1.002034307	1.044447189	...
%     0.974919906	0.964107288	0.986643908	0.912654909	0.891220992	0.985587691]';
% value{4} = [1.006276679	1.008926665	1.060405812	1.045489259	0.960470732	0.936787938	0.965411483	...
%     1.077778928	0.993222579	1.087922252	1.047411298	1.043077778]'; 
% test_pair = [1 3; 1 4; 2 3; 2 4];
% 
% num_test = size(test_pair, 1);
% p = zeros(num_test, 1);
% % The ranksum function implements the Mann-Witney U-test which is good for small sample size 
% % and does not require the samples to have normal distribution like the t-test. 
% for i = 1:num_test
%     tp = test_pair(i, :);
%     p(i) = ranksum(value{tp(1)}, value{tp(2)}); 
%     fprintf('%s vs. %s: p = %f \n', group_name{tp(1)}, group_name{tp(2)}, p(i));
%     clear tp; 
% end
% fprintf('\n');
% 
% % result: p< 0.01 significant
% 
% %% Fig. 2f
% disp('For Fig. 2f')
% group_name = {'ISNAP', 'FF', 'Delta PTP', 'SIRP', 'SIRP no ITIM', 'GFP'};
% value = cell(6,1);
% value{1} = [1.857336482	1.8230765	1.629758375	1.518025841	1.7432106	1.867613293 1.89]';
% value{2} = [1.690634457	1.3718385	1.372092156	1.448850544	1.3467189	1.524374598 1.03]';
% value{3} = [1.307203218	1.0058688	1.14 1.11]';
% value{4} = [1.000001735	1.0000000	1.000041592	0.999860053	1.0000000	1.00 1.00]';
% value{5} = [1.475677555		1.289371677	1.492584109	1.4959427	1.69 1.20]';
% value{6} = [1.01 	0.8752674	1.160843308		0.8196891	0.922365707 1.05]';
% test_pair = [1 2; 1 3; 1 4; 1 5; 1 6];
% 
% num_test = size(test_pair, 1);
% p = zeros(num_test, 1);
% for i = 1:num_test
%     tp = test_pair(i, :);
%     p(i) = ranksum(value{tp(1)}, value{tp(2)}); 
%     fprintf('%s vs. %s: p = %f \n', group_name{tp(1)}, group_name{tp(2)}, p(i));
%     clear tp; 
% end
% fprintf('\n');
% 
% %% Fig 3c
% disp('For Fig. 3c');
% group_name = {'Basal', 'Engulfing', 'Completion'};
% value = cell(3,1);
% value{1} = [1.006189232	1.000000172	1.000000597	1.00000257	1.00000076	1.000000499	1.000000857]';
% value{2} = [1.22083576	1.21604174	1.227070752	1.160055991	1.142427449	1.20676291	1.468431381]';
% value{3} = [1.001165599	1.045423172	1.035008994	1.014336244	1.020391185	1.019223091	0.907378359]';
% test_pair = [1 2; 2 3];
% % n = 7; p<0.001
% 
% num_test = size(test_pair, 1);
% p = zeros(num_test, 1);
% for i = 1:num_test
%     tp = test_pair(i, :);
%     p(i) = ranksum(value{tp(1)}, value{tp(2)}); 
%     fprintf('%s vs. %s: p = %f \n', group_name{tp(1)}, group_name{tp(2)}, p(i));
%     clear tp; 
% end
% fprintf('\n');
% 
% %% Fig 3d
% disp('For Fig. 3d');
% group_name = {'ISNAP', 'FF', 'Delta PTP', 'SIRP', 'SIRP no ITIM'};
% value = cell(5,1);
% value{1} = [2.656775892	2.612172048	2.18117	2.040613317	2.368664156	1.831438412]';
% value{2} = [1.773019326	1.20787	1.747113357	1.820977381	1.641916285]';
% value{3} = [2.092665154	1.878215947	1.78935	1.736484703	1.242470297	1.538080224]';
% value{4} = [1.00000	1.00000	1.00000	1.00000	1.00000	1.00000]';
% value{5} = [1.427948385	1.79580527 1.707752894	1.352101252	1.114795663]';
% test_pair = [1 2; 1 3; 1 4; 1 5; 4 2; 4 3; 4 5];
% 
% num_test = size(test_pair, 1);
% p = zeros(num_test, 1);
% for i = 1:num_test
%     tp = test_pair(i, :);
%     p(i) = ranksum(value{tp(1)}, value{tp(2)}); 
%     fprintf('%s vs. %s: p = %f \n', group_name{tp(1)}, group_name{tp(2)}, p(i));
%     clear tp; 
% end
% fprintf('\n');
% 
% %% Fig 3e
% disp('For Fig. 3e');
% group_name = {'ISNAP', 'FF', 'Delta PTP', 'SIRP', 'SIRP no ITIM'};
% value = cell(5,1);
% value{1} = [2.25380 	2.16571 	1.93197 	2.37238 	1.96498 	2.18906 	2.14218 	1.906028432]';
% value{2} = [1.97495 	1.90271 	1.74362 	1.98879 	1.76615 	1.85571 	1.55766 	1.723087054]';
% value{3} = [1.71754 	1.62645 	1.74771 	1.59963 	1.49769 	1.34448 	1.62532 	1.745645921]';
% value{4} = [1.00001 	1.00000 	1.00000 	1.00000 	1.00000 	1.00000 	1.00000 	1.000000733]';
% value{5} = [1.89722 	1.59237 	1.45799 	1.27236 	1.54401 	1.40930 	1.15670 	1.309848901]';
% test_pair = [1 2; 1 3; 1 4; 1 5; 4 2; 4 3; 4 5];
% 
% num_test = size(test_pair, 1);
% p = zeros(num_test, 1);
% for i = 1:num_test
%     tp = test_pair(i, :);
%     p(i) = ranksum(value{tp(1)}, value{tp(2)}); 
%     fprintf('%s vs. %s: p = %f \n', group_name{tp(1)}, group_name{tp(2)}, p(i));
%     clear tp; 
% end
% fprintf('\n');
% 
% %% Fig 4e
% disp('For Fig. 4e');
% group_name = {'ISNAP', 'FF', 'K402R', 'SIRP', 'SIRP no ITIM'};
% value = cell(5,1);
% value{1} = [2.265427659	2.315935381	2.388115054	2.357	2.359880607	2.375040968	2.366]';
% value{2} = [2.069	2.169489794	2.237044894	2.047]'; 
% value{3} = [1.340139071	1.342	1.399289995	]';
% value{4} = [1.000006778	1.00002211	1.000000267	1.000	1.000003687	1.000009009	1.000]';
% value{5} = [1.588053192	1.886874005	1.737184082	1.559	1.374818322	1.354637546	1.322]';
% test_pair = [1 2; 1 3; 1 4; 1 5];
% 
% num_test = size(test_pair, 1);
% p = zeros(num_test, 1);
% for i = 1:num_test
%     tp = test_pair(i, :);
%     p(i) = ranksum(value{tp(1)}, value{tp(2)}); 
%     fprintf('%s vs. %s: p = %f \n', group_name{tp(1)}, group_name{tp(2)}, p(i));
%     clear tp; 
% end
% fprintf('\n');
% 
% %% Fig. S21
% disp('For Fig. S21');
% group_name = {'SIRP-CD3-Syk-iSNAP', 'SIRP-FygR-Syk-iSNAP',...
%     'K402R', 'SIRP', 'SIRP no ITIM', 'GFP'};
% value = cell(6,1);
% value{1} = [2.146421755	2.112924356	2.072273408	1.929 2.163952839 2.13956699 2.041]';
% value{2} = [2.296884108	2.261288839	2.363389185	2.309 2.278567204 2.278290627 2.162]';
% value{3} = [1.319275628	1.447 1.473839643]';
% value{4} = [1.000006778	1.00002211 1.000000267 1.000 1.000003687 1.000009009 1.0000]';
% value{5} = [1.588053192	1.886874005	1.737184082	1.559 1.374818322 1.354637546 1.322]';
% value{6} = [1.264500455	1.141455398	1.218398278	0.941]'; 
% test_pair = [1 3; 1 4; 1 5; 1 6; 2 3; 2 4; 2 5; 2 6];
% 
% num_test = size(test_pair, 1);
% p = zeros(num_test, 1);
% for i = 1:num_test
%     tp = test_pair(i, :);
%     p(i) = ranksum(value{tp(1)}, value{tp(2)}); 
%     fprintf('%s vs. %s: p = %f \n', group_name{tp(1)}, group_name{tp(2)}, p(i));
%     clear tp; 
% end
% fprintf('\n');
% 
% %% Fig. S8c
% disp('For Fig. S8c');
% group_name = {'Basal', 'CD47', 'PP1'};
% value = cell(3,1);
% value{1} = [1.041690691	1.026380769	0.992183832	1.085486383	1.068850568	1.084525472 ...	
%     0.952040768	0.942526348	0.962527002	0.925036586	0.988253371	0.915482558 ... 
%     0.935692646	0.967751804	0.972652126	1.005183778	0.955737706	0.972938799 ...
%     0.967340448	1.091537628	1.042358646	1.053136031]';
% value{2} = [1.142867418	1.140219954	1.15154409	1.037292953	1.016146826	1.052669628 ...
%     1.050788928	1.111332493	1.070250271	1.188679377	1.210448171	1.146744299 ...
%     1.189807966	1.075532282	1.119359096	1.241746031	1.213179293	1.296680066 ...
%     1.186380354	1.011705343	1.115021322	1.098490411]';
% value{3} = [0.90037804	0.826540708	0.851878037	0.859859405	0.859427538	0.907060816 ...
%     0.898791875	0.940463604	0.932797881	1.037168102	1.0477492	1.011381894 ...
%     1.02962583	0.940379282	0.859527397	0.992479643	1.01013293	1.007658594 ...
%     1.044244201	0.879916574	0.962183012	0.903849228]';
% test_pair = [1 2; 2 3];
% 
% num_test = size(test_pair, 1);
% p = zeros(num_test, 1);
% for i = 1:num_test
%     tp = test_pair(i, :);
%     p(i) = ranksum(value{tp(1)}, value{tp(2)}); 
%     fprintf('%s vs. %s: p(i) = %f \n', group_name{tp(1)}, group_name{tp(2)}, p(i));
%     clear tp; 
% end
% fprintf('\n');
% 
% 
% 
