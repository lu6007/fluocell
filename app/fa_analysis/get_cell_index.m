% Get the index number of the cells with dynamic response
% max_ratio_change>10 & abs(max_disassembly)>10%
% And delete outliers detected by the plot_cc_curve function
function cell_index = get_cell_index(group_i)
is_dynamic = (group_i.max_ratio>1.1 &...
    abs(group_i.max_disassembly)>0.1);
switch group_i.name
    case 'MEF FN20',
        outlier = [3 32 2 18 13 25]; %6/33 cells
    case 'MEF FN10',
        outlier = [20 22]; %2/23 
    case 'MEF FN2.5',
        outlier = [6 8 19 20]; %4/20
    case 'MEF RacV12 FN10',
        outlier = [];
    case 'MEF RacN17 FN10',
        outlier = [4]; %1/12
    case 'MEF RhoAN19(combined) FN10',
        outlier = [3 9];
    case 'FN Blocking',
        outlier = [1 8 9]; %3/14
    case 'FN Nonblocking'
        outlier = [];
    case 'Integrin Avb3',
        %outlier = [5]; % for overnight only
        outlier = [];
    case 'Integrin A5b1',
        outlier = [3 7 10 13];
    case 'Integrin A5b1 Rat',
        outlier = 5;
    case 'KRas Src FN10',
        outlier = [3 11];
end;
if ~exist('outlier','var'),
    outlier = [];
end;
is_dynamic(outlier) = 0;
cell_index = find(is_dynamic);
return