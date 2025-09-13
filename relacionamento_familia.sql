*/ Qual é a média de filhos por família? */
SELECT avg(num_children) AS media_filhos
FROM credito_experimento;
*/ Resultado: 0.4228035843032238 /*

*/ Descubrir a proporção de indivíduos que possuem carro e propriedade. */
  
WITH counts AS (
    SELECT 
        COUNT(DISTINCT CASE WHEN own_car = 1 THEN id END) AS car_owner_count,
        COUNT(DISTINCT CASE WHEN own_property = 1 THEN id END) AS prop_owner_count,
        COUNT(DISTINCT id) AS volume_pessoas,
        COUNT(DISTINCT CASE WHEN gender = 1 THEN id END) AS volume_mulheres,
        COUNT(DISTINCT CASE WHEN gender = 0 THEN id END) AS volume_homens,
        
    FROM 
        credito_experimento
)
SELECT 
    car_owner_count * 1.0 / volume_pessoas AS car_proportion,
    prop_owner_count * 1.0 / volume_pessoas AS property_proportion,
    CASE 
        WHEN gender = 0 THEN 'masculino' 
        WHEN gender = 1 THEN 'feminino'
    END AS genero
FROM counts
  
*/ A mesmoa lógica das proporções anteriores foi utilizada aqui. Deve-se, inicialmente, 
  medir a quantidade de pessoas que possuem propriedades, assim como a quantidade de pessoas que possuem carro. 
Após isso, levanta-se a quantidade de pessoas no dataset. 
A proporção é calcula separadamente, primeiro definindo a propoção de pessoas com carro e, após isso, a proporção de pessoas com propriedade. 
Resultado: car_proportion = 36.77%; property_proportion = 67.15%.
  */
