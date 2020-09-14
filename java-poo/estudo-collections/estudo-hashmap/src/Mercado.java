import java.util.HashMap;

public class Mercado {
    private String nome;
    private HashMap<String, Double> produtosDisponiveis = new HashMap<>();
    double valorCompra;

    public Mercado(String nome) {
            this.nome = nome;
            this.produtosDisponiveis.put("batata", 3.79);
            this.produtosDisponiveis.put("feijao", 8.89);
            this.produtosDisponiveis.put("arroz", 11.79);
            this.produtosDisponiveis.put("cenoura", 2.59);
            this.produtosDisponiveis.put("farofa", 3.99);
            this.produtosDisponiveis.put("salgadinho", 5.60);
            this.produtosDisponiveis.put("mostarda", 4.59);
            this.produtosDisponiveis.put("leite", 3.44);
            this.produtosDisponiveis.put("bolacha", 2.89);
            this.produtosDisponiveis.put("carne moida", 11.99);
            this.produtosDisponiveis.put("peito de frango", 9.59);
            this.produtosDisponiveis.put("caixa de chocolate", 8.49);
            this.produtosDisponiveis.put("mortadela", 6.75);
            this.produtosDisponiveis.put("refrigerante", 3.99);
            this.produtosDisponiveis.put("vinho", 14.90);
    }

    public void adicionarAoCarrinho(String produto){
        if(this.produtosDisponiveis.containsKey(produto.toLowerCase())){
            this.valorCompra+=this.produtosDisponiveis.get(produto.toLowerCase());
            System.out.println("Produto " + produto.toLowerCase() + "adicionado ao carrinho");
        }else{
            System.out.println("Produto não encontrado");
        }
    }

    public void removerDoCarrinho(String produto){
        if(this.produtosDisponiveis.containsKey(produto.toLowerCase())){
            this.valorCompra-=this.produtosDisponiveis.get(produto.toLowerCase());
            System.out.println("Produto " + produto.toLowerCase() + "removido do carrinho");
        }else{
            System.out.println("Produto não encontrado");
        }
    }

    public void finalizarCompra(){
        if(this.valorCompra<0){
            this.valorCompra = 0;
        }
        System.out.println("Obrigado por comprar conosco! \n\tValor da compra: "+this.valorCompra);
    }

    public String mostrarProdutos(){
        return this.produtosDisponiveis.toString();
    }

    public String getNome() {
        return nome;
    }
}
