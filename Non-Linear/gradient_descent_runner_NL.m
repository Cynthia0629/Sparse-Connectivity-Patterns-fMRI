function [B,C,D,lamb] = gradient_descent_runner_NL(corr,B_init,C_init,D_init,Y,lamb_init,lambda,lambda_1,lambda_2,lambda_3,lr1)
%%runs gradient descent using alternating minimisation

%Initilise
num_iter =100;
B_old = B_init;
C_old = C_init;
D_old = D_init;
lamb_old =lamb_init;
thresh = 10e-04;


    %Iterate
    err_out =[];
    plot(0,0)
    title('Gradent Descent Run ')
    xlabel('Number of iterations')
    ylabel('Value of obejctive function')

    for i = 1:num_iter
        
        err_out= horzcat(err_out,error_compute_NL(corr,B_old,C_old,Y,D_old,lamb_old,lambda,lambda_1,lambda_2,lambda_3,1));
        fprintf(' At iteration %d || Error: %f \n',i,err_out(i))
        plot(1:i,err_out,'r');
        hold on;
        drawnow;
        
        if (i<10)
        
           [B,C,D,lamb] = alt_min_NL(corr,B_old,C_old,D_old,lamb_old,Y,lambda,lambda_1,lambda_2,lambda_3,lr1); 
        
        else
           
           lr2 = lr1*0.25;
           [B,C,D,lamb] = alt_min_NL(corr,B_old,C_old,D_old,lamb_old,Y,lambda,lambda_1,lambda_2,lambda_3,lr2); 
        end
        
        if(err_out(i)> 10e10)
               fprintf('\n This diverged, you lost,your life is a mess \n ')
               B=B_old;
               C=C_old;
               D=D_old;
               lamb =lamb_old;
               break;
        end
        
        B_old = B;
        C_old = C;
        D_old =D;
        lamb_old =lamb;
    
        if (i>1 && (abs((err_out(i)-err_out(i-1))) < thresh || (err_out(i)>err_out(i-1))))
           if(err_out(i)>err_out(i-1))
               fprintf('\n Exiting due to increase in function value, at iter %d \n',i)
           end
           break;
        end
    
    end
    
    
end

