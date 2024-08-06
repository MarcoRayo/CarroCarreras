import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modelo/data/models/race_car_model.dart';
import '../cubit/car_cubit.dart'; // Asegúrate de importar el archivo del cubit

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _modelController = TextEditingController();
  final _brandController = TextEditingController();
  final _speedController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _modelController.dispose();
    _brandController.dispose();
    _speedController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final model = _modelController.text;
      final brand = _brandController.text;
      final speed = int.tryParse(_speedController.text) ?? 0;
      final weight = double.tryParse(_weightController.text) ?? 0.0;

      // Crear un nuevo objeto Car
      final car = CarModel(
        id: 0, // Puedes generar un ID o dejarlo vacío si es autogenerado
        brand: brand,
        model: model,
        speed: speed,
        weight: weight,
      );

      // Usar el cubit para agregar el nuevo coche
      final busCubit = BlocProvider.of<CarCubit>(context).createCar(car);
      // Volver a la pantalla anterior
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nuevo Coche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: 'Modelo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el modelo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(labelText: 'Marca'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la marca';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _speedController,
                decoration: const InputDecoration(labelText: 'Velocidad Máxima'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la velocidad máxima';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Ingresa un número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Peso'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el peso';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Ingresa un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Agregar Coche'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
