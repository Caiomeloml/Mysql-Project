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
    constraint fk_cpf_or_cnpj foreign key (CPF_CNPJ) references valid_CPF_CNPJ(idValid_CPF_CNPJ)
    );
    
-- Criar Tabela Validação CPF/CNPJ
create table valid_CPF_CNPJ(
	idValid_CPF_CNPJ int primary key,
    idCPF char (11) unique not null,
    idCNPJ char (14) unique not null,
    constraint unique_cpf_client unique (CPF),
    constraint unique_cnpj_client unique (CNPJ)
);
    
    
    -- criar tabela produto
    -- substituir unique_cpf_client POR constraint fk_cpf_or_cnpj foreign key (CPF_CNPJ) references valid_CPF_CNPJ(idValid_CPF_CNPJ) ??
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

-- Criar Tabela Cartão de credito
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

-- Criar tabela dos Boletos
create table Boletos(
	idBoleto int,
    primary key(idBoleto),
    GerarBoleto int not null
    );

-- criar Tabela Pix 
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
create table suppliers(
	idSupplier int auto_increment primary key,
    socialName varchar(80) not null,
    CNPJ char(14) not null,
    contac char(11) not null,
    constraint unique_supplier unique (CNPJ) 
    );
    

-- Criar Tabela de Vendedor Terceiro
create table seller(
	idSeller int auto_increment primary key,
    socialName varchar (255),
    AbstractName varchar(255) not null,
    CNPJ char(14),
    CPF char(11),
    contac char(11) not null,
    location varchar(255) not null,
    constraint unique_CPF_supplier unique (CPF),
    constraint unique_CNPJ_supplier unique (CNPJ),
    constraint unique_socialName unique (socialName)
    );
    
    -- Produto_vendedor(terceiro)
    create table productSeller(
		idPSeller int,
        idProduct int,
        prodQuantity int default 1,
        primary key (idPSeller, idProduct),
        constraint fk_product_seller foreign key (idPSeller) references seller(idSeller),
         constraint fk_Product_Product foreign key (idProduct) references product(idProduct)
    );
    
    -- Criar Tabela Produto Fornecedor
    create table productSupplier(
    idProductS int,
    idPSuppliersP int,
    primary key (idPS, idPSupplier),
    constraint fk_product_suppliers foreign key (idProductS) references suppliers(idSupplier),
    constraint fk_suppliers_product foreign key (idSuppliersP) references product(idProduct)
    );
    
    -- criar Tabela Produto / Pedido
    create table productOrder(
    idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponivel','Sem estoque') default 'Disponivel',
    primary key (idPOproduct, idPOorder),
    constraint fk_product_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_product_product foreign key (idPOorder) references orders(idOrder)
    );
    
        -- Criar Tabela Produto Estoque
    create table storageLocation(
    idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_product_seller foreign key (idLproduct) references product (idProduct),
    constraint fk_product_product foreign key (idLstorage) references orders (productSeller)
    );