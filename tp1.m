clear all;
close all;
%%
%charger le fichier
x = csvread('cardiac.dat',2,1);
%%
%Extraire les donnees
c2 = x(:,2);
%%
%visualiser en texte
str = num2str(c2);
disp(str);
%%
C2 = sort(c2);
N = length(C2);
%subplot(2,1,1);plot(C2,(1:N)/N,'r');title('repartition');
%%
%first = min(c2);
%last = max(c2);
%intervalle = linspace(first,last,25);
%Num(1) = 0;
%for n = 2:25
    %n1 = find(c2 < intervalle(n));
    %n2 = find(c2 < intervalle(n-1));
    %Num(n) = length(n1)-length(n2);
%end
%subplot(2,1,2);bar(intervalle,Num);
result = histogramme(c2, 25);