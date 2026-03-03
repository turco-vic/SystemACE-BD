# SystemACE - Banco de Dados

## Descrição

Banco de dados do sistema **SystemACE**, voltado para o gerenciamento de funcionários, alunos, turmas e EPIs (Equipamentos de Proteção Individual).

## Estrutura do Banco de Dados

**Database:** `systemace_db`

### Tabelas

#### `funcionario`

Armazena os dados dos funcionários do sistema.

| Coluna          | Tipo         | Descrição                          |
| --------------- | ------------ | ---------------------------------- |
| idfuncionario   | INT (PK, AI) | Identificador único do funcionário |
| nome            | VARCHAR(70)  | Nome do funcionário                |
| sobrenome       | VARCHAR(70)  | Sobrenome do funcionário           |
| cpf             | VARCHAR(45)  | CPF do funcionário                 |
| email           | VARCHAR(70)  | E-mail do funcionário              |
| senha           | VARCHAR(300) | Senha (hash) do funcionário        |
| funcao          | VARCHAR(70)  | Função/cargo do funcionário        |
| status          | ENUM         | Status: `Ativo` ou `Inativo`       |
| data_nascimento | DATE         | Data de nascimento                 |
| telefone        | VARCHAR(15)  | Telefone de contato                |

---

#### `aluno`

Armazena os dados dos alunos.

| Coluna          | Tipo         | Descrição                    |
| --------------- | ------------ | ---------------------------- |
| idaluno         | INT (PK, AI) | Identificador único do aluno |
| nome            | VARCHAR(45)  | Nome do aluno                |
| sobrenome       | VARCHAR(100) | Sobrenome do aluno           |
| cpf             | VARCHAR(45)  | CPF do aluno                 |
| email           | VARCHAR(100) | E-mail do aluno              |
| senha           | VARCHAR(300) | Senha (hash) do aluno        |
| data_nascimento | DATE         | Data de nascimento           |
| telefone        | VARCHAR(15)  | Telefone de contato          |

---

#### `turma`

Armazena os dados das turmas.

| Coluna            | Tipo         | Descrição                    |
| ----------------- | ------------ | ---------------------------- |
| idturma           | INT (PK, AI) | Identificador único da turma |
| nome              | VARCHAR(70)  | Nome da turma                |
| nomenclatura      | VARCHAR(70)  | Nomenclatura/código da turma |
| data_inicio       | DATE         | Data de início da turma      |
| data_termino      | DATE         | Data de término da turma     |
| horario_inicio    | TIME         | Horário de início das aulas  |
| horario_termino   | TIME         | Horário de término das aulas |
| capacidade_maxima | INT          | Capacidade máxima de alunos  |

---

#### `epis`

Armazena os Equipamentos de Proteção Individual.

| Coluna            | Tipo         | Descrição                           |
| ----------------- | ------------ | ----------------------------------- |
| idepis            | INT (PK, AI) | Identificador único do EPI          |
| nome              | VARCHAR(45)  | Nome do EPI                         |
| tipo              | VARCHAR(45)  | Tipo do EPI                         |
| quantidade        | VARCHAR(45)  | Quantidade disponível               |
| disponivel        | TINYINT(1)   | Indica se está disponível (0/1)     |
| data_validade     | DATE         | Data de validade do EPI             |
| codigo_patrimonio | VARCHAR(20)  | Código de patrimônio do equipamento |

---

### Tabelas de Relacionamento

#### `funcionario_has_epis`

Relacionamento N:N entre funcionários e EPIs.

| Coluna         | Tipo | Descrição                             |
| -------------- | ---- | ------------------------------------- |
| funcionario_id | INT  | FK → `funcionario(idfuncionario)`     |
| epis_id        | INT  | FK → `epis(idepis)`                   |
| data_entrega   | DATE | Data de entrega do EPI ao funcionário |
| data_devolucao | DATE | Data de devolução do EPI              |

---

#### `aluno_has_epis`

Relacionamento N:N entre alunos e EPIs.

| Coluna   | Tipo | Descrição             |
| -------- | ---- | --------------------- |
| aluno_id | INT  | FK → `aluno(idaluno)` |
| epis_id  | INT  | FK → `epis(idepis)`   |

---

#### `aluno_has_turma`

Relacionamento N:N entre alunos e turmas.

| Coluna         | Tipo | Descrição                                        |
| -------------- | ---- | ------------------------------------------------ |
| aluno_id       | INT  | FK → `aluno(idaluno)`                            |
| turma_id       | INT  | FK → `turma(idturma)`                            |
| data_matricula | DATE | Data da matrícula do aluno na turma              |
| status         | ENUM | Status: `Matriculado`, `Trancado` ou `Concluído` |

---

## Diagrama de Relacionamentos

```
funcionario ──── N:N ──── epis
                            │
aluno ──── N:N ─────────────┘
  │
  └──── N:N ──── turma
```

## Como Executar

1. Certifique-se de ter o **MySQL** instalado e em execução.
2. Execute o script SQL:
   ```bash
   mysql -u seu_usuario -p < systemacescript.sql
   ```
3. O banco `systemace_db` será criado com todas as tabelas e relacionamentos.

## Tecnologias

- **MySQL** — Sistema de gerenciamento de banco de dados relacional
