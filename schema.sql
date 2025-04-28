-- PARA CRIAR AS TABELAS

-- CLASSES
CREATE TABLE Classe (
id SERIAL PRIMARY KEY,
nome VARCHAR NOT NULL UNIQUE,
alcance VARCHAR NOT NULL,
descricao VARCHAR
);

-- GUILDAS
CREATE TABLE Guilda (
id SERIAL PRIMARY KEY,
nome VARCHAR NOT NULL UNIQUE,
data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- AVENTUREIROS
CREATE TABLE Aventureiro (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nome VARCHAR,
  classe_id INTEGER REFERENCES Classe(id),
  nivel INTEGER,
  xp INTEGER,
  guilda_id INTEGER REFERENCES Guilda(id)
);

-- PARA FEZER O INSERT  

-- CLASSES
INSERT INTO Classe (id, nome, alcance, descricao) VALUES
(1, 'Cavaleiro', 'curto', 'Combate com espada e escudo.'),
(2, 'Mago', 'longo', 'Usa feitiços poderosos de longa distância.'),
(3, 'Arqueira', 'longo', 'Combate com arco e flechas.'),
(4, 'Curandeiro', 'suporte', 'Cura aliados durante as batalhas.'),
(5, 'Lanceiro', 'curto', 'Combate com lanças e perfurações precisas.');

-- GUILDAS
INSERT INTO Guilda (id, nome, data_criacao) VALUES
(1, 'Ordem do Dragão', '2020-01-01'),
(2, 'Os Monarcas', '2023-02-10');


-- AVENTUREIROS
INSERT INTO Aventureiro (nome, classe_id, nivel, xp, guilda_id) VALUES
('Arthur', 1, 5, 1500, 1),
('Kala', 3, 3, 800, 1),
('Merlin', 2, 7, 2500, 2),
('Header', 4, 2, 300, 1),
('Sieg', 5, 4, 1200, NULL); -- Sem guilda

-- Se quiser acrescentar mais aventureiros, use o seguinte comando:
INSERT INTO Aventureiro (nome, classe_id, nivel, xp, guilda_id) VALUES
('Nako', 3, 2, 600, 1),
('Maki', 1, 5, 1100, 2),
('Lucy', 4, 1, 200, NULL);