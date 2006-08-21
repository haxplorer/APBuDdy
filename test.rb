def create_function_with_static_var; static=0; lambda{ static+=1; static} ; end;

def myfunc(i)
case i
when 1
p "one"
when 2
p "two"
when 3
p "three"
end
end

func = create_function_with_static_var

myfunc (func.call)
myfunc (func.call)
myfunc (func.call)
myfunc (func.call)

