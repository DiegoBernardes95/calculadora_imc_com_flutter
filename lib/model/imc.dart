class Imc{
  double _peso;
  double _altura;

  Imc(this._altura, this._peso);

  double get altura => _altura;
  void set altura(double altura){
    _altura = altura;
  }

  double get peso => _peso;
  void set peso(double peso){
    _peso = peso;
  }
}