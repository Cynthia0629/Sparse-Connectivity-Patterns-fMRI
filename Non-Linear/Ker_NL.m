function [F,J] = Ker_NL(c_j,c_i,sigma,w_p,p)

y = c_j;

%function value estimate
F = exp(-(norm((y-c_i),2).^2)/sigma^2) + (1/p)* w_p*(c_i'*y+1)^(p) ;

%gradient estimate

J = -2*exp(-(norm((y-c_i),2).^2)/sigma^2)*(y-c_i)/sigma^2 + w_p*(c_i'*y +1)^(p-1)*c_i;

end