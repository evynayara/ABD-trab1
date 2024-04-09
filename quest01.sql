-- Evelyn Nayara Amaral Dias

DROP DATABASE IF EXISTS trab1_abds5;

CREATE DATABASE trab1_abds5
	WITH
	OWNER = postgres
	ENCODING = 'UTF8'
	CONNECTION LIMIT = -1;

ALTER DATABASE trab1_abds5 SET datestyle TO 'ISO, DMY';
-- Apenas se necessário
SET datestyle TO postgres, dmY;

\c trab1_abds5

SET TIMEZONE TO 'UTC';

CREATE TABLE paciente (
  id_paciente SERIAL PRIMARY KEY,
  codigo VARCHAR(25) UNIQUE NOT NULL,
  nome VARCHAR(150) NOT NULL,
  idade INTEGER NOT NULL
);

CREATE TABLE medico (
  id_medico SERIAL PRIMARY KEY,
  crm VARCHAR(25) UNIQUE NOT NULL,
  nome VARCHAR(150) NOT NULL,
  especialidade VARCHAR(150) NOT NULL
);

CREATE TABLE atende (
  id_atende SERIAL PRIMARY KEY,
  id_paciente INTEGER NOT NULL REFERENCES paciente(id_paciente),
  id_medico INTEGER NOT NULL REFERENCES medico(id_medico),
  data DATE NOT NULL
);

CREATE TABLE cirurgia (
  id_cirurgia SERIAL PRIMARY KEY,
  codigo VARCHAR(25) UNIQUE NOT NULL,
  data DATE NOT NULL,
  descricao VARCHAR(256) NOT NULL,
  id_paciente INTEGER NOT NULL REFERENCES paciente(id_paciente)
);

CREATE SEQUENCE sid_paciente;
CREATE SEQUENCE sid_medico;
CREATE SEQUENCE sid_atende;
CREATE SEQUENCE sid_cirurgia;

INSERT INTO paciente VALUES 
  (NEXTVAL('sid_paciente'), 'p1', 'João', 12),
  (NEXTVAL('sid_paciente'), 'p2', 'Maria', 38),
  (NEXTVAL('sid_paciente'), 'p3', 'Antonio', 29),
  (NEXTVAL('sid_paciente'), 'p4', 'Pedro', 21);

INSERT INTO medico VALUES 
  (NEXTVAL('sid_medico'), 'm4', 'Pedro', 'Clínico geral'),
  (NEXTVAL('sid_medico'), 'm1', 'Vitor', 'Oftalmologista'),
  (NEXTVAL('sid_medico'), 'm2', 'Joao', 'Clínico geral'),
  (NEXTVAL('sid_medico'), 'm3', 'Gustavo', 'Pediatra');

INSERT INTO atende VALUES 
  (NEXTVAL('sid_atende'), 1, 2, '09-02-2008'),
  (NEXTVAL('sid_atende'), 1, 2, '26-03-2006'),
  (NEXTVAL('sid_atende'), 2, 1, '11-09-2003'),
  (NEXTVAL('sid_atende'), 3, 3, '13-10-2007'),
  (NEXTVAL('sid_atende'), 2, 2, '08-05-2008');

INSERT INTO cirurgia VALUES 
  (NEXTVAL('sid_cirurgia'), 'c1', '25-07-2008', 'Apendicite', 1),
  (NEXTVAL('sid_cirurgia'), 'c2', '07-02-2001', 'Retirada de cálculo renal', 2),
  (NEXTVAL('sid_cirurgia'), 'c3', '14-11-2007', 'Unha encravada',3),
  (NEXTVAL('sid_cirurgia'), 'c4', '23-01-2008', 'Implante de silicone', 2);
