import 'package:calculadora_imc/model/imc.dart';
import 'package:calculadora_imc/repository/data_formatada_repository.dart';
import 'package:calculadora_imc/repository/historico_repository.dart';
import 'package:calculadora_imc/repository/imc_repository.dart';
import 'package:flutter/material.dart';

class HistoricoPages extends StatefulWidget {
  const HistoricoPages({super.key});

  @override
  State<HistoricoPages> createState() => _HistoricoPagesState();
}

class _HistoricoPagesState extends State<HistoricoPages> {
  final white = Colors.white;
  var _historico = const <Imc>[];
  HistoricoRepository historicoRepository = HistoricoRepository();
  bool vazio = false;

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  carregarDados() async {
    _historico = await historicoRepository.obterDados();

    setState(() {});

    if (_historico.isNotEmpty) {
      vazio = false;
    } else {
      vazio = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Histórico"),
          centerTitle: true,
          toolbarHeight: 80,
        ),
        body: !vazio
            ? Container(
                color: Colors.black87,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                    
                    itemCount: _historico.length,
                    itemBuilder: (bc, index) {
                      var imc = ImcRepository.onlyImc(Imc(
                                            _historico[index].id,
                                            _historico[index].altura,
                                            _historico[index].peso,
                                            _historico[index].data));
                      return Dismissible(
                        key: Key(_historico[index].id.toString()),
                        onDismissed: (direction) async {
                          await HistoricoRepository.remover(
                              _historico[index].id);
                          carregarDados();
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          color: Colors.cyan,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Altura:",
                                              style: TextStyle(
                                                color: white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "${_historico[index].altura.toStringAsFixed(2)}m",
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              "Peso:",
                                              style: TextStyle(
                                                color: white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "${_historico[index].peso.toStringAsFixed(2)}kg",
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Data:',
                                              style: TextStyle(
                                                color: white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              DataFormatadaRepository.dataFormatada(
                                                  _historico[index].data),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text("IMC:",
                                                style: TextStyle(
                                                    color: white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold)),
                                            const SizedBox(width: 10),
                                            Text(imc)
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                      children: [
                                        Text("Classificação:", style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.bold)),
                                        const SizedBox(width: 10),
                                        Text(ImcRepository.classificacao(imc.toString()).toUpperCase()),
                                      ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            : Container(
                color: Colors.black87,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/images/indisponivel.png', height: 200),
                    const SizedBox(height: 20),
                    Text("Sem resultados no histórico...", style: TextStyle(color: white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                )));
  }
}
