import 'package:calculadora_imc/model/imc.dart';
import 'package:calculadora_imc/repository/database_repository.dart';

class HistoricoRepository{
  Future<List<Imc>> obterDados() async {
    List<Imc> historico = [];
    var db = await DatabaseRepository().obterDatabase();
    var result = await db.rawQuery(
      "SELECT id, peso, altura, data FROM historico"
    );
    for (var element in result) {
      historico.add(Imc(int.parse(element['id'].toString()), double.parse(element['altura'].toString()), double.parse(element['peso'].toString()), DateTime.parse(element['data'].toString())));
    }
    return historico;
  }

  static Future<void> salvar(Imc imc) async{
    var db = await DatabaseRepository().obterDatabase();
    db.rawInsert('INSERT INTO historico (peso, altura, data) VALUES (?, ?, ?)', [imc.peso, imc.altura, DateTime.now().toString()]);
  }

  static Future<void> remover(int id) async{
    var db = await DatabaseRepository().obterDatabase();
    db.rawInsert('DELETE FROM historico WHERE id = ?', [id]);
  }
}