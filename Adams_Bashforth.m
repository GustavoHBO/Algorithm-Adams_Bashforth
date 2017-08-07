function yk = Adams_Bashforth(n, x, y, yn, h)
%Matriz de coeficientes do método de Adams_Bashforth
%---------------------------------%
a = [1, 3, 23, 55, 1901;
     0, -1, -16, -59, -2774;
     0, 0, 5, 37, 2616;
     0, 0, 0, -9, -1274;
     0, 0, 0, 0, 251];
b = [1, 1/2, 1/12, 1/24, 1/720];
%---------------------------------%
%Variável acumulativa
somar = 0;

%Somatório
%---------------------------------%
for i=1:n
    somar = a(i,n)*(x(n-i+1) + y(n-i+1) -1) + somar;
end
%---------------------------------%

%Aplicação do método
yk = b(n)*(somar);
yk = h*yk;
yk = yn + yk;
yk = h*(n) + yk -1;