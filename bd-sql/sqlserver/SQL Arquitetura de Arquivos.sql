/*Arquivos LDF e MDF
Ambos criado por padrão

Master Data File - Armazena Dados
Ao preencher o dado de uma tabela, também é criado uma transação

	transação 

Log Data File - Armazena Log
Salva a transação durante o momento de sua execução

COMMIT - Salva o Log do LDF no MDF e após apaga o Log, deixando a MDF atualizada
ROLLBACK - Apaga os dados do LDF e não salva nada no MDF, retornando ao ponto anterior do Banco

MDF - Dados do Sistema (Dicionário) **Recomendado
LDF
NDF - GP(Grupo de Dados)
		G_MKT	<-	G01 <- xyz.ndf
		G_RH	<-	G02 <- abcd.ndf
		G_VENDAS	<-	G03 <-ghi.ndf

**Além de separarmos logicamente, também é possível separar físicamente os grupos
	
Organizar Fisicamente e Logicamente um Banco de Dados

1 - Criar o Banco com Arquivos para os setores de MKT e VENDAS
2 - Criar um Arquivo Geral
3 - Deixar o MDF apenas com o Dicionário de Dados
4 - Criar 2 grupos de arquivos (padrão - Primary - MDF)
*/

CREATE TABLE TB_EMPRESA(
	ID INT,
	NOME VARCHAR(50)
)
GO