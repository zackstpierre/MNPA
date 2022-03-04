function val=PWL(t)
% piecewise linear signal
%----------------------------------------------------------
% Definitions:
[t1, t2] = deal(0, 1);
[A1, A2] = deal(-10, 10);


if t<t1
    val = A1;
    
elseif t<t2   %Seg#1
    val = 5e5*t;   %<----Fill this
else
    val = A2;

end


end 
