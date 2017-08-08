%valores iniciais
x0 = 0;
y0 = 2;

xn = 4;

tamanhopasso = 1;
yanterior = -0.3929953;

qtdX = 4; %quantidade de valores que existem no intervalo especificado                

funcao = @(x,y) 4*exp(0.8*x) - 0.5*y;

heuninicionautomatico(funcao, x0, y0, xn, tamanhopasso, yanterior, qtdX, valor_exato_X1, valor_exato_X2, valor_exato_X3, valor_exato_X4);