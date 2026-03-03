CREATE DATABASE IF NOT EXISTS systemace_db;
USE systemace_db;

CREATE TABLE IF NOT EXISTS funcionario (
  idfuncionario INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(70) NULL,
  sobrenome VARCHAR(70) NULL,
  cpf VARCHAR(45) NULL,
  email VARCHAR(70) NULL,
  senha VARCHAR(300) NULL,
  funcao VARCHAR(70) NULL,
  status ENUM('Ativo', 'Inativo') NULL, 
  data_nascimento DATE NULL,
  telefone VARCHAR(15) NULL,
  PRIMARY KEY (idfuncionario)
);

CREATE TABLE IF NOT EXISTS epis (
  idepis INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  tipo VARCHAR(45) NULL,
  quantidade VARCHAR(45) NULL,
  disponivel TINYINT(1) NULL,
  data_validade DATE NULL,
  codigo_patrimonio VARCHAR(20) NULL,
  PRIMARY KEY (idepis)
);

CREATE TABLE IF NOT EXISTS aluno (
  idaluno INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  sobrenome VARCHAR(100) NULL,
  cpf VARCHAR(45) NULL,
  email VARCHAR(100) NULL,
  senha VARCHAR(300) NULL,
  data_nascimento DATE NULL,
  telefone VARCHAR(15) NULL,
  PRIMARY KEY (idaluno)
);

CREATE TABLE IF NOT EXISTS turma (
  idturma INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(70) NULL,
  nomenclatura VARCHAR(70) NULL,
  data_inicio DATE NULL,
  data_termino DATE NULL,
  horario_inicio TIME NULL,
  horario_termino TIME NULL,
  capacidade_maxima INT NULL,
  PRIMARY KEY (idturma)
);

CREATE TABLE IF NOT EXISTS funcionario_has_epis (
  funcionario_id INT NOT NULL,
  epis_id INT NOT NULL,
  data_entrega DATE NULL,
  data_devolucao DATE NULL,
  PRIMARY KEY (funcionario_id, epis_id),
  CONSTRAINT fk_funcionario_has_epis_funcionario
    FOREIGN KEY (funcionario_id)
    REFERENCES funcionario (idfuncionario),
  CONSTRAINT fk_funcionario_has_epis_epis
    FOREIGN KEY (epis_id)
    REFERENCES epis (idepis)
);

CREATE TABLE IF NOT EXISTS aluno_has_epis (
  aluno_id INT NOT NULL,
  epis_id INT NOT NULL,
  PRIMARY KEY (aluno_id, epis_id),
  CONSTRAINT fk_aluno_has_epis_aluno
    FOREIGN KEY (aluno_id)
    REFERENCES aluno (idaluno),
  CONSTRAINT fk_aluno_has_epis_epis
    FOREIGN KEY (epis_id)
    REFERENCES epis (idepis)
);

CREATE TABLE IF NOT EXISTS aluno_has_turma (
  aluno_id INT NOT NULL,
  turma_id INT NOT NULL,
  data_matricula DATE NULL,
  status ENUM('Matriculado', 'Trancado', 'Concluído') NULL,
  PRIMARY KEY (aluno_id, turma_id),
  CONSTRAINT fk_aluno_has_turma_aluno
    FOREIGN KEY (aluno_id)
    REFERENCES aluno (idaluno),
  CONSTRAINT fk_aluno_has_turma_turma
    FOREIGN KEY (turma_id)
    REFERENCES turma (idturma)
);