
import 'package:bloc/bloc.dart';
import 'package:modelo/data/models/race_car_model.dart';
import 'package:modelo/presentation/cubit/car_state.dart';

import '../../data/repository/car_repository.dart';


class CarCubit extends Cubit<CarState> {
  final CarRepository carRepository;

  CarCubit({required this.carRepository}) : super(CarInitial());


  Future<void> createCar(CarModel car) async {
    try {
      emit(CarLoading());
      await carRepository.createCar(car);
      final cars = await carRepository.getAllCars();
      emit(CarSuccess(cars: cars));
    } catch (e) {
      emit(CarError(message: e.toString()));
    }
  }

  Future<void> getCar(String id) async {
    try {
      emit(CarLoading());
      final car = await carRepository.getCar(id);
      emit(CarSuccess(cars: [car]));
    } catch (e) {
      emit(CarError(message: e.toString()));
    }
  }

  Future<void> updateCar(CarModel car) async {
    try {
      emit(CarLoading());
      await carRepository.updateCar(car);
      final cars = await carRepository.getAllCars();
      emit(CarSuccess(cars: cars));
    } catch (e) {
      emit(CarError(message: e.toString()));
    }
  }

  Future<void> deleteCar(String id) async {
    try {
      emit(CarLoading());
      await carRepository.deleteCar(id);
      final cars = await carRepository.getAllCars();
      emit(CarSuccess(cars: cars));
    } catch (e) {
      emit(CarError(message: e.toString()));
    }
  }

  Future<void> fetchAllCars() async {
    try {
      emit(CarLoading());
      final cars = await carRepository.getAllCars();
      emit(CarSuccess(cars: cars));
    } catch (e) {
      emit(CarError(message: e.toString()));
    }
  }
}
