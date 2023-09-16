class ImcRepository{
  static String classificacao(String imcUser){
    var imc = double.parse(imcUser);
    var classificacao = '';

    if(imc < 16){
      classificacao = "Seu estado é de magreza grave!";
    } else if(imc >= 16 && imc < 17){
      classificacao = "Seu estado é de magreza moderada!";
    } else if(imc >= 17 && imc < 18.5){
      classificacao = "Seu estado é de magreza leve!";
    } else if(imc >= 18.5 && imc < 25){
      classificacao = "Seu estado é saudável!";
    } else if(imc >= 25 && imc < 30){
      classificacao = "Seu estado é de sobrepeso!";
    } else if(imc >= 30 && imc < 35){
      classificacao = "Seu estado é de obessidade grau I";
    } else if(imc >= 35 && imc < 40){
      classificacao = "Seu estado é de obessidade grau II (severa)!";
    } else if(imc >= 40 ){
      classificacao = "Seu estado é de obessidade grau III (mórbida)!";
    }

    return imc == 0 ? "Classificação indiponível" : classificacao;
  }

  static String onlyImc(double altura, double peso){
    double imc = peso / (altura * altura);
    var resultado = !imc.isNaN && peso != 0 && altura != 0 ? imc.toStringAsFixed(2) : "0";

    return resultado;
  }
}