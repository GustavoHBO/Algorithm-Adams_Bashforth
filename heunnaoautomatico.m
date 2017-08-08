syms funcao fpreditor x x0 y y0 xn ximais1 corretor_ant corretor_ant_v corretor_ant_ant_v corretor_ant_ant tamanhopasso h preditor_v yanterior f

%valores iniciais
x0 = 0;
y0 = 2;

xn = 4;

tamanhopasso = 1;
yanterior = -0.3929953;

qtdX = 4; %quantidade de valores que existem no intervalo especificado

fprintf(sprintf('Para X = %d\n', 0));    
fprintf(sprintf('\n   RESULTADO                     E.R.P.                   E.A.'));                                
fprintf('\n2.0000000000000000       0.0000000000000000%%                -\n\n');                    

funcao = @(x,y) 4*exp(0.8*x) - 0.5*y;

%valores exatos
valor_exato_X1 = 6.194631;
valor_exato_X2 = 14.8439219;
valor_exato_X3 = 33.6771718;
valor_exato_X4 = 75.338926;

corretor_ant_ant_v = yanterior;
corretor_ant_v = y0;
xi = x0;

%formulas para cálculo do preditor e do corretor
preditor_f = @(corretor_ant_ant, f, h) corretor_ant_ant + f*2*h;
corretor_f = @(corretor_ant, h, f, fpreditor) corretor_ant + (h/2)*(f+fpreditor);

%cálculo do preditor inicial
f_corretor_ant_v = subs(funcao, {x, y}, {xi, corretor_ant_v}); %corretor anterior (y0, como é a primeira iteração) aplicado na função
preditor_inicial_v = subs(preditor_f, {corretor_ant_ant,f,h}, {corretor_ant_ant_v, subs(funcao, {x, y}, {xi, corretor_ant_v}), tamanhopasso}); %cálculo do preditor com base nos valores iniciais e no valor da função calculado anteriormente

%contadores para loop
contInterno = 0;
contExterno = 0;

preditor_iteracao_v = preditor_inicial_v; %define o preditor da iteração como sendo o preditor inicial

while(contExterno < qtdX)
    %define qual valor exato que será utilizado para cálculo do erro
    if(contExterno == 0) 
        valor_exato = valor_exato_X1;
    elseif (contExterno == 1)
        valor_exato = valor_exato_X2;
    elseif (contExterno == 2)
        valor_exato = valor_exato_X3;
    elseif (contExterno == 3)
        valor_exato = valor_exato_X4;
    end
    
    xi = xi + tamanhopasso;
    
    fprintf(sprintf('                             Para X = %d\n', contExterno+1));    
    fprintf(sprintf('\nRESULTADO                     E.R.P.                   E.A.'));  
    
    while(contInterno < 15) 
        %cálculo iterativo do novo corretor com base em corretor de
        %iterações anteriores
        corretor_iteracao_v = subs(corretor_f, {corretor_ant, h, f, fpreditor}, {corretor_ant_v, tamanhopasso, f_corretor_ant_v, subs(funcao, {x, y}, {xi, preditor_iteracao_v})});
        preditor_iteracao_v = corretor_iteracao_v;
        
        erro_relativo_percentual = ((valor_exato - corretor_iteracao_v)/(valor_exato))*100; %cálculo do erro relativo percentual
        
        if(contInterno == 0) 
            fprintf('\n%.16f       %.16f%%                -', double(corretor_iteracao_v), double(erro_relativo_percentual));                    
        else   
            erro_metodo = abs(((corretor_iteracao_v - corretor_iteracao_anterior_v)/corretor_iteracao_v)*100);
            fprintf('\n%.16f       %.16f%%       %.16f%%', double(corretor_iteracao_v), double(erro_relativo_percentual), double(erro_metodo));        
        end
        
        corretor_iteracao_anterior_v = corretor_iteracao_v; %armazena o corretor da iteração anterior
        contInterno = contInterno + 1;
    end
   
    corretor_ant_ant_v = corretor_ant_v; %armazena o corretor de duas iterações atrás        
    corretor_ant_v = corretor_iteracao_v; %armazena o corretor de uma iteração atrás
    
    %cálculo do novo preditor
    f_corretor_ant_v = subs(funcao, {x, y}, {xi, corretor_ant_v}); 
    preditor_iteracao_v = subs(preditor_f, {corretor_ant_ant,f,h}, {corretor_ant_ant_v, f_corretor_ant_v, tamanhopasso});
    
    contExterno = contExterno + 1;
    contInterno = 0;
    fprintf(sprintf('\n\n\n'));        
end
