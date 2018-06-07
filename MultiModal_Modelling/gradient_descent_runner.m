function [B,C,W,D,lamb] = gradient_descent_runner(corr,B_init,C_init,W_init,D_init,Y,lamb_init,Q,lambda,lambda_1,lambda_2,lambda_3,lr1)
%%runs gradient descent using alternating minimisation

%Initilise
num_iter =200;
B_old = B_init;
C_old = C_init;
D_old = D_init;
W_old = W_init;
lamb_old =lamb_init;
thresh = 10e-04;


    %Iterate
    err_out =[];
    plot(0,0)
    title('Gradent Descent Run ')
    xlabel('Number of iterations')
    ylabel('Value of obejctive function')

    for i = 1:num_iter
        
        err_out= horzcat(err_out,error_compute(corr,B_old,C_old,Y,W_old,D_old,lamb_old,Q,lambda,lambda_1,lambda_2,lambda_3));
        fprintf(' At iteration %d || Error: %f \n',i,err_out(i))
        plot(1:i,err_out,'r');
        hold on;
        drawnow;
        
        if (i<10)
           [B,C,D,W,lamb] = alt_min(corr,B_old,C_old,W_old,D_old,lamb_old,Q,Y,lambda,lambda_1,lambda_2,lambda_3,lr1); 
        else
            %lambda_1 = lambda_1*1.05;
           lr2 = lr1*0.5;
           if (i>20)
            lr2 = lr1*0.25;
           end
           [B,C,D,W,lamb] = alt_min(corr,B_old,C_old,W_old,D_old,lamb_old,Q,Y,lambda,lambda_1,lambda_2,lambda_3,lr2); 
        end
        
        if(err_out(i)> 10e10)
               fprintf('\n This diverged, you lost,your life is a mess \n ')
               B=B_old;
               C=C_old;
               D=D_old;
               W=W_old;
               lamb =lamb_old;
               break;
        end
        
        B_old = B;
        C_old = C;
        D_old =D;
        W_old =W;
        lamb_old =lamb;
    
        if (i>1 && (abs((err_out(i)-err_out(i-1))) < thresh || (err_out(i)>err_out(i-1))))
           if(err_out(i)>err_out(i-1))
               fprintf('\n Exiting due to increase in function value, at iter %d',i)
           end
           break;
        end
    
    end
    
    
end

