Create database if not exists db_Atividade


use db_Atividade;

drop table if exists tbl_;

Create table if not exists tbl_Produto(
ID_Lancamento mediumint auto_increment primary key,
ID_NF tinyint not null,
ID_ITEM tinyint not null,
COD_PROD tinyint not null,
VALOR_UNIT decimal not null,
QUANTIDADE tinyint not null,
DESCONTO_PORCENTAGEM decimal null
);

insert into tbl_Produto (ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, QUANTIDADE, DESCONTO_PORCENTAGEM)
 values (7,4,5,30.00,10,1);

delete from tbl_Produto where ID_Lancamento =4;

select * from tbl_Produto;

select * from tbl_Produto where DESCONTO_PORCENTAGEM is not null;
 
 
 
-- pesquisando itens sem desconto
select * from tbl_Produto where DESCONTO_PORCENTAGEM = 0;

-- pesquisando item com desconto, criando coluna solicitada
alter table tbl_Produto add column VALOR_VENDIDO float null;
update tbl_Produto set VALOR_VENDIDO = (VALOR_UNIT*(DESCONTO_PORCENTAGEM/100)) where VALOR_VENDIDO is null;
select * from tbl_Produto where DESCONTO_PORCENTAGEM > 0;

-- Substituindo por 0
update tbl_Produto set DESCONTO_PORCENTAGEM = 0 where DESCONTO_PORCENTAGEM is null;

-- itens vendidos, criação tabela solicitada
alter table tbl_Produto add column VALOR_TOTAL float null;
update tbl_Produto set VALOR_TOTAL = QUANTIDADE * VALOR_UNIT where VALOR_TOTAL is null;
select * from tbl_Produto;


-- pesquisa do maior para o valor menor
Select ID_NF, VALOR_TOTAL from tbl_Produto
group by ID_NF, VALOR_TOTAL DESC;

Select ID_NF, VALOR_VENDIDO from tbl_Produto
group by ID_NF, VALOR_VENDIDO DESC;

-- O que mais vendeu
Select COD_PROD, QUANTIDADE from tbl_Produto
group by COD_PROD, QUANTIDADE DESC;

-- vendida mais de 10 unidades
SELECT ID_NF, COD_PROD, QUANTIDADE from tbl_Produto where QUANTIDADE >= 10
group by ID_NF, COD_PROD DESC;

-- valor total das NF
SELECT ID_NF, sum(VALOR_TOTAL) from tbl_Produto 
group by ID_NF having sum(VALOR_TOTAL) > 500 order by sum(VALOR_TOTAL) DESC;






