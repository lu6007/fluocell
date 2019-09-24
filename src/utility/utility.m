function utility_fh = utility()
    utility_fh.print_parameter = @print_parameter;
    utility_fh.get_upstream_function_name = @get_upstream_function; 
    % single-line function
    utility_fh.get_latex_label = @(label) regexprep(label, '_', '\\_'); 
end

function print_parameter(name, value)
    fun_name = get_upstream_function(); 
    fprintf('Function %s(): Set %s = %s ---\n', ...
        fun_name, name, num2str(value));
end

function function_name = get_upstream_function()
    temp = dbstack(2);
    function_name = temp.name;
end