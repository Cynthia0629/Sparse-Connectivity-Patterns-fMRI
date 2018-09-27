%% %%%%%%%%%%%%%%%%%%%%%% Binomial Expansion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%% Expands Binomials of Form (x+y)^n for a given y and n %%%%%%%%%% 
%% %%%%%%%%%%%%%%%%%%% n must be a whole number %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This code 
% 1) Uses Pascals Triangle to determine the Coefficients of (x+1)^n 
% 2) Creates a Vector Cy = y,y^2,y^3,...,y^n 
% 3) Multiplies the Coeficient Vector by Cy Term by Term to get the 
%    Coefficients of (x+y)^n as the Vector p 
% 4) Uses the Product, p, as an input to MATLAB's poly2sym function to 
%    obatin a symbolic representation of the expanded binomial. 

clear,clc

n = input('n in (x+y)^n is ');   % Input desired exponent; must be Whole 
y = input('y in (x+y)^n is ');   % Input desired y-value

Cy = ones(1,n+1);                 % Preallocating Cy Vector

for j = 2:n+1                    % Calculating Cy Vector
    Cy(1,j) = y^(j-1);
end


%% Pascals Triangle 

Pascals_Triangle = zeros(100,100);  % Preallocating Pascals Triangle Matrix
Pascals_Triangle(:,1) = 1;          % Setting left side to value 1

for i = 2:1:n+1
    for j = 2:1:n+1                 % Compute Pascals Triangle to 
                                     ...the (n+1)th row
        
        Pascals_Triangle(i,j) = (Pascals_Triangle(i-1,j-1)...
                                + Pascals_Triangle(i-1,j));
   
    end
end

%% Calculating Final Answer

Cx = Pascals_Triangle(n+1,1:n+1);  % Collecting Coefficients as Vector
p = Cy.*Cx;                         % Final Coefficients obtained via
                                 ... Term by Term Product of Cy and Cx


answer = poly2sym(p);             % Obtain Symbolic Representation 
                                  ...of Expanded form

%% Display 

formatSpec = '(x+%d)^%d = ';      % Set display text using y and n values
X = sprintf(formatSpec,y,n);         

disp(X)                                   
disp(answer)


   