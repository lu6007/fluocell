% function multiple_comparison(data, tag)
% 
% Example:
% data_c{1} = [1	1	1	1	1	1]';
% data_c{2} = [1.165444306	3.340361233	2.863719211	1.540165376	1.870444119	2.27271605]';
% data_c{3} = [1.056015038	1.743653574	6.652449468	1.326782384	2.17655309	1.960880655]';
% % The pad function makes all the tring in the cell same length by adding spaces
% % to the end to the shorter strings. 
% data_name = pad({'YF', 'YFA', 'WT'}); % 
% for i = 1:3,
%     tag_c{i} = get_tag(data{i}, data_name{i});
% end
% data = cat(1, data_c{:});
% tag = cat(1, tag_c{:});
% multiple_comparison(data, tag);
% 
% This funciton uses the Bonferroni multiple comparison test of means at 
% 95% confidence interval, which is provided by the multcompare function in the
% MATLAB statistics toolbox (The MathWorks, Natick, MA).

% Copyright: Shaoying Lu and Yingxiao Wang 2011-2019
% Email: shaoying.lu@gmail.com 
function m = multiple_comparison(data, tag, varargin)
para_name = {'alpha'};
default_value = {0.05};
alpha = parse_parameter(para_name, default_value, varargin);
[p,~,stat] = anova1(data, tag);
[~,m,~,nms]=multcompare(stat, 'ctype', 'bonferroni', 'alpha', alpha);
fprintf('p = \n'); disp(p);
% fprintf('c = \n'); disp(c);
% fprintf('m = \n'); disp(m);
% fprintf('h = \n'); disp(h);
fprintf('nms = \n'); disp(nms);
return;
