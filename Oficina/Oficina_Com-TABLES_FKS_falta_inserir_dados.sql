show databases;
create database Oficina;
use oficina;
show tables;

-- Tabela Cadastro de Pessoas
Create Table CadastroDePessoas(
	idCadastro int auto_increment Primary Key,
	NomeCompleto Varchar(70) not null,
    endereço Varchar(255) not null,
    CPF Char(11) not null,
    Contato Varchar(50) not null,
    constraint unique_cpf_cliente unique (CPF)
    );
    
-- tabela Mecanicos
create table mecanicos(
	idMecanicos int auto_increment primary key,
    dados_mecanicos int,
	codigo int not null unique,
	especialidade varchar(45),
    constraint fk_dados_mecanicos foreign key (dados_mecanicos) references CadastroDePessoas(idCadastro),
    constraint fk_Id_Equipe_mecanicos foreign key (codigo) references Equipe_Mecanicos(idEquipe_mecanicos),
    constraint fk_Equipe_mecanicos foreign key (idMecanicos) references Equipe_Mecanicos(idEquipe_mecanicos)
);
desc mecanicos;

-- tabela equipe mecanicos
create table Equipe_mecanicos(
	idEquipe_mecanicos int primary key,
	serviço_idServiço int,
	serviço_Cliente_Veiculo_idVeiculoCliente int    
);
alter table Equipe_mecanicos
add constraint fk_id_serviço foreign key (serviço_idServiço) references serviço(idServiço),
add constraint fk_Id_cliente_veiculo foreign key (serviço_Cliente_Veiculo_idVeiculoCliente) references Os(idOs);


-- tabela Cliente_veiculo
create table Cliente_Veiculo(
	idVeiculoCliente int,
	ClienteCadastrado int,
	primary key (idVeiculoCliente),
	marca varchar(45) not null,
	modelo varchar(45) not null,
	ano date not null,
	quantidade int default 1,
    constraint fk_Cliente_Cadastrado foreign key (ClienteCadastrado) references CadastroDePessoas(idCadastro)
);

desc Cliente_Veiculo;

-- tabela de Serviço
create table serviço(
	idServiço int unique primary key,
    TipodeServiço enum('Revisao','Conserto') default 'Revisao',
    Cliente_Veiculo_idVeiculoCliente int
);
alter table serviço
Add constraint fk_ClientVeiculo foreign key (Cliente_Veiculo_idVeiculoCliente) references Cliente_Veiculo(idVeiculoCliente);
desc serviço;

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
idPecas int,
idMdo int,
primary key (idPecas, idMdo),
quantidadePecas int not null default 1,
precoPecas decimal(4,1) not null,
precoMDO decimal(4,1) not null
);

-- tabela peças e mao de obra
create table pecasEmdo_OS(
pecasEmdo int,
OS_idOs int,
constraint fk_pecasEmdo foreign key (pecasEmdo) references pecasEmdo(idpecas),
constraint fk_OSIdOs foreign key (Os_idOs) references Os(idOs)
);

-- tabelas de mecanicos_OS
create table EquipMec_OS(
Equipe_mecanicos_idEquipMec int,
EM_Serviço_idServiço int,
EMS_idVeiculoClient int,
Eqp_Mec_Serv_idserv int,
OS_idOs int,
constraint fk_Equipe_mecanicos_idEquipMec foreign key (Equipe_mecanicos_idEquipMec) references Equipe_Mecanicos(idEquipe_mecanicos),
constraint fk_EM_Serviço_idServiço foreign key (EM_Serviço_idServiço) references Serviço(idServiço),
constraint fk_EMS_idVeiculoClient foreign key (EMS_idVeiculoClient) references Cliente_Veiculo(idVeiculoCliente),
constraint fk_idEquipe_mecanicos foreign key (Eqp_Mec_Serv_idserv) references Equipe_mecanicos(idEquipe_mecanicos),
constraint fk_OS_idOs foreign key (OS_idOs) references Os(idOs)
);

drop table EquipMec_OS;
alter table mecanicos
Add constraint fk_Equipe_mecanicos foreign key (idMecanicos) references Equipe_Mecanicos(idEquipe_mecanicos);

show tables;
