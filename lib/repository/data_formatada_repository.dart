class DataFormatadaRepository{
  static String dataFormatada(DateTime data){
    var dia = data.day;
    var mes = data.month;
    var ano = data.year;
    var hora = data.hour;
    var minuto = data.minute;
    var segundo = data.second;

    var resultado = '$dia/$mes/$ano às $hora:$minuto:$segundo';

    return resultado;
  }
}