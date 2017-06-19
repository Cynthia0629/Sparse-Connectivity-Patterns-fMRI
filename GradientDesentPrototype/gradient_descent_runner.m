function [B,C,W] = gradient_descent_runner(corr,B_init,C_init,W_init,Y,lambda,lambda_1,lambda_2,lr1,lr2)
%%runs gradient descent using alternating minimisation

%Initilise
num_iter =1000;
B_old = B_init;
C_old = C_init;
W_old = W_init;
thresh = 100;

%Iterate
figure; hold on
for i = 1:num_iter
    err = error_compute(corr,B_old,C_old,Y,W_old,lambda,lambda_1,lambda_2);
    fprintf('At iteration %d || Error: %f ',i,err)
    plot(i,err);
    [B,C,W] = step_gradient(corr,B_old,C_old,W_old,Y,lambda,lambda_1,lambda_2,lr1,lr2); 
    B_old = B;
    C_old = C;
    W_old =W;
    if (err < thresh)
        break;
    end
end
hold off
end