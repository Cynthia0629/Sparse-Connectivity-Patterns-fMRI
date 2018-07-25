function [B,B_avg,C,W_ADOS,W_SRS,D,lamb] = gradient_descent_runner_multi_avg(corr,B_init,B_avg_init,C_init,W_init,D_init,Y_ADOS,Y_SRS,lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1)
%%runs gradient descent using alternating minimisation

%Initilise
num_iter =200;
B_old = B_init;
B_avg_old = B_avg_init;
C_old = C_init;
D_old = D_init;
W_ADOS_old = W_init;
W_SRS_old = W_init;
lamb_old =lamb_init;
thresh = 10e-06;


    %Iterate
    err_out =[];
%     plot(0,0)
%     title('Gradent Descent Run ')
%     xlabel('Number of iterations')
%     ylabel('Value of obejctive function')

    for i = 1:num_iter
        
        err_out= horzcat(err_out,error_compute_multi_avg(corr,B_old,B_avg_old,C_old,Y_ADOS,Y_SRS,W_ADOS_old,W_SRS_old,D_old,lamb_old,lambda,lambda_1,lambda_2,lambda_3));
        fprintf(' At iteration %d || Error: %f \n',i,err_out(i))
%         plot(1:i,err_out,'r');
%         hold on;
%         drawnow;
%         
        if (i<10)
           [B,B_avg,C,D,W_ADOS,W_SRS,lamb] = alt_min_multi_avg(corr,B_old,B_avg_old,C_old,W_ADOS_old,W_SRS_old,D_old,lamb_old,Y_ADOS,Y_SRS,lambda,lambda_1,lambda_2,lambda_3,lr1); 
        else
            %lambda_1 = lambda_1*1.05;
           [B,B_avg,C,D,W_ADOS,W_SRS,lamb] = alt_min_multi_avg(corr,B_old,B_avg_old,C_old,W_ADOS_old,W_SRS_old,D_old,lamb_old,Y_ADOS,Y_SRS,lambda,lambda_1,lambda_2,lambda_3,lr1);
        end
        
        if(err_out(i)> 10e10)
               fprintf('\n This diverged, you lost,your life is a mess \n ')
               B=B_old;
               B_avg=B_avg_old;
               C=C_old;
               D=D_old;
               W_ADOS=W_ADOS_old;
               W_SRS=W_SRS_old;
               lamb =lamb_old;
               break;
        end
        
        B_old = B;
        B_avg_old =B_avg;
        C_old = C;
        D_old =D;
        W_ADOS_old =W_ADOS;
        W_SRS_old =W_SRS;
        lamb_old =lamb;
    
        if (i>1 && (abs((err_out(i)-err_out(i-1))) < thresh || (err_out(i)>err_out(i-1))))
           
           break;
        end
    
    end
    
    
end

