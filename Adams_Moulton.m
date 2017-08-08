function yk = Adams_Moulton(n, x, y, yn, h)
%Matriz de coeficientes do método de Adams_Moulton
%---------------------------------%
a = [1, 1, 5, 9, 251;
     0, 1, 8, 19, 646;
     0, 0, -1, -5, -264;
     0, 0, 0, 1, 106;
     0, 0, 0, 0, -19];
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
yk = yk + b(n)*h*a(1,n)*((x(h*(n+1)) + yk));