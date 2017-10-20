function [B,C,W] = gradient_descent_runner_old(corr,B_init,C_init,W_init,Y,lambda,lambda_1,lambda_2,lambda_3,lambda_4,lr1)
%%runs gradient descent using alternating minimisation

%Initilise
num_iter =1000;
B_old = B_init;
C_old = C_init;
%B_hat_old=B_hat_init;
W_old = W_init;
thresh = 10e-06;

%Iterate
err =[];
% plot(0,0)
% title('Graident Descent Run ')
% xlabel('Number of iterations')
% ylabel('Value of obejctive function')

for i = 1:num_iter
    err= horzcat(err,error_compute_old(corr,B_old,C_old,Y,W_old,lambda,lambda_1,lambda_2,lambda_3,lambda_4));
    fprintf(' At iteration %d || Error: %f \n',i,err(i))
%     plot(1:i,err,'b');
%     hold on;
%     drawnow;
    if (i<10)
        [B,C,W] = step_gradient_old(corr,B_old,C_old,W_old,Y,lambda,lambda_1,lambda_2,lambda_3,lambda_4,0.0001); 
    else 
        [B,C,W] = step_gradient_old(corr,B_old,C_old,W_old,Y,lambda,lambda_1,lambda_2,lambda_3,lambda_4,lr1); 
    
    end
    B_old = B;
    %B_hat_old =B_hat;
    C_old = C;
    W_old =W;
    if (i>1 && abs(err(i)-err(i-1)) < thresh)
        break;
    end
end

end