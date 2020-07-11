import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/FuelEvent.dart';
import 'package:flutter_counter/FuelState.dart';

class FuelBloc extends Bloc<FuelEvent, FuelState> {
  FuelBloc() : super(FuelState());

  @override
  Stream<FuelState> mapEventToState(FuelEvent event) async* {
    if (event is SubmitButtonPressed) {
      try {
        double _distance = double.parse(event.distance);
        double _fuelCost = double.parse(event.price);
        double _consumption = double.parse(event.distancePerUnit);
        double _totalcost = _distance / _consumption * _fuelCost;
        _totalcost = double.parse((_totalcost ).toStringAsFixed(2));
        yield FuelInputSuccess(_totalcost);
      } catch (error) {
        yield FuelInputError(error: error);
      }
    } else if (event is ResetButtonPressed) {
      yield FuelInputReset();
    }
  }
}
