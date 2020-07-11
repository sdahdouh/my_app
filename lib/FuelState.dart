class FuelState {
  const FuelState();

  @override
  List<Object> get props => [];
}

class FuelInputSuccess extends FuelState {
  final double result;

  const FuelInputSuccess(this.result);

  @override
  List<Object> get props => [result];

  @override
  String toString() {
    return 'FuelInputSuccess{result: $result}';
  }
}

class FuelInputReset extends FuelState {
  @override
  String toString() {
    return 'FuelInputReset{}';
  }
}

class FuelInputError extends FuelState {
  final String error;

  const FuelInputError({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FuelInput { error: $error }';
}
