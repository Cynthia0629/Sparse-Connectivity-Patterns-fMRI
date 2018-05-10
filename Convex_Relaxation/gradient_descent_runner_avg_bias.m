function [B,B_avg,C,W,b,D,lamb] = gradient_descent_runner_avg_bias(corr,B_init,B_avg_init,C_init,W_init,b_init,D_init,Y,lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1)
%%runs gradient descent using alternating minimisation

%Initilise
num_iter =200;
B_old = B_init;
B_avg_old = B_avg_init;
C_old = C_init;
D_old = D_init;
W_old = W_init;
b_old =b_init;
lamb_old =lamb_init;
thresh = 10e-04;


    %Iterate
    err_out =[];
%     plot(0,0)
%     title('Gradent Descent Run ')
%     xlabel('Number of iterations')
%     ylabel('Value of obejctive function')

    for i = 1:num_iter
        
        err_out= horzcat(err_out,error_compute_avg(corr,B_old,B_avg_old,C_old,Y-b_old*ones(size(Y)),W_old,D_old,lamb_old,lambda,lambda_1,lambda_2,lambda_3));
        fprintf(' At iteration %d || Error: %f \n',i,err_out(i))
%         plot(1:i,err_out,'r');
%         hold on;
%         drawnow;
%         
        if (i<25)
           [B,B_avg,C,D,W,b,lamb] = alt_min_avg_bias(corr,B_old,B_avg_old,C_old,W_old,b_old,D_old,lamb_old,Y,lambda,lambda_1,lambda_2,lambda_3,lr1); 
        else
            %lambda_1 = lambda_1*1.05;
           [B,B_avg,C,D,W,b,lamb] = alt_min_avg_bias(corr,B_old,B_avg_old,C_old,W_old,b_old,D_old,lamb_old,Y,lambda,lambda_1,lambda_2,lambda_3,lr1); 
        end
        B_old = B;
        B_avg_old =B_avg;
        C_old = C;
        D_old =D;
        W_old =W;
        b_old =b;
        lamb_old =lamb;
    
        if (i>1 && abs((err_out(i)-err_out(i-1))) < thresh)
           break;
        end
    
    end
    
    
end

