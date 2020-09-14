import java.util.HashSet;

public class ListaDeDesejos {
    HashSet<Produto> produtos;

    public ListaDeDesejos(int tamanhoLista) {
        this.produtos = new HashSet<>(tamanhoLista);
    }

    public void adicionarProduto(Produto produto){
        if(this.produtos.add(produto)){
            System.out.println("Produto adicionado com sucesso");
        }else{
            System.out.println("Produto já adicionado anteriormente");
        }
    }

    public void removerProduto(Produto produto){
        if(this.produtos.remove(produto)){
            System.out.println("Produto removido com sucesso!");
        }else{
            System.out.println("Produto não localizado");
        }
    }

    @Override
    public String toString() {
        return "ListaDeDesejos:\n\t" +
                "Produtos: \n\n" + produtos;
    }
}
