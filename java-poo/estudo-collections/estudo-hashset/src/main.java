import java.math.BigDecimal;
import java.util.Scanner;

public class main {
    public static void main(String[] args){
        Scanner tecladonum = new Scanner(System.in);
        Scanner teclado = new Scanner(System.in);
        int menuHandler = 0;
        int opcao;
        String nome;
        String urgencia;
        double valor;

        System.out.println("Bem vindo à sua lista de desejos automatizada!");
        System.out.println("Para começarmos insira o tamanho médio esperado para a lista");
        int tamanhoEsperado = tecladonum.nextInt();
        ListaDeDesejos lista = new ListaDeDesejos(tamanhoEsperado);
        while (menuHandler == 0){
            System.out.println("O que deseja fazer a seguir?\n\nDigite 1 para inserir um novo produto na lista\nDigite 2 para remover um produto da lista\nDigite 0 para finalizar a lista");
            opcao = tecladonum.nextInt();
            switch (opcao){
                case 1:
                    System.out.println("Digite o produto que deseja adicionar: ");
                    nome = teclado.nextLine();
                    System.out.println("Digite seu valor: ");
                    valor = tecladonum.nextDouble();
                    System.out.println("Digite a urgência que precisa o produto");
                    urgencia = teclado.nextLine();
                    lista.adicionarProduto(new Produto(nome.toLowerCase(), BigDecimal.valueOf(valor), urgencia));
                    break;
                case 2:
                    System.out.println("Digite o produto que deseja remover: ");
                    nome = teclado.nextLine();
                    System.out.println("Digite seu valor: ");
                    valor = tecladonum.nextDouble();
                    lista.removerProduto(new Produto( nome.toLowerCase(), BigDecimal.valueOf(valor), "Remoção"));
                    break;
                case 0:
                    System.out.println(lista.toString());
                    menuHandler = 1;
                    break;
                default:
                    System.out.println("Valor inválido, tente novamente");
                    break;

            }
        }
    }
}
