CREATE OR REPLACE FUNCTION f_verifica_data_cirurgia()
RETURNS TRIGGER AS 
$$
BEGIN
  IF NEW.data > CURRENT_DATE THEN
    RAISE 'Data da cirurgia não pode ser maior que a data corrente!';
  END IF;
  RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;

CREATE TRIGGER t_verifica_data_cirurgia
BEFORE INSERT ON cirurgia 
FOR EACH ROW 
EXECUTE FUNCTION f_verifica_data_cirurgia();

-- certo
-- INSERT INTO cirurgia VALUES 
-- (nextval('sid_cirurgia'), 'c5', '2024-04-01', 'Ernia de Disco', 1);

-- errado
-- INSERT INTO cirurgia VALUES 
-- (nextval('sid_cirurgia'), 'c6', '2024-04-01', 'Bariatrica', 1);