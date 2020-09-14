
public class Funcionario {
    private int id;
    private String nome;
    private int idade;
    private String cargo;
    private double salario;

    public Funcionario(int id, String nome, int idade, String cargo, double salario) {
        this.id = id;
        this.nome = nome;
        this.idade = idade;
        this.cargo = cargo;
        this.salario = salario;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Funcionario that = (Funcionario) o;
        return id == that.id;
    }

    public void setSalario(double salario) {
        this.salario = salario;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public int getId() {
        return id;
    }

    public String getCargo() {
        return cargo;
    }

    public double getSalario() {
        return salario;
    }

    @Override
    public String toString() {
        return "\nFuncionario" +
                "\n\tid: " + id +
                "\n\tnome: " + nome +
                "\n\tidade: " + idade +
                "\n\tcargo: " + cargo +
                "\n\tsalario: " + salario;
    }

}
