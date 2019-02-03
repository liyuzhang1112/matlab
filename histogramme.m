function y = histogramme(data,bins);
intervalle = linspace(min(data),max(data),bins);
Num(1) = 0;
for n = 2:bins
    n1 = find(data < intervalle(n));
    n2 = find(data < intervalle(n-1));
    Num(n) = length(n1)-length(n2);
end
y = bar(intervalle,Num);