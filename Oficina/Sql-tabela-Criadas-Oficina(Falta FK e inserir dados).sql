show databases;
use oficina;
show tables;

-- Tabela Cadastro de Pessoas
Create Table CadastroDePessoas(
	idCadastro int auto_increment Primary Key,
	NomeCompleto Varchar(70) not null,
    endereço Varchar(255) not null,
    CPF Char(11) not null,
    Contato Varchar(50) not null,
    constraint unique_cpf_cliente unique (CPF));
    
-- tabela Mecanicos
create table mecanicos(
	idMecanicos int auto_increment primary key,
	codigo int not null unique,
	especialidade varchar(45)
);

-- tabela equipe mecanicos
create table Equipe_mecanicos(
	idEquipe_mecanicos int primary key,
	serviço_idServiço int,
	serviço_Cliente_Veiculo_idVeiculoCliente int
);

-- tabela Cliente_veiculo
create table Cliente_Veiculo(
	idVeiculoCliente int,
	ClienteCadastrado int,
	primary key (idVeiculoCliente, ClienteCadastrado),
	marca varchar(45) not null,
	modelo varchar(45) not null,
	ano date not null,
	quantidade int default 1
);

-- tabela de Serviço
create table serviço(
	idServiço int unique primary key,
    TipodeServiço enum('Revisao','Conserto') default 'Revisao',
    Cliente_Veiculo_idVeiculoCliente int
);

-- Tabela de OS
create table OS(
idOs int primary key unique not null,
Nidentificacao int,
EmData date not null,
preco decimal(4,1) not null,
IdStatus enum('Aprovado','Negado') default 'Negado',
idConclusao date not null
);

-- tabela peças e mão de obra
create table pecasEmdo(
idPecas int primary key,
quantidadePecas int not null default 1,
precoPecas decimal(4,1) not null,
precoMDO decimal(4,1) not null
);

-- tablea peças e mao de obra
create table pecasEmdo_OS(
pecasEmdo int,
OS_idOs int
);