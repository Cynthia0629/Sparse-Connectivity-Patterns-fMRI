function [B,C,W1,W2,D,lamb] = gradient_descent_runner_hacky(corr,B_init,C_init,W1_init,W2_init,z,D_init,Y,lamb_init,lambda,lambda_1,lambda_21,lambda_22,lambda_3,lr1)
%%runs gradient descent using alternating minimisation

%Initilise
num_iter =200;
B_old = B_init;
C_old = C_init;
D_old = D_init;
W1_old = W1_init;
W2_old = W2_init;

lamb_old =lamb_init;
thresh = 10e-04;


    %Iterate
    err_out =[];
%     plot(0,0)
%     title('Gradent Descent Run ')
%     xlabel('Number of iterations')
%     ylabel('Value of obejctive function')

    for i = 1:num_iter
        
        err_out= horzcat(err_out,error_compute_hacky(corr,B_old,C_old,Y,W1_old,W2_old,z,D_old,lamb_old,lambda,lambda_1,lambda_21,lambda_22,lambda_3));
        fprintf(' At iteration %d || Error: %f \n',i,err_out(i))
%         plot(1:i,err_out,'r');
%         hold on;
%         drawnow;
%         
        if (i<10)
           [B,C,D,W1,W2,lamb] = alt_min_hacky(corr,B_old,C_old,W1_old,W2_old,z,D_old,lamb_old,Y,lambda,lambda_1,lambda_21,lambda_22,lambda_3,lr1); 
        else
            %lambda_1 = lambda_1*1.05;
           [B,C,D,W1,W2,lamb] = alt_min_hacky(corr,B_old,C_old,W1_old,W2_old,z,D_old,lamb_old,Y,lambda,lambda_1,lambda_21,lambda_22,lambda_3,lr1);
        end
        
        if(err_out(i)> 10e10)
               fprintf('\n This diverged, you lost,your life is a mess \n ')
               B=B_old;
               C=C_old;
               D=D_old;
               W1=W1_old;
               W2=W2_old;
               lamb =lamb_old;
               break;
        end
        
        B_old = B;
        C_old = C;
        D_old =D;
        W1_old =W1;
        W2_old =W2;
        lamb_old =lamb;
    
        if (i>1 && (abs((err_out(i)-err_out(i-1))) < thresh || (err_out(i)>err_out(i-1))))
           
           break;
        end
    
    end
    
    
end

