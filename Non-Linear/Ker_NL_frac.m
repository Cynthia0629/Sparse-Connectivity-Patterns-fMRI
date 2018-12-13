function [F,J] = Ker_NL_frac(c_j,c_i,sigma,w_p)

y = c_j;

%function value estimate
F = exp(-(norm((y-c_i),2).^2)/sigma^2) + w_p*(c_i'*y+1)^(2) ;

%gradient estimate

J = -2*exp(-(norm((y-c_i),2).^2)/sigma^2)*(y-c_i)/sigma^2 + (2)*w_p*(c_i'*y +1)*c_i;

end