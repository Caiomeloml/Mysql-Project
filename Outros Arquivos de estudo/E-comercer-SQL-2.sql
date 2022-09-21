-- Criação de banco de dados para o cenário de E-comerce
create database e_comerce;
show databases;
use e_comerce;
show tables;

-- Criar Tabela Cliente
create table clients(
	IdClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique (CPF)
    );
    
    
    -- criar tabela produto
    create table product(
		idProduct int auto_increment primary key,
        categoria varchar(45),
        descrição varchar(45),
        valor varchar(45),
        constraint unique_cpf_client unique (CPF)
	);

-- IMPLEMENTANDO TABELAS DE FORMA DE PAGAMENTO
-- Tabela principal Payment
create table payment(
idClient int,
idPayment int unique,
typePayment enum('Boleto', 'Pix', 'Cartão'),
limitAvailable float,
primary key (idClient, id_payment),
constraint unique_Payment unique (idPayment),
constraint fk_Payment_Credcard foreign key (PaymentCredcard) references Credcard(idCredcard),
constraint fk_payment_Boletos foreign key (PaymentBoletos) references Boletos(idBoleto),
constraint fk_payment_Pix foreign key (PaymentPix) references Pix(idPix)
);


create table Credcard(
	idCredcard int primary key,
	credcardNumber varchar(16) unique not null,
	validityCredcard date not null,
	NameCredcard varchar(20) not null,
	Owner_CPF char(11) not null unique,
	safeCode varchar(5) not null,
    constraint unique_owner_Cpf unique (owner_CPF),
    constraint unique_credcardNumber unique (credcardNumber)
);

create table Boletos(
	idBoleto int,
    primary key(idBoleto),
    GerarBoleto int not null
    );


create table Pix (
	idPix int,
    primary key (idPix),
    ChavePix int not null
    );

    
-- criar Tabela Pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderCLient int,
    orderStatus enum('Em Andamento', 'Processando', 'Enviado', 'Entregue') default 'Processando',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_payment foreign key (idPaymentClient) references payment (idPayment),
    constraint fk_ordes_client foreign key (idOrderClient) references clients(IdClient)
);


-- Criar Tabela  de Estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
    );

-- Criar Tabela de Fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    socialName varchar(80) not null,
    CNPJ char(14) not null,
    contac char(11) not null,
    constraint unique_supplier unique (CNPJ) 
    );