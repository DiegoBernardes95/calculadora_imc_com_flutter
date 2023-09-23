class Imc{
  int _id = 0;
  late double _peso;
  late double _altura;
  DateTime _data = DateTime.now();

  Imc(this._id, this._altura, this._peso, this._data);

  Imc.vazio(){
    _peso = 0;
    _altura = 0;
    _data = DateTime.now();
  }

  int get id => _id;

  double get altura => _altura;
  void set altura(double altura){
    _altura = altura;
  }

  double get peso => _peso;
  void set peso(double peso){
    _peso = peso;
  }

  DateTime get data => _data;
}