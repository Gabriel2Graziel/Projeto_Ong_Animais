CREATE DATABASE ong_database;
USE ong_database;
CREATE TABLE Animal(
    id_animal INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(15) NOT NULL,
    idade INT CHECK(idade>2 AND idade<=240),
    sexo CHAR(1) NOT NULL CHECK(sexo="F" OR sexo="M"),
    peso FLOAT NOT NULL,
    especie VARCHAR(8) NOT NULL CHECK(especie="cachorro" OR especie="gato"),
    descricao VARCHAR(100) NULL,
    deficiencia VARCHAR(15) NULL DEFAULT 'Nenhuma',
    doenca VARCHAR(15) NULL DEFAULT 'Nenhuma',
    data_registro DATE DEFAULT (CURDATE()),
    status_registro SMALLINT DEFAULT 1
);

CREATE TABLE Usuario (
	CPF CHAR(11) PRIMARY KEY,
	nome VARCHAR(15) NOT NULL,
	sobrenome VARCHAR (40) NOT NULL,
	email VARCHAR(50) NOT NULL UNIQUE,
	senha VARCHAR(20) NOT NULL,
	sexo CHAR (1) NOT NULL CHECK(sexo="F" OR sexo="M" OR sexo="I"),
	data_nascimento DATE NOT NULL,
	telefone CHAR(11) NOT NULL,
	data_registro DATE DEFAULT (CURDATE()),
    status_registro SMALLINT DEFAULT 1
);

CREATE TABLE tipo_usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(15) NOT NULL UNIQUE CHECK(descricao='Administrador' OR descricao='Usuario' OR
	descricao='Voluntário' OR descricao='Doador' OR descricao='Adotante' OR descricao='Contribuinte')
);

CREATE TABLE usuario_tipo(
	id_TipoUsuario INT,
	CPF_usuario CHAR(11) NOT NULL UNIQUE,
	FOREIGN KEY(id_TipoUsuario) REFERENCES tipo_usuario (id),
	FOREIGN KEY (CPF_Usuario) REFERENCES Usuario (CPF)
);

CREATE TABLE Adocao (
	id INT PRIMARY KEY AUTO_INCREMENT,
	status_adocao CHAR(1) NULL CHECK(status_adocao='P' OR status_adocao='A' OR status_adocao='R') DEFAULT 'P',
	observação VARCHAR (100) NULL,
	data_solicitacao DATE DEFAULT (CURDATE()),
	data_adocao DATE NULL,
	id_animal INT,
	CPF_Usuario CHAR(11) NOT NULL UNIQUE,
	FOREIGN KEY (id_animal) REFERENCES Animal (id),
	FOREIGN KEY (CPF_Usuario)REFERENCES Usuario (CPF)
);

CREATE TABLE  Doacao_Item (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome_item VARCHAR (20),
	foto VARCHAR(225) NOT NULL,
	status_doacao CHAR(1) NULL CHECK(status_adocao='P' OR status_adocao='A' OR status_adocao='R')  DEFAULT 'P', 
	observacao VARCHAR(100) NULL,
	data_solicitacao DATE DEFAULT (CURDATE()),
	data_doacao DATE NULL,
	CPF_usuario CHAR(11) NOT NULL UNIQUE,
	FOREIGN KEY (CPF_usuario) REFERENCES Usuario (CPF)
);

CREATE TABLE Metodo_pagamento (
	id INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(25) NOT NULL UNIQUE CHECK(descricao='PIX' OR
    descricao='Cartão de Crédito' OR descricao='Cartão de Débito' OR descricao='Boleto bancário')
);

CREATE TABLE Contribuicao_financeira(
	id INT PRIMARY KEY AUTO_INCREMENT,
	valor FLOAT NOT NULL CHECK(valor>0),
	observacao VARCHAR(100) NULL,
	data_contribuicao DATE DEFAULT (CURDATE()),
	CPF_usuario CHAR(11) NOT NULL UNIQUE,
	id_metodoPagamento INT NOT NULL,
	FOREIGN KEY (CPF_usuario) REFERENCES Usuario(CPF),
	FOREIGN KEY (id_metodoPagamento) REFERENCES Metodo_pagamento (id)
);

CREATE TABLE Contribuicao_recorrente(
	id INT PRIMARY KEY AUTO_INCREMENT,
	valor_fixo FLOAT NOT NULL CHECK(valor_fixo>0),
	data_cobranca DATE DEFAULT (CURDATE()),
	frequencia VARCHAR(20) NOT NULL,
	CPF_usuario CHAR(11) NOT NULL UNIQUE,
	id_metodoPagamento INT NOT NULL,
	FOREIGN KEY (CPF_usuario) REFERENCES Usuario(CPF),
	FOREIGN KEY (id_metodoPagamento) REFERENCES Metodo_pagamento
);