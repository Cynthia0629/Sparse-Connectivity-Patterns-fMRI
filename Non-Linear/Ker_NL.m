function [F,J] = Ker_NL(c_j,c_i,sigma)

y = c_j;

F = exp(-(norm((y-c_i),2).^2)/sigma^2);

J = -2*exp(-(norm((y-c_i),2).^2)/sigma^2)*(y-c_i)/sigma^2;


end