import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class FuelEvent extends Equatable {
  const FuelEvent();

  @override
  List<Object> get props => [];
}

class SubmitButtonPressed extends FuelEvent {
  final String distance;
  final String distancePerUnit;
  final String price;

  const SubmitButtonPressed(
      {@required this.distance,
      @required this.distancePerUnit,
      @required this.price});

  @override
  List<Object> get props => [distance, distancePerUnit, price];

  @override
  String toString() => 'SubmitButtenPressed { distance: $distance, '
      'distancePerUnit: $distancePerUnit, '
      'price: $price}';
}

class ResetButtonPressed extends FuelEvent {
  @override
  String toString() {
    return 'ResetButtonPressed{}';
  }
}
