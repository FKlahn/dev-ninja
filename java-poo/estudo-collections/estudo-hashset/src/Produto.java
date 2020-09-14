import java.math.BigDecimal;
import java.util.Objects;

public class Produto {
    String nome;
    BigDecimal valor;
    String Urgencia;

    public Produto(String nome, BigDecimal valor, String urgencia) {
        this.nome = nome;
        this.valor = valor;
        Urgencia = urgencia;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Produto produto = (Produto) o;
        return nome.equals(produto.nome) &&
                valor.equals(produto.valor);
    }

    @Override
    public int hashCode() {
        return Objects.hash(nome, valor);
    }

    @Override
    public String toString() {
        return "\nProduto: " + nome +
                "\n\tValor: " + valor +
                "\n\tUrgencia: " + Urgencia;
    }
}
