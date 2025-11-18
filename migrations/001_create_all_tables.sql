-- Tabela Usuário
CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

-- Tabela Permissão
CREATE TABLE permissao (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

-- Tabela associativa Usuário_Permissão
CREATE TABLE usuario_permissao (
    usuario_id INTEGER REFERENCES usuario(id),
    permissao_id INTEGER REFERENCES permissao(id),
    PRIMARY KEY (usuario_id, permissao_id)
);

-- Tabela Instrutor
CREATE TABLE instrutor (
    id SERIAL PRIMARY KEY,
    especialidade VARCHAR(100),
    cref VARCHAR(50),
    usuario_id INTEGER UNIQUE REFERENCES usuario(id)
);

-- Tabela Aluno
CREATE TABLE aluno (
    id SERIAL PRIMARY KEY,
    status VARCHAR(50),
    data_nascimento DATE,
    usuario_id INTEGER UNIQUE REFERENCES usuario(id)
);

-- Tabela Aula
CREATE TABLE aula (
    id SERIAL PRIMARY KEY,
    instrutor_id INTEGER REFERENCES instrutor(id),
    nome VARCHAR(100) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    duracao_minutos INTEGER
);

-- Tabela Exercício
CREATE TABLE exercicio (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

-- Tabela Treino
CREATE TABLE treino (
    id SERIAL PRIMARY KEY,
    instrutor_id INTEGER REFERENCES instrutor(id),
    aluno_id INTEGER REFERENCES aluno(id),
    data DATE NOT NULL,
    duracao_minutos INTEGER
);

-- Tabela associativa Treino_Exercicio
CREATE TABLE treino_exercicio (
    treino_id INTEGER REFERENCES treino(id),
    exercicio_id INTEGER REFERENCES exercicio(id),
    qtd_repeticao INTEGER,
    qtd_serie INTEGER,
    carga DECIMAL(10,2),
    PRIMARY KEY (treino_id, exercicio_id)
);

-- Tabela Tabela_Preço
CREATE TABLE tabela_preco (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_inicio DATE NOT NULL,
    data_fim DATE
);

-- Tabela Plano
CREATE TABLE plano (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    duracao_meses INTEGER
);

-- Tabela associativa Plano_Preco
CREATE TABLE plano_preco (
    id SERIAL PRIMARY KEY,
    id_plano INTEGER REFERENCES plano(id),
    id_preco INTEGER REFERENCES tabela_preco(id),
    valor_mensal DECIMAL(10,2) NOT NULL
);

-- Tabela Matrícula
CREATE TABLE matricula (
    id SERIAL PRIMARY KEY,
    status VARCHAR(50),
    data_inicio DATE NOT NULL,
    data_fim DATE,
    aluno_id INTEGER REFERENCES aluno(id),
    plano_preco_id INTEGER REFERENCES plano_preco(id)
);

-- Tabela Fatura
CREATE TABLE fatura (
    id SERIAL PRIMARY KEY,
    status_pagamento VARCHAR(50),
    data_vencimento DATE NOT NULL,
    data_fechamento DATE,
    matricula_id INTEGER REFERENCES matricula(id),
    valor_total DECIMAL(10,2) NOT NULL
);

-- Tabela associativa para relação N:N entre Aula e Aluno
CREATE TABLE aula_aluno (
    aula_id INTEGER REFERENCES aula(id),
    aluno_id INTEGER REFERENCES aluno(id),
    PRIMARY KEY (aula_id, aluno_id)
);