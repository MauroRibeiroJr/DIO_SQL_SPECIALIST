-- CRIAÇÃO DO BANCO DE DADOS E-COMMERCE


CREATE DATABASE Ecommerce;
USE Ecommerce;

-- CRIAÇÃO DAS TABELAS --

-- CRIAR TABELA CLIENTE
create table Cliente(
	idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(45),
    CPF CHAR(11),
    DataNascimento DATE,
    Endereço VARCHAR(255),
    StatusCliente ENUM('Ativo', 'Inativo'),
    CONSTRAINT unique_cpf_client unique(CPF)
);
-- CRIAR TABELA PRODUTO
create table Produto(
	idProduto INT AUTO_INCREMENT PRIMARY KEY,
    Categoria ENUM('Eletrônico','Roupas','Alimento') NOT NULL,
    NomeProduto VARCHAR(45) NOT NULL,
    Descrição VARCHAR(45),
    Valor FLOAT    
);

alter table Cliente auto_increment=1;

-- CRIAR TABELA PEDIDO
create table Pedidos(
	idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idPedidoCliente INT,
    StatusPedido ENUM('Confirmado','Cancelado','Processando') DEFAULT 'Processando',
    Descrição VARCHAR(255),
    Frete FLOAT DEFAULT 10,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (idPedidoCliente) REFERENCES Cliente(idCliente)
);

alter table Pedidos auto_increment=1;

-- CRIAR TABELA PAGAMENTO
create table Pagamento(
	idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT,
    TipoPagamento ENUM('Boleto','Cartão','PIX'),
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido)
);

alter table Pagamento auto_increment=1;

-- CRIAR TABELA ESTOQUE
create table Estoque(
	idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    LocalEstoque VARCHAR(255) NOT NULL
);

alter table Estoque auto_increment=1;

-- CRIAR TABELA FORNECEDOR
create table Fornecedor(
	idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    RazãoSocial VARCHAR(45) NOT NULL,
    NomeFantasia VARCHAR(45),
    CNPJ CHAR(15) NOT NULL,
    Endereço VARCHAR(45),
    Telefone CHAR(11) NOT NULL,
    DataInicio DATE NOT NULL,
    StatusFornecedor ENUM('Ativo','Inativo') DEFAULT 'Ativo',
    CONSTRAINT unique_CNPJ_Fornecedor unique(CNPJ)    
);

alter table Fornecedor auto_increment=1;

-- CRIAR TABELA VENDEDOR
create table Vendedor(
	idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    RazãoSocial VARCHAR(45) NOT NULL,
    NomeFantasia VARCHAR(45),
    CNPJ CHAR(15),
    CPF CHAR(9),
    Telefone CHAR(11) NOT NULL,
    CONSTRAINT unique_CNPJ_Vendedor unique(CNPJ),
    CONSTRAINT unique_CPF_Vendedor unique(CPF)
);

alter table Vendedor auto_increment=1;

-- CRIANDO TABELAS DE RELACIONAMENTO --

-- CRIAR TABLEA PRODUTO_VENDEDOR
create table ProdutoVendedor(
	idProdutoVendedor INT,
    idProduto INT,
    QuantidadeProduto INT NOT NULL,
    CONSTRAINT fk_ProdutoVendedor FOREIGN KEY (idProdutoVendedor) REFERENCES Vendedor(idVendedor),
	CONSTRAINT fk_ProdutoProduto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- CRIAR TABELA PRODUTO_PEDIDO
create table ProdutoPedido(
	idProdutoPedido INT,
    idPedidoPedido INT,
    Quantidade INT NOT NULL,
    StatusProdPedido ENUM('Disponível','Sem Estoque') DEFAULT 'Disponível',
    CONSTRAINT fk_ProdutoVendido FOREIGN KEY (idProdutoPedido) REFERENCES Produto(idProduto),
    CONSTRAINT fk_ProdutoPedido FOREIGN KEY (idPedidoPedido) REFERENCES Pedidos(idPedido)
);

-- CRIAR TABELA LOCAL DE ESTOQUE
create table LocalEstoque(
	idLocalEstoque INT,
    idLocalProduto INT,
    Local VARCHAR (255) NOT NULL,
    CONSTRAINT fk_Produto_Vendido FOREIGN KEY (idLocalEstoque) REFERENCES Produto(idProduto),
    CONSTRAINT fk_Produto_Produto FOREIGN KEY (idLocalProduto) REFERENCES Estoque(idEstoque)
);
