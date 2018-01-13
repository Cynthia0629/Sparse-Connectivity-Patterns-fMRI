function [B,C,W,D,lamb] = gradient_descent_runner(corr,B_init,C_init,W_init,D_init,Y,lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1)
%%runs gradient descent using alternating minimisation

%Initilise
num_iter =1000;
B_old = B_init;
C_old = C_init;
D_old = D_init;
W_old = W_init;
lamb_old =lamb_init;
thresh = 10e-06;


    %Iterate
    err_out =[];
    plot(0,0)
    title('Gradent Descent Run ')
    xlabel('Number of iterations')
    ylabel('Value of obejctive function')

    for i = 1:num_iter
        
        err_out= horzcat(err_out,error_compute(corr,B_old,C_old,Y,W_old,D_old,lamb_old,lambda,lambda_1,lambda_2,lambda_3));
        fprintf(' At iteration %d || Error: %f \n',i,err_out(i))
        plot(1:i,err_out,'b');
        hold on;
        drawnow;
        
        [B,C,D,W] = alt_min(corr,B_old,C_old,W_old,D_old,lamb_old,Y,lambda,lambda_1,lambda_2,lambda_3); 
    
        B_old = B;
        C_old = C;
        D_old =D;
        W_old =W;
    
        if (i>1 && abs(err_out(i)-err_out(i-1)) < thresh)
           break;
        end
    
    end
    
    
end

