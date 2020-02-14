funcprot(0)
function [x,y]=find_next_pivot(a,i,j)
    flag=0
    for k=j:3
        for l=i:3
            if(a(l,k)<>0)
                x=l
                y=k
                return
            end
        end
    end
    
    x=-1
    y=-1         
endfunction

function A=rowswap(a,new,old)
    a([new,old],:)=a([old,new],:)
    A=a
endfunction
/*
global L
for(i=1:3)
        for( j=1:3)
            L(i,j)=0
        end
        L(i,i)=1
end
disp(L)*/
function [A,L]=make_zero(a,x,y,upbelow,l)
    if(upbelow==1)   
        for i=x+1:3
            if(a(i,y)<>0)
                if(l(i,y)==0)
                    l(i,y)=a(i,y)/a(x,y)
                end
                a(i,:)=a(i,:)-(a(i,y)/a(x,y))*a(x,:)               
                //disp(l)
            end        
        end
    end
    A=a
    L=l
    //disp(L)
endfunction



function [U,no_of_piv,piv,swap,ps,L]=u_matrix(A,l)
piv_i=1
piv_j=1
no_of_piv=0
pt=1
ps=1
swap_t(1,1)=0
for i=1:3    
    if(piv_i>3 | piv_j>3)
        break
    end
    [x,y]=find_next_pivot(A,piv_i,piv_j)
    piv(pt,1)=x
    piv(pt,2)=y
    pt=pt+1
    //disp(x,"x is")
    //disp(y,"y is")
    if(x==-1 & y==-1)
        break
    end
    if(x<>piv_i)
        A=rowswap(A,x,piv_i)
        swap_t(ps,1)=x
        swap_t(ps,2)=piv_i
        ps=ps+1
        x=piv_i
        //disp(A,"After rowswap")
    end
    no_of_piv=no_of_piv+1
    
    //B(p_t,0)=piv_i
    //B(p_t,1)=piv_j
    //p_t=p_t+1
    if(x<>3)
        [A,l]=make_zero(A,x,y,1,l)   //1 means make below zero
    end
    //disp(A)
    piv_i=x+1
    piv_j=y+1
end
U=A
L=l
swap=swap_t
endfunction




function gaussian_elimination()
    disp("GAUSSIAN ELIMINATION")
    disp("---------------------------------------------")
    mprintf("Enter values for A :\n")
    for i=1:3
        for j=1:3
            mprintf("Enter value for (%d,%d)",i,j)
            a(i,j)=input("=")
        end
    end
    
    mprintf("Enter value for B :\n")
    for i=1:3
        mprintf("Enter value for %d",i)
        b(i)=input("=")
    end
           
    for(i=1:3)
        for( j=1:3)
            L(i,j)=0
        end
        L(i,i)=1
    end       
    A=[a b]
    disp(A)
    disp("-------------------------------------------------")
    [U,no_of_piv,piv,swap,ps,L]=u_matrix(A,L)
    mprintf("no of pivots : %d\n",no_of_piv)
    if(no_of_piv==0)
        disp("Zero matrix")
        return
    end
    
    if(no_of_piv==3)
        z=U(3,4)/U(3,3)
        y=(U(2,4)-z*U(2,3))/U(2,2)
        x=(U(1,4)-z*U(1,3)-y*U(1,2))/U(1,1)    
        disp(U,"Final Matrix [U c]=")
        disp(x,"x=")
        disp(y,"y=")
        disp(z,"z=")
        return
    end
    
    if(no_of_piv==2)
        if(U(3,4)<>0)
            if(U(3,3)==0)
             mprintf("No solution\n")
                mprintf("[U c] is ")
                disp(U)
                //print pivots 
                return
             end
             
             z_t=U(3,4)/U(3,3)
             z_t2=U(2,4)/U(2,3)
             if(z_t<>z_t2)
                 mprintf("No solution\n")
                 mprintf("[U c] is ")
                 disp(U)
                 //print pivots 
                 return
             end                 
        end
       
        disp("Infinite solution : ")
        if(U(2,2)<>0)
            z=0
            y=(U(2,4)-z*U(2,3))/U(2,2)
            x=(U(1,4)-z*U(1,3)-y*U(1,2))/U(1,1) 
            disp(U,"Final Matrix [U c]=")
            disp("Assuming z is 0")
            disp(x,"x=")
            disp(y,"y=")
            disp(z,"z=")
            return
        end
        
        if(U(2,3)<>0)
            z=U(2,4)/U(2,3)
            y=0
            x=(U(1,4)-z*U(1,3)-y*U(1,2))/U(1,1) 
            disp(U,"Final Matrix [U c]=")
            disp("Assuming y is 0")
            disp(x,"x=")
            disp(y,"y=")
            disp(z,"z=")
            return
        end
     end
     
     if(no_of_piv==1)
         disp("Only one pivot : Infinite solutions")
         disp(U,"Final Matrix [U c]=")
     end
endfunction


function LU()
    disp("---------------------------------------------")
    disp("LU DECOMPOSITION")
    disp("---------------------------------------------")
    mprintf("Enter values for A :\n")
    for i=1:3
        for j=1:3
            mprintf("Enter value for (%d,%d)",i,j)
            a(i,j)=input("=")
        end
    end
    //disp(L)
    
        for(i=1:3)
        for( j=1:3)
            L(i,j)=0
        end
        L(i,i)=1
        end
    //disp(L)
    [U,no_of_piv,piv,swap,ps,L]=u_matrix(a,L)
    //disp(U)
    //disp(L)
    //disp(swap,"Swap is",ps)  
    //disp(L)
    for i=1:ps-1
        g=swap(i,1)
        k=swap(i,2)
        if(g==1 | k==1)
            break
        end
        L([g,k],:)=L([g,k],:)
    end
    disp("A=LU")
    disp(a,"A=")
    disp(L,"L=")
    disp(U,"U=")
    
endfunction


function gauss_jordan()
    disp("---------------------------------------------")
    disp("GAUSS JORDAN")
    disp("---------------------------------------------")
    mprintf("Enter values for A :\n")
    for i=1:3
        for j=1:3
            mprintf("Enter value for (%d,%d)",i,j)
            a(i,j)=input("=")
        end
    end
    I=eye(3,3)
    a=[a I]
     for(i=1:3)
        for( j=1:3)
            L(i,j)=0
        end
        L(i,i)=1
    end
    [U,no_of_piv,piv,swap,ps,L]=u_matrix(a,L)
    //disp(U,"U is ")
    if(no_of_piv<>3)
        disp("Inverse does not exist")
        disp(U,"[U c] is ")
        return
    end
        U(2,:)=U(2,:)-(U(2,3)/U(3,3))*U(3,:)
        U(1,:)=U(1,:)-(U(1,3)/U(3,3))*U(3,:)
        U(1,:)=U(1,:)-(U(1,2)/U(2,2))*U(2,:)
        U(3,:)=U(3,:)/U(3,3)
        U(2,:)=U(2,:)/U(2,2)
        U(1,:)=U(1,:)/U(1,1)
        disp("Inverse is ")
        i=U(:,[4,5,6])
        disp(i)
    
    
endfunction


gaussian_elimination()
LU()
gauss_jordan()

