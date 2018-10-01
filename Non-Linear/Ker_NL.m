function [F,J] = Ker_NL(c_j,c_i,sigma)

y = c_j;

%function value estimate
F = exp(-(norm((y-c_i),2).^2)/sigma^2);
% F = (c_i'*y)^2 ;

%gradient estimate

J = -2*exp(-(norm((y-c_i),2).^2)/sigma^2)*(y-c_i)/sigma^2;
% J = 2*F*c_i;

end