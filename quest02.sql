CREATE OR REPLACE FUNCTION f_criar_cirurgia(
  codigo_cirurgia VARCHAR(20), 
  codigo_paciente VARCHAR(20),
  data_cirurgia DATE, 
  descricao_cirurgia text
) RETURNS record
AS 
$$
DECLARE
  result_consulta INTEGER;
  paciente_existente INTEGER;
  sid_cirurgia INTEGER;
  dados_cirurgia record;
BEGIN 
  SELECT paciente.id_paciente INTO paciente_existente
  FROM paciente
  WHERE codigo = codigo_paciente;

  SELECT paciente.id_paciente INTO result_consulta 
  FROM paciente
  INNER JOIN cirurgia ON paciente.id_paciente = cirurgia.id_paciente
  WHERE codigo_paciente = paciente.codigo
  AND descricao_cirurgia = cirurgia.descricao
  AND data_cirurgia = cirurgia.data;
  
  SELECT nextval('sid_cirurgia') INTO sid_cirurgia;

  IF (paciente_existente IS NOT NULL) THEN 
    IF (result_consulta IS NULL) THEN
      INSERT INTO cirurgia VALUES (
        sid_cirurgia,
        codigo_cirurgia,
        data_cirurgia, 
        descricao_cirurgia,
        paciente_existente
      );

      SELECT * INTO dados_cirurgia
      FROM cirurgia c
      WHERE c.id_cirurgia = sid_cirurgia;
    ELSE
      RAISE 'Cirurgia já cadastrada!';
    END IF;
  ELSE 
    RAISE 'Paciente não encontrado!';
  END IF;

  RETURN dados_cirurgia;
END;
$$
LANGUAGE PLPGSQL;

-- correto
-- SELECT f_criar_cirurgia ('c5', 'p1', '2024-04-01', 'Bico de papagaio');
-- incorreto
-- SELECT f_criar_cirurgia ('c6', 'p5', '2024-04-01', 'Retirar dente');