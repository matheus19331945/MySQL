create database if not exists db_meuslivros;
drop database if exists db_meuslivros;

use db_meuslivros;

create table if not exists tbl_assunto (
id_assunto tinyint auto_increment primary key,
assunto varchar(100) not null);

create table if not exists tbl_categoria (
id_categoria tinyint auto_increment primary key,
nome_categoria varchar(100) not null);

create table if not exists tbl_editora (
id_editora smallint auto_increment primary key,
nome_editora varchar(100) not null);

create table if not exists tbl_autor (
id_autor smallint auto_increment primary key,
nome_autor varchar(50) not null,
sobrenome_autor varchar(50) not null);
 
create table if not exists tbl_livro (
id_livro mediumint auto_increment primary key,
isbn varchar(13) not null,
nome_livro varchar(50) not null, 
valor_livro float not null,   # 150.90
npaginas_livro smallint not null, 
data_publicacao date null,
id_editora smallint not null, 
id_categoria tinyint not null,
id_assunto tinyint not null,
constraint fk_editora_livro foreign key (id_editora) 
references tbl_editora(id_editora),
constraint fk_categoria_livro foreign key (id_categoria)
references tbl_categoria(id_categoria),
constraint fk_assunto_livro foreign key (id_assunto)
references tbl_assunto(id_assunto));

create table if not exists tbl_livro_autor (
id_livro_autor mediumint auto_increment primary key,
id_autor smallint not null,
id_livro mediumint not null, 
constraint fk_livro_autor_autor foreign key (id_autor)
references tbl_autor(id_autor),
constraint fk_livro_autor_livro foreign key (id_livro)
references tbl_livro(id_livro));

-- alterar a estrutura da tabela tbl_livro  alter table
-- auto_increment --> 1  quero que ele comece com 100
alter table tbl_livro auto_increment=100;

# inserindo informações na tabela de autor
insert into tbl_autor (nome_autor, sobrenome_autor)
values ('André', 'Milani'), 
('William','Pereira Alves');

select * from tbl_autor;

-- inserindo a editora
insert into tbl_editora (nome_editora) values
('Novatec');

select * from tbl_editora;

# inserindo registros no assunto
insert into tbl_assunto (assunto) values
('Informática');

select * from tbl_assunto;

-- alterar o conteúdo do campo de um registro
-- where = filtro 
update tbl_assunto set assunto='Linguagem PHP' where
id_assunto=1;

-- cadastrando a categoria 
insert into tbl_categoria (nome_categoria) 
values ('Livro didático');

select * from tbl_categoria;

-- alterando o tamanho do campo nome para 100
-- mexendo na estrutura
alter table tbl_livro modify column nome_livro varchar(100);

insert into tbl_livro values (default,'978857522363',
'Construindo uma Aplicação Web Completa com PHP e MySQL',
150,516,'2017-01-01',1,1,1);

select * from tbl_livro;

-- ligar o autor ao livro
insert into tbl_livro_autor values (default,1,100);

select * from tbl_livro_autor;

-- cadastrando outro livro
insert into tbl_livro values (default,'9788575225295',
'Construindo Aplicações Web com PHP e MySQL',
130.20,336,'2017-10-01',1,1,1);

-- ligar o autor ao livro
insert into tbl_livro_autor values (default,2,101);

-- inserindo outros assuntos
insert into tbl_assunto (assunto) values
('Dicionário'), ('Gastronomia'), ('Moda'), 
('Sobrevivsdkf');

select * from tbl_assunto;

-- excluir o registro cujo id_assunto = 5
delete from tbl_assunto where id_assunto=5;

insert into tbl_assunto (assunto) values
('Natureza');

-- restrição integridade referencial - não vamos 
-- conseguir excluir pois o código está sendo 
-- utilizando numa outra tabela.
delete from tbl_assunto where id_assunto=1;  






