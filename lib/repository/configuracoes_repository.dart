import 'package:calculadora_imc/model/imc.dart';
import 'package:hive/hive.dart';

class ConfiguracoesRepository {
  static late Box _box;

  static Future<ConfiguracoesRepository> carregar() async {
    if (Hive.isBoxOpen("configuracoes")) {
      _box = Hive.box('configuracoes');
    } else {
      _box = await Hive.openBox("configuracoes");
    }
    return ConfiguracoesRepository._criar();
  }

  ConfiguracoesRepository._criar();

  void salvarDados(Imc imcUser) {
    _box.put('configuracoes', {
      "id": imcUser.id,
      "altura": imcUser.altura,
      "peso": imcUser.peso,
      "data": imcUser.data
    });
  }

  Imc obterDados(){
    var configuracoes = _box.get("configuracoes");
    if(configuracoes == null){
      return Imc.vazio();
    } else{
      return Imc(
        configuracoes['id'],
        configuracoes['altura'],
        configuracoes['peso'],
        configuracoes['data']
      );
    }
  }

}
