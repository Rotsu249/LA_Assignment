funcprot(0)

function error_minimise()
    disp("-------------------------------------------------------------")
    disp("BEST FIT LINE")
    disp("-------------------------------------------------------------")
    n=input("Enter the number of lines/points : ");
    printf("\n")
    A(1,1)=0
    b(1,1)=0
    max=0;
    min=0;
    for(i=1:n)
        mprintf("Enter t%d: ",i);
        A(i,1)=input("")
        if(A(i,1)>max)
            max=A(i,1) ;
        end       
        if(A(i,1)<min)
            min=A(i,1);
        end
        mprintf("Enter b%d: ",i);
        b(i,1)=input("")
        printf("\n")
    end
   
    if(n==1)
        mprintf("The best fit line is %d + %dt=b\n",A(1,1),b(1,1))
        return
    end
    
    A_original=A
    A_temp=ones(n,1);
    A=[A_temp A];
    disp(A,"A : ");
    disp(b,"b: ")
    clf();
    scatter(A(:,2),b(:,1));
    b=A'*b;
    A=A'*A;
    xhat=inv(A)*b
    C=xhat(1,1);
    D=xhat(2,1)
    printf("The value of C=%f\n",C)
    printf("The value of D=%f\n",D)    
    mprintf("The best fit line is %f + %ft=b\n",C,D)
    disp(" Plotting the best fit line and original scatter plot : ")
    
    x = min-3:1:max+3;
    m = D;
    c = C;
    y = m * x + c;
    plot2d(x, y,color("red"))
    
    p=xhat;
    
endfunction




error_minimise();
