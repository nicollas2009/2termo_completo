-- Active: 1788867938340@@127.0.0.1@3306@biblioteca_nicollas

-- FASSE 1-DDL: CRIAÇÃO E ESTRUTURA
-- 1. Criação do banco — 3 pts
CREATE DATABASE BIBLIOTECA_NICOLLAS;

USE BIBLIOTECA_NICOLLAS;


-- 2. Tabela USUARIO — 6 pts
CREATE TABLE USUARIO (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(100) NOT NULL,
    EMAIL VARCHAR(120) NOT NULL UNIQUE,
    TELEFONE VARCHAR(20),
    ATIVO BOOLEAN DEFAULT TRUE
);

-- 3. Tabela LIVRO — 6 pts 
CREATE TABLE LIVRO (
    id_livro INT PRIMARY KEY AUTO_INCREMENT,
    TITULO VARCHAR(150) NOT NULL,
    AUTOR VARCHAR(120) NOT NULL,
    ISBN CHAR(13) NOT NULL UNIQUE,
    ANO_PUBLICADO INT,
    QUANTIDADE_DISPONIVEL INT DEFAULT 0, CHECK (QUANTIDADE_DISPONIVEL >= 0)
);

-- 4. Tabela EMPRESTIMO — 7 pts 
CREATE TABLE EMPRESTIMO (
    id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
    data_emprestimo DATETIME DEFAULT CURRENT_TIMESTAMP,
    DATA_PREVISTA DATE NOT NULL,
    DATA_DEVOLUCAO DATE,
    STATUS_EMPRESTIMO VARCHAR(20) DEFAULT'ABERTO', CHECK (STATUS_EMPRESTIMO IN ('ABERTO', 'DEVOLVIDO', 'ATRASADO')),
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES LIVRO(id_livro)   
);

-- 5. alter table - 3 pts
ALTER TABLE LIVRO ADD EDITORA VARCHAR(100);

