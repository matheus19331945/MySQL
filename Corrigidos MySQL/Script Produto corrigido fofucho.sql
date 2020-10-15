create database if not exists bd_Produto;

use bd_Produto;

create table if not exists tbl_vendas (
id_nf tinyint not null,
id_item tinyint not null, 
cod_prod tinyint not null,
valor_unit float not null,
quantidade tinyint not null, 
desconto tinyint null,     # 5 = 5% = 5/100
# 1 chave primária composta por 3 campos
primary key (id_nf, id_item, cod_prod));  #chave primária composta 

#inserindo informações na tabela
insert into tbl_vendas (id_nf, id_item, cod_prod, valor_unit, quantidade, 
desconto) values (1,1,1,25,10,5),
(1,2,2,13.50,3,null),
(1,3,3,15,2,null), (
	1,
    4,
    4,
    10.00,
    1,
    null
), (
	1,
    5,
    5,
    30.00,
    1,
    null
), (
	2,
    1,
    3,
   15.00,
    4,
    null
), (
	2,
    2,
    4,
    10.00,
    5,
    null
), (
	2,
    3,
    5,
    30.00,
    7,
    null
), (
	3,
    1,
    1,
    25.00,
    5,
    null
), (
	3,
    2,
    4,
    10.00,
    4,
    null
), (
	3,
    3,
    5,
    30.00,
    5,
    null
), (
	3,
    4,
    2,
    13.50,
    7,
    null
), (
	4,
    1,
    5,
    30.00,
    10,
    15
), (
	4,
    2,
    4,
    10.00,
    12,
    5
), (
	4,
    3,
    1,
    25.00,
    13,
    5
), (
	4,
    4,
    2,
    13.50,
    15,
    5
), (
	5,
    1,
    3,
    15.00,
    3,
    null
), (
	5,
    2,
    5,
    30.00,
    6,
    null
), (
	6,
    1,
    1,
    25.00,
    22,
    15
), (
	6,
    2,
    3,
    15.00,
    25,
    20
), (
	7,
    1,
    1,
    25.00,
    10,
    3
), (
	7,
    2,
    2,
    13.50,
    10,
    4
), (
	7,
    3,
    3,
    15.00,
    10,
    4
), (
	7,
    4,
    5,
    30.00,
    10,
    1
);
select * from tbl_vendas;
# Exercícios
#a) Pesquise (consulte, imprima, mostre... select)  os   itens   que 
#  foram   vendidos   sem   desconto. (filtro where .....) 
#  As colunas presentes no resultado da consulta são: ID_NF, ID_ITEM,
# COD_PROD E VALOR_UNIT. (não posso usar *)
select id_nf, id_item, cod_prod, valor_unit from tbl_vendas
where desconto is null;

#b)Pesquise  os   itens   que   foram  vendidos  com   desconto.  
# As   colunas   presentes   no resultado  da  consulta  são: 
# ID_NF,  ID_ITEM,  COD_PROD,  VALOR_UNIT  E  O  VALOR VENDIDO.
# (virtual) - não está gravada na tabela
# OBS:O valor vendido é igual ao VALOR_UNIT -(VALOR_UNIT*(DESCONTO/100)).
select id_nf, id_item, cod_prod, valor_unit, 
valor_unit-valor_unit*desconto/100 as valor_vendido from tbl_vendas
where desconto is not null;

#c)Altere o valor do desconto (para zero) de todos os registros 
# onde este campo é nulo
# alterar registros --> update  alter table --> estrutura tabela
# cuidado!!!!Não acreditem na trava do mysql
update tbl_vendas set desconto = 0 where desconto is null;

#d)Pesquise os itens que  foram vendidos. As colunas presentes no 
#resultado da consulta são:ID_NF,ID_ITEM,COD_PROD,VALOR_UNIT,
#VALOR_TOTAL, DESCONTO, VALOR_VENDIDO.  
# OBS:O  VALOR_TOTAL  é  obtido  pela  fórmula:  
#QUANTIDADE  * VALOR_UNIT. 
#O VALOR_VENDIDO é igual a VALOR_UNIT -(VALOR_UNIT*(DESCONTO/100)).
select id_nf as 'Nota Fiscal', id_item, cod_prod, valor_unit,quantidade,
quantidade*valor_unit as valor_total, 
desconto, valor_unit - valor_unit * desconto /100 as valor_vendido 
from tbl_vendas;

