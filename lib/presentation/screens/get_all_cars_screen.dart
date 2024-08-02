import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/car_cubit.dart';
import '../cubit/car_state.dart';
import '../../data/repository/car_repository.dart';  // Asegúrate de que esta ruta sea correcta

class CarListView extends StatelessWidget {
  const CarListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carros De Carreras. MAVR'),
      ),
      body: BlocProvider(
        create: (context) => CarCubit(
          carRepository: RepositoryProvider.of<CarRepository>(context),
        ),
        child: const CarListScreen(),
      ),
    );
  }
}

class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carCubit = BlocProvider.of<CarCubit>(context);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            carCubit.fetchAllCars();
          },
          child: const Text('Fetch Cars'),
        ),
        Expanded(
          child: BlocBuilder<CarCubit, CarState>(
            builder: (context, state) {
              if (state is CarLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CarSuccess) {
                final cars = state.cars;
                return ListView.builder(
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    return ListTile(
                      title: Text(
                        "Modelo: " + car.model,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black, // Puedes usar cualquier color que desees
                        ),
                      ),
                      subtitle: Text(
                        "Marca: " + car.brand + "\nVelocidad Máxima: " + car.speed.toString() + "\nPeso: " + car.weight.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey, // Puedes usar cualquier color que desees
                        ),
                      ),
                    );
                  },
                );
              } else if (state is CarError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(child: Text('Press the button to fetch cars'));
            },
          ),
        ),
      ],
    );
  }
}
