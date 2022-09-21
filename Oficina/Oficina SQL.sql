show databases;
create database Oficina;
Use Oficina;
Show Tables;
Create Table CadastroDePessoas(
	id_Cliente int auto_increment Primary Key,
	NomeCompleto Varchar(45),
    endereço Varchar(45),
    CPF Char(11),
    Contato Varchar(45),
    constraint unique_cpf_cliente unique (cpf));
    
    Create Table Cliente(
	id_cliente Primary key,

    
    
    
desc CadastroDePessoas;
