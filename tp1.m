x = csvread('cardiac.dat',2,1);
c2 = x(:,2);
str = num2str(c2);
disp(str)
C2 = sort(c2);
N = length(C2);
subplot(2,1,1);plot(C2,(1:N)/N,'r');title('repartition');
subplot(2,1,2);bar(c2,'r');
