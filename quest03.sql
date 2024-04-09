CREATE OR REPLACE FUNCTION f_desempenho_medico(
  data_inicial DATE, 
  data_final DATE
) RETURNS SETOF record
AS 
$$
DECLARE
  dados_medico record;
BEGIN 
  FOR dados_medico IN 
    SELECT medico.nome, COUNT(atende.id_medico) 
    FROM medico 
    JOIN atende ON medico.id_medico = atende.id_medico 
    WHERE atende.data BETWEEN data_inicial AND data_final 
    GROUP BY medico.nome
  LOOP
    RETURN NEXT dados_medico;
  END LOOP;
END;
$$
LANGUAGE PLPGSQL;

SELECT * FROM f_desempenho_medico('2003-01-01', '2006-12-31')
 AS (nome_medico VARCHAR(150), quantidade_atendimentos BIGINT);