-- Tabela CATEGORIA  E FUNCIONARIO 
CREATE TABLE CATEGORIA (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE FUNCIONARIO (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(100) NOT NULL UNIQUE,
    PROFISSÃO VARCHAR(100) NOT NULL
);

-- FASE 2 - DML: MANIPULAÇÃO DE DADOS

-- 6. INSERT de usuários — 4 pts
INSERT INTO USUARIO (NOME, EMAIL, TELEFONE, `ATIVO`) VALUES
('João Silva', 'joJO.silva@email.com', '11999999999', TRUE),
('Maria Oliveira', 'maMa.oliveira@email.com', '11988888888', TRUE),
('Carlos Santos', 'carlos.santos@email.com', '11977777777', TRUE),
('Ana Costa', 'ana.costa@email.com', NULL, TRUE);

--  7. INSERT de livros — 5 pts 
INSERT INTO LIVRO (TITULO, AUTOR, ISBN, ANO_PUBLICADO, QUANTIDADE_DISPONIVEL, EDITORA) VALUES
('Dom Casmurro', 'Machado de Assis', '9788535702964', 1899, 5, 'Companhia das Letras'),
('1984', 'George Orwell', '9780451524935', 1948, 3, 'Secker & Warburg'),
('O Senhor dos Anéis', 'J.R.R. Tolkin', '9780544003415', 1954, 2, 'Houghton Mifflin Harcourt'),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', '9780156012195', 1943, 4, 'Reynal & Hitchcock'),
('A Revolução dos Bichos', 'George Orwell', '9780451526342', 1945, 6, 'Secker & Warburg'),
('Cem Anos de Solidão', 'Gabriel García Márquez', '9780060883287', 1967, 3, 'Harper & Row');

-- 8. INSERT de empréstimos — 4 pts 
INSERT INTO emprestimo (DATA_PREVISTA, id_usuario, id_livro, STATUS_EMPRESTIMO) VALUES
('2024-07-15', 1, 1, 'ABERTO'),
('2024-07-20', 2, 2, 'ABERTO'),
('2024-07-25', 3, 3, 'ABERTO');

-- 9. UPDATE — 4 pts 
-- Localize um usuário com SELECT e depois altere seu telefone com UPDATE. 

SELECT * FROM USUARIO WHERE id_usuario = 1;

UPDATE USUARIO SET TELEFONE = '11999999998' WHERE id_usuario = 1;


-- ????? 10. Atualização em lote — 4 pts 
-- Acrescente 2 exemplares a todos os livros publicados a partir de 1945. 


UPDATE LIVRO SET QUANTIDADE_DISPONIVEL = QUANTIDADE_DISPONIVEL + 2 WHERE ANO_PUBLICADO >= 1945;


-- 11. DELETE e integridade — 4 pts 
-- Crie e exclua um usuário sem empréstimos. Depois tente excluir um usuário que possua empréstimo e explique o resultado.

DELETE FROM USUARIO WHERE id_usuario = 4;
DELETE FROM USUARIO WHERE id_usuario = 2;

--  O usuário 4 não possuía empréstimos antão foi excluido já o usuário 2 tem e por isso  não conseguimos  excluir ele


-- 12. SELECT básico — 2 pts 
-- Liste título, autor e quantidade disponível de todos os livros

select TITULO, AUTOR, QUANTIDADE_DISPONIVEL FROM LIVRO;


-- 13. WHERE + ORDER BY - 3 PTS
-- Liste livros com quantidade maior que 2, do maior para o menor estoque.
SELECT * FROM LIVRO WHERE QUANTIDADE_DISPONIVEL > 2 ORDER BY QUANTIDADE_DISPONIVEL DESC;


-- 14. LIKE — 3 pts 
-- Pesquise livros cujo título contenha uma palavra escolhida por você. 

SELECT * FROM LIVRO WHERE TITULO LIKE '%Dom%';

-- 15. BETWEEN — 3 pts 
-- Liste livros publicados entre 1945 e 1966. 
SELECT * FROM LIVRO WHERE ANO_PUBLICADO BETWEEN 1945 AND 1966;


-- 16. Funções agregadas — 4 pts 
-- Mostre COUNT, SUM, AVG, MIN e MAX sobre a quantidade disponível. 
SELECT COUNT(QUANTIDADE_DISPONIVEL) AS Total_Livros,
       SUM(QUANTIDADE_DISPONIVEL) AS Soma_Quantidade,
       AVG(QUANTIDADE_DISPONIVEL) AS Media_Quantidade,
       MIN(QUANTIDADE_DISPONIVEL) AS Min_Quantidade,
       MAX(QUANTIDADE_DISPONIVEL) AS Max_Quantidade


-- 17. INNER JOIN — 4 pts 
-- Liste ID do empréstimo, usuário, livro, data e status. 
SELECT e.id_emprestimo, u.NOME AS Usuario, l.TITULO AS Livro, e.data_emprestimo, e.STATUS_EMPRESTIMO
FROM EMPRESTIMO e
JOIN USUARIO u ON e.id_usuario = u.id_usuario
JOIN LIVRO l ON e.id_livro = l.id_livro

-- 18. JOIN + WHERE — 3 pts 
-- Mostre apenas os empréstimos ABERTOS. 
SELECT e.id_emprestimo, u.NOME AS Usuario, l.TITULO AS Livro, e.data_emprestimo, e.STATUS_EMPRESTIMO
FROM EMPRESTIMO e
JOIN USUARIO u ON e.id_usuario = u.id_usuario
JOIN LIVRO l ON e.id_livro = l.id_livro
WHERE e.STATUS_EMPRESTIMO = 'ABERTO'
;

-- 19. GROUP BY — 4 pts 
-- Mostre cada usuário e sua quantidade de empréstimos, do maior para o menor. 
SELECT u.NOME AS Usuario, COUNT(e.id_emprestimo) AS Quantidade_Emprestimos
FROM EMPRESTIMO e   
JOIN USUARIO u ON e.id_usuario = u.id_usuario
GROUP BY u.NOME
ORDER BY Quantidade_Emprestimos DESC;




-- 20. LEFT JOIN — 4 pts 
-- Liste todos os usuários, inclusive os que nunca fizeram empréstimo, com a quantidade de empréstimos de cada um.
SELECT u.NOME AS Usuario, COUNT(e.id_emprestimo) AS Quantidade_Emprestimos
FROM USUARIO u   
LEFT JOIN EMPRESTIMO e ON u.id_usuario = e.id_usuario
GROUP BY u.NOME
;





