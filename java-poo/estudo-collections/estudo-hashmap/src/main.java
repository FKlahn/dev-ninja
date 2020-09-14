import java.util.Scanner;

public class main {
    public static void main(String[] args){
        Mercado mercado = new Mercado("Dia");
        Scanner teclado = new Scanner(System.in);
        Scanner tecladonum = new Scanner(System.in);
        int opcao;
        int menuHandler = 0;
        String produtoEscolhido;

        while (menuHandler == 0){
            System.out.println("Bem vindo ao mercado " + mercado.getNome() +"!\nEscolha uma das opções abaixo:" );
            System.out.println("\n\tDigite 1 para ver os produtos disponiveis");
            System.out.println("\n\tDigite 2 para adicionar um produto ao carrinho");
            System.out.println("\n\tDigite 3 para remover um produto do carrinho");
            System.out.println("\n\tDigite 4 para finalizar a compra");
            System.out.println("\n\tDigite 0 para sair");
            System.out.println("Opção desejada: ");
            opcao = tecladonum.nextInt();
            switch (opcao){
                case 1:
                    System.out.println("Produtos disponiveis:\n" + mercado.mostrarProdutos());
                    break;

                case 2:
                    System.out.println("Digite o nome do produto que deseja adicionar ao carrinho: ");
                    produtoEscolhido = teclado.nextLine();
                    mercado.adicionarAoCarrinho(produtoEscolhido);
                    break;

                case 3:
                    System.out.println("Digite o nome do produto que deseja remover do carrinho: ");
                    produtoEscolhido = teclado.nextLine();
                    mercado.removerDoCarrinho(produtoEscolhido);
                    break;

                case 4:
                    mercado.finalizarCompra();
                    menuHandler = 1;
                    break;

                case 0:
                    System.out.println("Volte sempre!");
                    menuHandler = 1;
                    break;

                default:
                    System.out.println("Opção inválida! Tente novamente");
                    break;
            }

        }

    }
}
