import 'package:calculadora_imc/model/imc.dart';
import 'package:calculadora_imc/pages/historico_pages.dart';
import 'package:calculadora_imc/repository/configuracoes_repository.dart';
import 'package:flutter/material.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage>{
  final white = Colors.white;
  Imc configuracoesModel = Imc.vazio();
  late ConfiguracoesRepository configuracoesRepository;

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Configurações"),
          centerTitle: true,
          toolbarHeight: 80,
        ),
        body: Container(
          color: Colors.black87,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Altura",
                      style: TextStyle(
                          color: white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text("${configuracoesModel.altura.toStringAsFixed(2)}m",
                      style: TextStyle(color: white, fontSize: 16))
                ],
              ),
              const Divider(color: Colors.white),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Peso",
                      style: TextStyle(
                          color: white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text("${configuracoesModel.peso.toStringAsFixed(2)}kg",
                      style: TextStyle(color: white, fontSize: 16))
                ],
              ),
              const Divider(color: Colors.white),
              const SizedBox(height: 40),

              TextButton(
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.cyan)),

                onPressed: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const HistoricoPages())
                  );
                }, 
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Histórico de IMC", style: TextStyle(color: white, fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                )
              ),
              const SizedBox(height: 40),
            ])
          ),
          
        );
  }
}

