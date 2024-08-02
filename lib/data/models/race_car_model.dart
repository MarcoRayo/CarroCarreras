//Coche de Carreras (atributos: id, marca, modelo, velocidadMaxima, peso)
class CarModel {

  final String? id;
  final String brand;
  final String model;
  final int speed;
  final double weight;

  //constructor del objeto
  CarModel({
    this.id,
    required this.brand,
    required this.model,
    required this.speed,
    required this.weight
  });

  //método para convertir el objeto json a un UserModel
  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      brand: json['brand'],
      model: json['model'],
      speed: json['speed'],
      weight: json['weight']
    );
  }

  //método para convertir el objeto a json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'speed': speed,
      'weight': weight
    };
  }
}