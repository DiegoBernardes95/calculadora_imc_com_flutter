import 'package:calculadora_imc/model/imc.dart';

class ImcRepository{

  static String classificacao(String imcUser){
    var imc = double.parse(imcUser);
    var classificacao = '';

    if(imc < 16){
      classificacao = "magreza grave";
    } else if(imc >= 16 && imc < 17){
      classificacao = "magreza moderada";
    } else if(imc >= 17 && imc < 18.5){
      classificacao = "magreza leve";
    } else if(imc >= 18.5 && imc < 25){
      classificacao = "saudável";
    } else if(imc >= 25 && imc < 30){
      classificacao = "sobrepeso";
    } else if(imc >= 30 && imc < 35){
      classificacao = "obessidade grau I";
    } else if(imc >= 35 && imc < 40){
      classificacao = "obessidade grau II (severa)";
    } else if(imc >= 40 ){
      classificacao = "obessidade grau III (mórbida)";
    }

    return imc == 0 ? "Classificação indiponível" : classificacao;
  }

  static String onlyImc(Imc imcModel) {
    
    double imc =  imcModel.peso / (imcModel.altura * imcModel.altura);
    var resultado = !imc.isNaN && imcModel.peso != 0 && imcModel.altura != 0 ? imc.toStringAsFixed(2) : "0";

    return resultado;
  }
}