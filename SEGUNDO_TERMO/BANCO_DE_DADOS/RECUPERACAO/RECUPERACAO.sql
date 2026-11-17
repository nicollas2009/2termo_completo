-- SQLBook: Code
-- Active: 1794917658775@@127.0.0.1@3308@retrogame_recuperacao_nicollas
-- Active: 1794917658775@@127.0.0.1@3308@mysql
-- Crie o banco retrogame_recuperacao e selecione-o. 3 pts 
CREATE DATABASE RETROGAME_RECUPERACAO_NICOLLAS;
USE RETROGAME_RECUPERACAO_NICOLLAS;

-- 2. Tabela CLIENTE 
-- Crie os campos especificados e garanta obrigatoriedade, e-mail exclusivo e ativo por padrão. 5 pts 

CREATE TABLE PLATAFORMA (
    ID_PLATAFORMA INT PRIMARY KEY AUTO_INCREMENT,
    NOME  VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE CATEGORIA (
   ID_CATEGORIA INT PRIMARY KEY AUTO_INCREMENT,
   DESCRICAO VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE CLIENTE (
    ID_CLIENTE INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(100) NOT NULL,
    EMAIL VARCHAR(120) NOT NULL UNIQUE,
    TELEFONE VARCHAR(20) NULL, ATIVO BOOLEAN DEFAULT TRUE
);
-- JOGO (id_jogo INT PK AUTO_INCREMENT, titulo VARCHAR(150) NOT NULL, codigo VARCHAR(15) NOT NULL UNIQUE, ano_lancamento INT NOT NULL, quantidade_disponivel INT DEFAULT 0 CHECK >= 0, id_plataforma INT FK, id_categoria INT FK). 
CREATE TABLE JOGO (
    ID_JOGO INT PRIMARY KEY AUTO_INCREMENT,
    TITULO VARCHAR(150) NOT NULL,
    CODIGO VARCHAR(15) NOT NULL UNIQUE,
    ANO_LANCAMENTO INT NOT NULL,
    QUANTIDADE_DISPONIVEL INT DEFAULT 0 CHECK (QUANTIDADE_DISPONIVEL >= 0),
    ID_PLATAFORMA INT NOT NULL,
    ID_CATEGORIA INT NOT NULL,
    FOREIGN KEY (ID_PLATAFORMA) REFERENCES PLATAFORMA(ID_PLATAFORMA),
    FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA(ID_CATEGORIA)
);


-- LOCACAO (id_locacao INT PK AUTO_INCREMENT, data_retirada DATETIME DEFAULT CURRENT_TIMESTAMP, data_prevista DATE NOT NULL, data_devolucao DATE NULL, status_locacao VARCHAR(20) DEFAULT 'ABERTA' com CHECK para os três estados, id_cliente INT FK, id_jogo INT FK). 
CREATE TABLE LOCACAO (
    ID_LOCACAO INT PRIMARY KEY AUTO_INCREMENT,
    DATA_RETIRADA DATETIME DEFAULT CURRENT_TIMESTAMP,
    DATA_PREVISTA DATE NOT NULL,
    DATA_DEVOLUCAO DATE NULL,
    STATUS_LOCACAO VARCHAR(20) DEFAULT 'ABERTO' CHECK (STATUS_LOCACAO IN ('ABERTO', 'DEVOLVIDO', 'ATRASADO')),
    ID_CLIENTE INT NOT NULL,
    ID_JOGO INT NOT NULL,
    FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE),
    FOREIGN KEY (ID_JOGO) REFERENCES JOGO(ID_JOGO)
);
-- 6. ALTER TABLE 
-- Acrescente desenvolvedora VARCHAR(100) à tabela JOGO usando ALTER TABLE. 
ALTER TABLE JOGO ADD DESENVOLVEDORA VARCHAR(100);

-- 7. Inserir clientes 
-- Insira pelo menos 4 clientes. Um deles deve ter telefone NULL. 
INSERT INTO CLIENTE (NOME, EMAIL, TELEFONE) VALUES 
('João Silva', 'joao.silva@example.com', '11999999999'),
('Maria Oliveira', 'maria.oliveira@example.com', '11888888888'),
('Pedro Santos', 'pedro.santos@example.com', NULL),
('Ana Costa', 'ana.costa@example.com', '11777777777');

-- 8. Inserir plataformas, categorias e jogos 
-- Insira ao menos 2 plataformas, 2 categorias e 6 jogos, com códigos, anos e estoques diferentes, respeitando as FKs. 
INSERT INTO CATEGORIA (DESCRICAO) VALUES 
('Ação'),
('Aventura');
INSERT INTO PLATAFORMA (NOME) VALUES
('playstation 5'),
('xbox one');
INSERT INTO  JOGO (ID_PLATAFORMA, TITULO, CODIGO, ANO_LANCAMENTO, QUANTIDADE_DISPONIVEL) VALUES
('1', 'GOOD GAME', 'GG001', 2020, 5),
('2', 'BAD GAME', 'BG002', 2019, 3),
('3', 'AWESOME GAME', 'AG003', 2021, 10),
('4',' COOL GAME', 'CG004', 2018, 2),
('5', 'FUN GAME', 'FG005', 2022, 7),
('6', 'BORING GAME', 'BG006', 2017, 1);


-- 9. Inserir locações 
-- Insira ao menos 3 locações ABERTAS de clientes e jogos existentes; planeje a redução de estoque correspondente. 
INSERT INTO LOCACAO (DATA_PREVISTA, ID_CLIENTE, ID_JOGO) VALUES
('2024-07-01', 1, 1),
('2024-07-02', 2, 2),
('2024-07-03', 3, 3);

-- 10. SELECT + UPDATE 
-- Localize um cliente com SELECT e modifique seu telefone com UPDATE e WHERE. 
SELECT * FROM CLIENTE WHERE NOME = 'Pedro Santos';
UPDATE CLIENTE SET TELEFONE = '11999999998' WHERE id_usuario = 3;


-- 11. UPDATE em lote 
-- Acrescente 2 unidades ao estoque de cada jogo lançado a partir do ano 2000. Use condição adequada. 
UPDATE JOGO SET QUANTIDADE_DISPONIVEL = QUANTIDADE_DISPONIVEL + 2 WHERE ANO_LANCAMENTO >= 2000;

-- 12. DELETE e proteção do histórico 
-- 4 pts 
-- Crie e exclua um cliente sem locações. Tente excluir um cliente com locação e registre o resultado e a justificativa técnica. 























