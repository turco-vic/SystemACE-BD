CREATE DATABASE IF NOT EXISTS systemace_db;
USE systemace_db;

CREATE TABLE IF NOT EXISTS funcionario (
  idfuncionario INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(70) NOT NULL,
  sobrenome VARCHAR(70),
  cpf VARCHAR(14) UNIQUE NOT NULL,
  email VARCHAR(70) UNIQUE NOT NULL,
  senha VARCHAR(300) NOT NULL,
  funcao VARCHAR(70),
  status ENUM('Ativo', 'Inativo') DEFAULT 'Ativo',
  data_nascimento DATE,
  telefone VARCHAR(15),
  PRIMARY KEY (idfuncionario)
);

CREATE TABLE IF NOT EXISTS epis (
  idepis INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  tipo VARCHAR(45),
  quantidade INT DEFAULT 0,
  disponivel BOOLEAN DEFAULT 1,
  data_validade DATE,
  codigo_patrimonio VARCHAR(20) UNIQUE, 
  PRIMARY KEY (idepis)
);

CREATE TABLE IF NOT EXISTS aluno (
  idaluno INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  sobrenome VARCHAR(100),
  cpf VARCHAR(14) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  senha VARCHAR(300) NOT NULL,
  data_nascimento DATE,
  telefone VARCHAR(15),
  PRIMARY KEY (idaluno)
);

CREATE TABLE IF NOT EXISTS turma (
  idturma INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(70) NOT NULL,
  nomenclatura VARCHAR(70),
  data_inicio DATE,
  data_termino DATE,
  horario_inicio TIME,
  horario_termino TIME,
  capacidade_maxima INT,
  PRIMARY KEY (idturma)
);

CREATE TABLE IF NOT EXISTS funcionario_has_epis (
  id_entrega_func INT NOT NULL AUTO_INCREMENT,
  funcionario_id INT NOT NULL,
  epis_id INT NOT NULL,
  data_entrega DATE DEFAULT (CURRENT_DATE),
  data_devolucao DATE NULL,
  PRIMARY KEY (id_entrega_func),
  FOREIGN KEY (funcionario_id) REFERENCES funcionario (idfuncionario) ON DELETE CASCADE,
  FOREIGN KEY (epis_id) REFERENCES epis (idepis) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS aluno_has_epis (
  id_entrega_aluno INT NOT NULL AUTO_INCREMENT,
  aluno_id INT NOT NULL,
  epis_id INT NOT NULL,
  data_entrega DATE DEFAULT (CURRENT_DATE),
  PRIMARY KEY (id_entrega_aluno),
  FOREIGN KEY (aluno_id) REFERENCES aluno (idaluno) ON DELETE CASCADE,
  FOREIGN KEY (epis_id) REFERENCES epis (idepis) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS aluno_has_turma (
  aluno_id INT NOT NULL,
  turma_id INT NOT NULL,
  data_matricula DATE DEFAULT (CURRENT_DATE),
  status ENUM('Matriculado', 'Trancado', 'Concluído') DEFAULT 'Matriculado',
  PRIMARY KEY (aluno_id, turma_id),
  FOREIGN KEY (aluno_id) REFERENCES aluno (idaluno) ON DELETE CASCADE,
  FOREIGN KEY (turma_id) REFERENCES turma (idturma) ON DELETE CASCADE
);