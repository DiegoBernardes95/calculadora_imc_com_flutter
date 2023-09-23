import 'package:calculadora_imc/model/imc.dart';
import 'package:calculadora_imc/pages/configuracoes_pages.dart';
import 'package:calculadora_imc/repository/configuracoes_repository.dart';
import 'package:calculadora_imc/repository/historico_repository.dart';
import 'package:calculadora_imc/repository/imc_repository.dart';
import 'package:flutter/material.dart';

class CalculadoraImcPages extends StatefulWidget {
  const CalculadoraImcPages({super.key});

  @override
  State<CalculadoraImcPages> createState() => _CalculadoraImcPagesState();
}

class _CalculadoraImcPagesState extends State<CalculadoraImcPages> {
  var usuario = Imc.vazio();
  late ConfiguracoesRepository configuracoesRepository;

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    usuario = configuracoesRepository.obterDados();
    setState(() {});
  }

  // Método que renderiza o resultado do cálculo de IMC no modalBottom
  Expanded modalIMC() {
    var imc = ImcRepository.onlyImc(usuario);
    var classificacao = ImcRepository.classificacao(imc);
    late String textClassificacao;

    if(classificacao == "saudável"){
      textClassificacao = "Seu estado é";
    } else{
      textClassificacao = "Seu estado é de";
    }

    // Widget com o resultado do cálculo
    return Expanded(
      child: imc == "0" || classificacao == "Classificação indisponivel"
          ? // Condição que verifica se os dados informados permitem o cálculo do IMC. Se não permitirem, será exibida uma tela informando o erro. Se permitirem, será exibida uma tela com o resultado do cálculo

          Column(
              // Resultado para o caso de informações incompatíveis
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("lib/images/indisponivel.png", height: 100),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: const Text(
                      "Cálculo indisponível!\n Preencha as informações corretamente.",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ],
            )
          : Column(
              // Resultado para o caso de informações compatíveis
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Seu IMC é de...",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  color: Colors.cyan,
                  child: Text(
                    imc,
                    style: const TextStyle(
                        fontSize: 50, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Text('$textClassificacao $classificacao',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.list),
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ConfiguracoesPage()));
        },
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black87,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                children: [
                  const SizedBox(height: 60),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Calculadora".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      const SizedBox(height: 13),
                      const Text("Índice de Massa Corporal",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ],
                  ),

                  const SizedBox(height: 110),

                  // Código para obter o peso
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("peso:".toUpperCase(),
                          style: const TextStyle(color: Colors.white)),
                      Text("${usuario.peso.toStringAsFixed(0)}kg",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                            min: 0,
                            max: 300,
                            value: usuario.peso,
                            onChanged: (value) {
                              setState(() {
                                usuario.peso = value;
                              });
                            }),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Código para obter a altura
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("altura:".toUpperCase(),
                          style: const TextStyle(color: Colors.white)),
                      Text("${usuario.altura.toStringAsFixed(2)}m",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17))
                    ],
                  ),
                  Slider(
                      min: 0,
                      max: 5,
                      value: usuario.altura,
                      onChanged: (value) {
                        setState(() {
                          usuario.altura = value;
                        });
                      }),

                  const SizedBox(height: 50),

                  // ModalBottom para exibição do IMC a partir da altura e peso informados
                  TextButton(
                    onPressed: () async {
                      // O evento onPressed é assíncrono para que, ao fechar o modalBottom, o peso e altura informados retornem zerados para nova consulta
                      await showModalBottomSheet(
                          // o peso e altura informados só serão zerado após a execução e conclusão desse trecho
                          backgroundColor: Colors.black,
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          builder: (BuildContext bc) {
                            return modalIMC(); // Esse método retorna todo um widget com todo o conteúdo do modal
                          });

                      if(usuario.altura != 0 && usuario.peso != 0){
                        configuracoesRepository.salvarDados(usuario);
                        HistoricoRepository.salvar(Imc(0, usuario.altura, usuario.peso, usuario.data));
                      }
                      
                      setState(() {
                        // ao fechar o modalBottom, o app será atualizado com enfase no código declarado no escopo do setState, mantendo a altura e peso declarados
                        carregarDados();
                      });
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.cyan)),
                    child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text("Calcular".toUpperCase(),
                            style: const TextStyle(color: Colors.white))),
                  ),
                  const SizedBox(height: 90),
                  Image.asset("lib/images/blood-pressure.png")
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
