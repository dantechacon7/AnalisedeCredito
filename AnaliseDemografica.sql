/* Calcular a média de idade dos indivíduos no conjunto de dados. */

SELECT avg(age)
FROM credito_experimento;
--Resultado: 43.784092

/* Determinar a proporção de indivíduos masculinos e femininos. 0 para masculino, 1 para feminino. 
  Primeiro, devemos contabilizar quantas pessoas são do gênero feminino, e quantas pessoas são do gênero masculino. */

SELECT 
    COUNT(DISTINCT id) as volume_pessoas,
    CASE WHEN gender = 0 THEN 'Masculino'
    WHEN gender = 1 THEN 'Feminino'
    ELSE null END AS gender
FROM 
    credito_experimento
GROUP BY 
    gender;
--Resultado: Gender Feminino = 3386; Gender Masculino = 6323

/* Agora, calculamos as proporções em relação ao total de pessoas do dataset. 
  Para isso, vamos contabilizar indivíduos por gênero, como foi feito na query acima, e levantar o total de indivíduos do dataset. 
E, por fim, uma seleção final que determina a proporção (proportion) de cada caso */
WITH calculos as (
  SELECT
  COUNT(DISTINCT CASE WHEN gender = 1 THEN id END) AS volume_mulheres,
  COUNT(DISTINCT CASE WHEN gender = 1 THEN id END) AS volume_homens,
  COUNT(DISTINCT id) AS volume_total
  FROM credito_experimento
)
SELECT 
format('%.1f%%', (volume_mulheres * 100.0) / volume_total) AS proporcao_feminina --proporção formatada com %
format('%.1f%%', (volume_homens * 100.0) / volume_total) AS proporcao_masculina
FROM calculos

/* Resultado: Gender 1 possui 3386 registros, numa proporção de 34.87% do dataset. Gender 0 possui 6323 registros, numa proporção de 65.12% do dataset./*
