# SystemACE - Banco de Dados

## Descrição

Banco de dados do sistema **SystemACE**, voltado para o gerenciamento de funcionários, alunos, turmas e EPIs (Equipamentos de Proteção Individual).

## Estrutura do Banco de Dados

**Database:** `systemace_db`

### Tabelas

#### `funcionario`

Armazena os dados dos funcionários do sistema.

| Coluna          | Tipo         | Restrições        | Descrição                          |
| --------------- | ------------ | ----------------- | ---------------------------------- |
| idfuncionario   | INT (PK, AI) | NOT NULL          | Identificador único do funcionário |
| nome            | VARCHAR(70)  | NOT NULL          | Nome do funcionário                |
| sobrenome       | VARCHAR(70)  |                   | Sobrenome do funcionário           |
| cpf             | VARCHAR(14)  | UNIQUE, NOT NULL  | CPF do funcionário                 |
| email           | VARCHAR(70)  | UNIQUE, NOT NULL  | E-mail do funcionário              |
| senha           | VARCHAR(300) | NOT NULL          | Senha (hash) do funcionário        |
| funcao          | VARCHAR(70)  |                   | Função/cargo do funcionário        |
| status          | ENUM         | DEFAULT `'Ativo'` | Status: `Ativo` ou `Inativo`       |
| data_nascimento | DATE         |                   | Data de nascimento                 |
| telefone        | VARCHAR(15)  |                   | Telefone de contato                |

---

#### `aluno`

Armazena os dados dos alunos.

| Coluna          | Tipo         | Restrições       | Descrição                    |
| --------------- | ------------ | ---------------- | ---------------------------- |
| idaluno         | INT (PK, AI) | NOT NULL         | Identificador único do aluno |
| nome            | VARCHAR(45)  | NOT NULL         | Nome do aluno                |
| sobrenome       | VARCHAR(100) |                  | Sobrenome do aluno           |
| cpf             | VARCHAR(14)  | UNIQUE, NOT NULL | CPF do aluno                 |
| email           | VARCHAR(100) | UNIQUE, NOT NULL | E-mail do aluno              |
| senha           | VARCHAR(300) | NOT NULL         | Senha (hash) do aluno        |
| data_nascimento | DATE         |                  | Data de nascimento           |
| telefone        | VARCHAR(15)  |                  | Telefone de contato          |

---

#### `turma`

Armazena os dados das turmas.

| Coluna            | Tipo         | Restrições | Descrição                    |
| ----------------- | ------------ | ---------- | ---------------------------- |
| idturma           | INT (PK, AI) | NOT NULL   | Identificador único da turma |
| nome              | VARCHAR(70)  | NOT NULL   | Nome da turma                |
| nomenclatura      | VARCHAR(70)  |            | Nomenclatura/código da turma |
| data_inicio       | DATE         |            | Data de início da turma      |
| data_termino      | DATE         |            | Data de término da turma     |
| horario_inicio    | TIME         |            | Horário de início das aulas  |
| horario_termino   | TIME         |            | Horário de término das aulas |
| capacidade_maxima | INT          |            | Capacidade máxima de alunos  |

---

#### `epis`

Armazena os Equipamentos de Proteção Individual.

| Coluna            | Tipo         | Restrições  | Descrição                           |
| ----------------- | ------------ | ----------- | ----------------------------------- |
| idepis            | INT (PK, AI) | NOT NULL    | Identificador único do EPI          |
| nome              | VARCHAR(45)  | NOT NULL    | Nome do EPI                         |
| tipo              | VARCHAR(45)  |             | Tipo do EPI                         |
| quantidade        | INT          | DEFAULT `0` | Quantidade disponível               |
| disponivel        | BOOLEAN      | DEFAULT `1` | Indica se está disponível (0/1)     |
| data_validade     | DATE         |             | Data de validade do EPI             |
| codigo_patrimonio | VARCHAR(20)  | UNIQUE      | Código de patrimônio do equipamento |

---

### Tabelas de Relacionamento

#### `funcionario_has_epis`

Relacionamento entre funcionários e EPIs (entregas de EPI). Chave primária própria com auto incremento, permitindo múltiplas entregas do mesmo EPI ao mesmo funcionário. FKs com `ON DELETE CASCADE`.

| Coluna          | Tipo         | Restrições             | Descrição                             |
| --------------- | ------------ | ---------------------- | ------------------------------------- |
| id_entrega_func | INT (PK, AI) | NOT NULL               | Identificador único da entrega        |
| funcionario_id  | INT          | FK, NOT NULL           | FK → `funcionario(idfuncionario)`     |
| epis_id         | INT          | FK, NOT NULL           | FK → `epis(idepis)`                   |
| data_entrega    | DATE         | DEFAULT `CURRENT_DATE` | Data de entrega do EPI ao funcionário |
| data_devolucao  | DATE         |                        | Data de devolução do EPI              |

---

#### `aluno_has_epis`

Relacionamento entre alunos e EPIs (entregas de EPI). Chave primária própria com auto incremento, permitindo múltiplas entregas do mesmo EPI ao mesmo aluno. FKs com `ON DELETE CASCADE`.

| Coluna           | Tipo         | Restrições             | Descrição                       |
| ---------------- | ------------ | ---------------------- | ------------------------------- |
| id_entrega_aluno | INT (PK, AI) | NOT NULL               | Identificador único da entrega  |
| aluno_id         | INT          | FK, NOT NULL           | FK → `aluno(idaluno)`           |
| epis_id          | INT          | FK, NOT NULL           | FK → `epis(idepis)`             |
| data_entrega     | DATE         | DEFAULT `CURRENT_DATE` | Data de entrega do EPI ao aluno |

---

#### `aluno_has_turma`

Relacionamento N:N entre alunos e turmas. FKs com `ON DELETE CASCADE`.

| Coluna         | Tipo | Restrições              | Descrição                                        |
| -------------- | ---- | ----------------------- | ------------------------------------------------ |
| aluno_id       | INT  | PK, FK, NOT NULL        | FK → `aluno(idaluno)`                            |
| turma_id       | INT  | PK, FK, NOT NULL        | FK → `turma(idturma)`                            |
| data_matricula | DATE | DEFAULT `CURRENT_DATE`  | Data da matrícula do aluno na turma              |
| status         | ENUM | DEFAULT `'Matriculado'` | Status: `Matriculado`, `Trancado` ou `Concluído` |

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