#e)Pesquise  o  valor  total  das  NF  e  ordene  o  resultado  do
# maior  valor  para  o  menor.  As colunas  presentes  no  resultado
# da  consulta  são:  ID_NF,  VALOR_TOTAL.  OBS:    O
# VALOR_TOTAL  é  obtido  pela  fórmula:  
#∑  QUANTIDADE  *  VALOR_UNIT.Agrupe  o resultado da consulta por ID_NF.
# o sum() ele irá pegar a quantidade*valor_unit de cada "linha" da nossa tabela e SOMAR todos esses,sempre que for nota fiscal igual Mysql, some!
# agrupando embaixo por id_nf(cada id_nf com seu resultad0)
select id_nf, sum(quantidade*valor_unit) as valor_total 
from tbl_vendas group by id_nf order by valor_total desc;

#f)Pesquise o valor vendido das NF e ordene o resultado do maior
# valor para o menor. As colunas  presentes  no  resultado
#  da  consulta  são:  ID_NF,  VALOR_VENDIDO, VALOR_TOTA.. 
# OBS: O VALOR_TOTAL é obtido    pela    fórmula: 
#   ∑    QUANTIDADE    *    VALOR_UNIT.    
# O VALOR_VENDIDO  é  igual  a  ∑  VALOR_UNIT -(VALOR_UNIT*(DESCONTO/100))
#.Agrupe o resultado da consulta por ID_NF.
select id_nf, valor_unit-valor_unit*desconto/100 as valor_vendido,
 sum(quantidade*valor_unit) as valor_total from tbl_vendas
  group by id_nf order by valor_vendido desc;

#g)Consulte  o  produto  que  mais  vendeu  no  geral.  
#As  colunas  presentes  no  resultado  da consulta   são: 
#COD_PROD,   QUANTIDADE.
#Agrupe   o   resultado   da   consulta   por COD_PROD.
select cod_prod as 'Produto maior venda', sum(quantidade)
as 'Total venda' from tbl_vendas 
group by cod_prod order by sum(quantidade) desc limit 1;

#h)Consulte as NF que  foram vendidas mais de  10 unidades  de
#  pelo menos um produto. As colunas presentes no resultado da
# consulta são: ID_NF, COD_PROD, QUANTIDADE.
# Agrupe o resultado da consulta por ID_NF, COD_PROD
select id_nf, cod_prod, quantidade from tbl_vendas 
where quantidade>10 group by id_nf,cod_prod;

#i)Pesquise  o  valor  total  das  NF,  onde  esse  valor  seja
#  maior  que  500,  e  ordene  o resultado do maior valor para o menor.
# As colunas presentes no resultado da consulta são: 
#ID_NF, VALOR_TOT. OBS: O VALOR_TOT é obtido pela fórmula:
# ∑ QUANTIDADE * VALOR_UNIT.Agrupe o resultado da consulta por ID_NF.
select id_nf, sum(quantidade*valor_unit) as valor_tot from tbl_vendas
where valor_tot >500 group by id_nf;  #não podemos utilizar where 
# pois o campo não existe fisicamente. Neste caso vamos utilizar
# having
# quando omitimos o asc no order by - o padrão é crescente
select id_nf, sum(quantidade*valor_unit) as valor_tot from tbl_vendas
group by id_nf having valor_tot>500 order by valor_tot;

#j)Qual  o  valor  médio  dos  descontos  dados  por  produto.  
#As  colunas  presentes  no resultado  da  consulta  são: 
# COD_PROD,  MEDIA.Agrupe  o  resultado  da  consulta  por COD_PROD.
select cod_prod, avg(desconto) from tbl_vendas group by cod_prod;
#media = soma/num itens  

# funções de agregação: sum(), avg(), max(), min(), count()
select cod_prod, count(desconto) from tbl_vendas group by cod_prod;

#k)Qual  a soma, nº de descontos, menor,  maior  e  o  valor  médio 
# dos  descontos  dados  por  produto.  
#As  colunas presentes no resultado da consulta são: 
#COD_PROD,  soma, nº de descontos, MENOR, MAIOR, MEDIA.
#Agrupe o resultado da consulta por COD_PROD.
select cod_prod, sum(desconto) as Soma, count(desconto) as Num_descontos,
max(desconto) as Maior_Desconto, min(desconto) as Menor_desconto, 
avg(desconto) as Media_Desconto from tbl_vendas 
group by cod_prod;

#i)Quais as NF que possuem mais de 3 itens vendidos. 
#As colunas presentes no resultado da  consulta  são:  
#ID_NF,  QTD_ITENS.  OBS: NÃO  ESTÁ  RELACIONADO  A  QUANTIDADE
# VENDIDA  DO  ITEM  E  SIM  A  QUANTIDADE  DE  ITENS  POR  NOTA
#  FISCAL.Agrupe  o resultado da consulta por ID_NF.
select id_nf, count(quantidade) as qtdeItens from tbl_vendas  
 group by id_nf having qtdeItens>3;