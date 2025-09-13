--Descobrir a média de renda total dos indivíduos.
SELECT avg(total_income)
FROM credito_experimento;
--Resultado: R$181.228,00

--Qual a distribuição dos tipos de renda nesse conjunto de dados?
SELECT 
    income_type,
    COUNT(*) AS count
FROM 
    credito_experimento
GROUP BY 
    income_type;

/* Resultado: Working = 4960; Commercial associate = 2312; Pensioner = 1712; State servant = 722; Student = 3 */

/* Qual a proporção dos tipos de renda nesse conjunto de dados? 
Aqui podemos puxar diretamente numa única seleção a dimensão - income_type, o volume total de pessoas, e uma coluna de proporção percentual
com uma expressão que retorna a porcentagem de pessoas de cada income_type em relação ao total geral da base, com duas casas decimais, utilizando funções de agregação (COUNT), 
função janela (SUM(...) OVER ()) - indica que a soma será feita sobre todas as linhas da consulta, sem partição nem ordenação, ou seja, pega o total geral., multiplicação e arredondamento (ROUND). */
SELECT 
    income_type,
    COUNT(DISTINCT id) AS total_pessoas,
    ROUND(
        (COUNT(DISTINCT id) * 100.0) / SUM(COUNT(DISTINCT id)) OVER (),
        2
    ) AS proporcao_percentual
FROM credito_experimento
GROUP BY income_type


/* Resultado:
Working tem 4960 registros e apresenta uma proporção de 51.08%; Commercial associate tem 2312 registros e apresenta uma proporção de 23.81%;
Pensioner apresenta um total de 1712 registros e uma proporção de 17.63%; State servant apresenta um total de 722 registros e uma proporção de 7.43%. 
Por fim, studens apresenta um total de 3 registros e uma proporção de 0.000308%. */
