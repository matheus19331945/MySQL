-- criando banco de dados
create database if not exists db_jogador;

-- ativando db
use db_jogador;

-- criando tabelas

create table if not exists tbl_time(
cod_time int auto_increment primary key,
nome varchar(40) not null,
numero_socios smallint not null
);

create table if not exists tbl_jogador(
matricula int auto_increment primary key,
nome varchar(40) not null,
cpf varchar(14) not null unique,
cod_time int not null,
constraint fk_jogador_time foreign key (cod_time) references tbl_time (cod_time)
);

create table if not exists tbl_telefone(
cod integer auto_increment primary key,
numero varchar(40),
matricula int not null,
constraint fk_telefone_jogador foreign key (matricula) references tbl_jogador (matricula)
);

-- inserindo dados
insert into tbl_time(nome,numero_socios) 
values ('ziketas',31),('São Paulo',10000),
('Palmeiras',2000);

insert into tbl_jogador(nome,cpf,cod_time)
values ('pedro cobucci','111.222.333-44',1),
('cristiano ronaldo', '111.222.333-45',2),
('rony','111.222.333-46',3),
('gabriel jesus','111.222.333-47',2),
('lionel messi','111.222.333-48',1);

insert into tbl_telefone(numero,matricula)
values('999991234',5),('992231211',3),
('928282889',4),('964537321',3),('543675842',5),
('654738922',1),('345245678',1);
