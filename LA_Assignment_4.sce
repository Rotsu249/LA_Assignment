function gram_Schmidt()
    A=input("Enter the matrix : ") 
disp(A,'A=');

[m,n]=size(A); 

for i=1:n 
 V(:,i)=A(:,i);
  for j=1:i-1 
    R(j,i)=V(:,j)'*A(:,i); 
    V(:,i)=V(:,i)-R(j,i)*V(:,j); 
  end 
 R(i,i)=norm(V(:,i)); 
 V(:,i)=V(:,i)/R(i,i);
end 

disp(V,'The matrix Q = ');
disp('------------------------------------------------')
endfunction


function eigen_Vectors()
    A=input("Enter the matrix : ")

X=poly(0,'X');
X=X; 

charmat=A-X*eye(3,3); 
disp(charmat,'The characteristic matrix is: ');

charpoly=poly(A,'X');
disp(charpoly,'The characteristic polynomial is: '); 

X=spec(A);
disp(X,'The eigen values of A are : ');

[evec,eval]=spec(A); 
disp(evec,'The eigen vectors of A are :  ');

disp('------------------------------------------------')
endfunction

function largest_Eigen()
    A=input("Enter the matrix : ")

u=input("Enter the initial vector [AS COLUMN] : ")
v=A*u;
a=max(u); 

while abs(max(v)-a)>0.002 
disp(v,"Current eigen vector is") 
a=max(v); 
disp(a,"Current eigen value is") 
u=v/max(v); 
v=A*u; 
end 

format('v',4);
disp(max(v),'The largest eigen value is :')
format('v',5) 
disp(u,'The corresponding eigen vector is :')

disp('------------------------------------------------')    
endfunction

disp("LA ASSIGNMENT 4")
disp("1)GRAM_SCHMIDT PROCESS")
disp("---------------------------------")
gram_Schmidt();
disp("2)EIGEN VECTORS")
eigen_Vectors();
disp("---------------------------------")
disp("3)LARGEST EIGEN VALUE")
largest_Eigen()
disp("-------------The End--------------------")
