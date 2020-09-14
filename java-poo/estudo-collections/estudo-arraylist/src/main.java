public class main {
    public static void main(String[] args){
        Empresa empresa = new Empresa("Microsoft");
        Funcionario felipe = new Funcionario(145143, "Felipe", 20, "DEV PLENO", 4000.00);
        Funcionario felipe1 = new Funcionario(1451432, "Felipe", 20, "DEV PLENO", 4000.00);
        Funcionario bill = new Funcionario(123456, "Bill", 20, "DBA", 15000.00);
        Funcionario steve = new Funcionario(400235, "Steve", 20, "DEV SÊNIOR", 9000.00);
        Funcionario linus = new Funcionario(145863, "Linus", 20, "DEV SÊNIOR", 9000.00);
        Funcionario wesley = new Funcionario(156325, "Wesley", 20, "DEV JUNIOR", 2500.00);
        empresa.contratar(felipe);
        empresa.contratar(felipe1);
        empresa.contratar(bill);
        empresa.contratar(steve);
        empresa.contratar(linus);
        empresa.contratar(wesley);
        empresa.contratar(wesley);

        System.out.println(empresa.saberIndice(felipe));
        System.out.println(empresa.saberIndice(felipe1));
        System.out.println(empresa.saberIndice(bill));
        System.out.println(empresa.saberIndice(steve));
        System.out.println(empresa.saberIndice(linus));
        System.out.println(empresa.saberIndice(wesley));

        empresa.alterarCargo(felipe, "DEV ESTAGIÁRIO");
        empresa.alterarSalario(felipe, 900.00);

        empresa.demitir(bill);
        empresa.alterarSalario(bill, 16500.00);

        empresa.alterarSalario(linus, 10500.00);

        System.out.println(empresa.toString());

        System.out.println(empresa.saberIndice(felipe));
        System.out.println(empresa.saberIndice(felipe1));
        System.out.println(empresa.saberIndice(bill));
        System.out.println(empresa.saberIndice(steve));
        System.out.println(empresa.saberIndice(linus));
        System.out.println(empresa.saberIndice(wesley));



    }
}
