-- Criação de banco de dados para o cenário de E-comerce
show databases;
create database e_comerce;
use e_comerce;

    
-- Criar Tabela Validação CPF/CNPJ
create table valid_CPF_CNPJ(
	idValid_CPF_CNPJ int not null primary key,
    idCPF char (11) not null,
    idCNPJ char (14) not null,
    constraint unique_cpf_client unique (idCPF),
    constraint unique_cnpj_client unique (idCNPJ)
);

-- Criar Tabela Cliente
create table clients(
	IdClient int auto_increment primary key unique,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF_OR_CNPJ int not null unique,
    Address varchar(30),
   CONSTRAINT fk_valid_CPF_CNPJ FOREIGN KEY(CPF_OR_CNPJ) REFERENCES valid_CPF_CNPJ(idValid_CPF_CNPJ)
    );
    
    -- criar tabela produto
    create table product(
		idProduct int auto_increment primary key,
        categoria varchar(45),
        descrição varchar(45),
        valor varchar(45),
        CONSTRAINT fk_client_product FOREIGN KEY(idProduct) REFERENCES clients(idClient)
	);

-- IMPLEMENTANDO TABELAS DE FORMA DE PAGAMENTO

-- Criar Tabela Cartão de credito
create table Credcard(
	idCredcard int primary key,
	credcardNumber varchar(16) not null,
	validityCredcard date not null,
	NameCredcard varchar(20) not null,
	Owner_CPF char(11) not null,
	safeCode varchar(5) not null,
    constraint unique_owner_Cpf unique (owner_CPF),
    constraint unique_credcardNumber unique (credcardNumber)
);

-- Criar tabela dos Boletos
create table Boletos(
	idBoleto int,
    primary key(idBoleto),
    GerarBoleto int not null unique auto_increment
    );

-- criar Tabela Pix 
create table Pix (
	idPix int,
    primary key (idPix),
    ChavePix int not null unique auto_increment
    );

-- Tabela principal Payment
create table payment(
idClient int,
idPayment int,
typePayment enum('Boleto', 'Pix', 'Cartão'),
limitAvailable float,
primary key (idClient, idPayment),
constraint unique_Payment unique (idPayment),
constraint fk_Payment_Credcard foreign key (idPayment) references Credcard(idCredcard),
constraint fk_payment_Boletos foreign key (idPayment) references Boletos(idBoleto),
constraint fk_payment_Pix foreign key (idPayment) references Pix(idPix)
);
    
-- criar Tabela Pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderCLient int,
    idOrderPayment int,
    orderStatus enum('Em Andamento', 'Processando', 'Enviado', 'Entregue') default 'Processando',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_payment_order foreign key (idOrderPayment) references payment(idPayment),
    constraint fk_orders_client foreign key (idOrderClient) references clients(IdClient)
	on update cascade
);

    -- criar Tabela Produto / Pedido
    create table productOrder(
    idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponivel','Sem estoque') default 'Disponivel',
    primary key (idPOproduct, idPOorder),
    constraint fk_prodsel_prodOrders foreign key (idPOproduct) references product(idProduct),
    constraint fk_prodProd_prodOrders foreign key (idPOorder) references orders(idOrder)
    );
 
-- Criar Tabela  de Estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 1
    );
    
            -- Criar Tabela Produto Estoque
    create table storageLocation(
    idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key ( idLproduct, idLstorage),
    constraint fk_product_seller foreign key (idLproduct) references product(idProduct),
    constraint fk_product_prod_PDseller foreign key (idLstorage) references orders(idOrder)
    );

-- Criar Tabela de Fornecedor
create table suppliers(
	idSupplier int auto_increment primary key,
    socialName varchar(80) not null,
    idCNPJ int not null,
    contac char(11) not null,
    constraint unique_supplier unique (idSupplier),
    CONSTRAINT fk_Supplier_CPF_CNPJ FOREIGN KEY(idCNPJ) REFERENCES valid_CPF_CNPJ(idValid_CPF_CNPJ)
    );
    
    
    -- Criar Tabela Produto Fornecedor
    create table productSupplier(
    idProductS int,
    idPSuPro int,
    quantity int not null,
    primary key (idPSuPro, idProductS),
    constraint fk_product_suppliers foreign key (idProductS) references suppliers(idSupplier),
    constraint fk_suppliers_product foreign key (idPSuPro) references product(idProduct)
    );
    

-- Criar Tabela de Vendedor Terceiro
create table seller(
	idSeller int auto_increment primary key,
    socialName varchar (255),
    AbstractName varchar(255) not null,
	idCPF_CNPJSeller int unique not null,
    contac char(11) not null,
    location varchar(255) not null,
    constraint unique_socialName unique (socialName),
    CONSTRAINT fk_Seller_CPF_CNPJ FOREIGN KEY(idCPF_CNPJSeller) REFERENCES valid_CPF_CNPJ(idValid_CPF_CNPJ)
    );
    
    -- Produto_vendedor(terceiro)
    create table productSeller(
		idPSeller int not null,
        idProduct int not null,
        prodQuantity int default 1,
        primary key (idPSeller, idProduct),
        constraint fk_product_seller_terceiro foreign key (idPSeller) references seller(idSeller),
         constraint fk_Product_Product_Seller foreign key (idProduct) references product(idProduct)
    );
    
    
    
    
    
    
    
    
    
    
    
    
    
    