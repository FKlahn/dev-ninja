import java.util.ArrayList;

public class Empresa {
    private String nome;
    private ArrayList<Funcionario> funcionarios;

    public Empresa(String nome) {
        this.nome = nome;
        this.funcionarios = new ArrayList<>();
    }

    //ArrayList Add - Contains
    public void contratar(Funcionario funcionario){
        if(this.funcionarios.contains(funcionario)){
            System.out.println("Não foi possivel contratar: Funcionário "+ funcionario.getId() +" já contratado");
        }else {
            this.funcionarios.add(funcionario);
            System.out.println("Funcionário "+funcionario.getId()+" contratado com sucesso!");
        }
    }

    //ArrayList remove
    public void demitir(Funcionario funcionario){
        if(this.funcionarios.contains(funcionario)){
            this.funcionarios.remove(funcionario);
            System.out.println("Funcionário "+funcionario.getId() +" demitido com sucesso!");
        }else {
            System.out.println("Não foi possivel demitir: Funcionário "+ funcionario.getId() +" não localizado");
        }
    }

    //ArrayList get - indexOf
    public void alterarSalario(Funcionario funcionario, double novoSalario){
        if (this.funcionarios.contains(funcionario)) {
            int posicaoFuncionario = this.funcionarios.indexOf(funcionario);
            this.funcionarios.get(posicaoFuncionario).setSalario(novoSalario);
            System.out.println("Salario do funcionario "+funcionario.getId() +" alterado com sucesso para " + funcionario.getSalario());
        }else{
            System.out.println("Não foi possivel alterar salário: Funcionário "+ funcionario.getId() +" não localizado");
        }
    }

    //ArrayList get - indexOf
    public void alterarCargo(Funcionario funcionario, String novoCargo){
        if (this.funcionarios.contains(funcionario)) {
            int posicaoFuncionario = this.funcionarios.indexOf(funcionario);
            this.funcionarios.get(posicaoFuncionario).setCargo(novoCargo);
            System.out.println("Cargo do funcionario "+funcionario.getId() +" alterado com sucesso para " + funcionario.getCargo());
        }else{
            System.out.println("Não foi possivel alterar cargo: Funcionário "+ funcionario.getId() +" não localizado");
        }
    }

    @Override
    public String toString() {
        return "Empresa:"+ nome +
                "\n\nFuncionarios:\n" + funcionarios;
    }

    public int saberIndice(Funcionario funcionario) {
        return this.funcionarios.indexOf(funcionario);
    }
}
