function utility_fh = utility()
    utility_fh.print_parameter = @print_parameter;
    utility_fh.get_upstream_function_name = @get_upstream_function; 
return

function print_parameter(name, value)
    fun_name = get_upstream_function(); 
    fprintf('Function %s(): Set %s = %s ---\n', ...
        fun_name, name, num2str(value));
return

function function_name = get_upstream_function()
    temp = dbstack(2);
    function_name = temp.name;
return