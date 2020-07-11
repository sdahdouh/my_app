import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/FuelBloc.dart';
import 'package:flutter_counter/FuelState.dart';

import 'FuelEvent.dart';

void main() {
  runApp(FuelApp());
}

class FuelApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Cost Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  String result = '';
  final double _formDistance = 5.0;
  final _currencies = ['Euro', 'Yen', 'Dollars'];
  String _currency = 'Dollars';
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FuelBloc _fuelBloc = FuelBloc();

    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('FuelCalc'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: TextField(
                  controller: distanceController,
                  decoration: InputDecoration(
                      hintText: 'e.g. 124',
                      labelText: 'Distance',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  keyboardType: TextInputType.number,
                )),
            Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: TextField(
                  controller: avgController,
                  decoration: InputDecoration(
                      hintText: 'e.g. 17',
                      labelText: 'Distance per unit',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  keyboardType: TextInputType.number,
                )),
            Padding(
              padding:
                  EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                        hintText: 'e.g. 1.65',
                        labelText: 'Price',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    keyboardType: TextInputType.number,
                  )),
                  Container(
                    width: _formDistance * 5,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currency,
                        onChanged: (String value) {
                          _onDropDownChanged(value);
                        }),
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.5, right: 3),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        _fuelBloc.add(SubmitButtonPressed(
                            price: priceController.text,
                            distance: distanceController.text,
                            distancePerUnit: avgController.text));
                      },
                      child: Text(
                        'Submit',
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 3, right: 0.5),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorLight,
                    textColor: Theme.of(context).primaryColorDark,
                    onPressed: () {
                      _fuelBloc.add(ResetButtonPressed());
                    },
                    child: Text(
                      'Reset',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ))
              ],
            ),
            BlocConsumer(
              bloc: _fuelBloc,
              builder: (BuildContext context, state) {
                if (state is FuelInputSuccess) {
                  return Text('Your trip will cost ${state.result.toString()} ${_currency}');
                } else if (state is FuelInputError) {
                  return Text(state.error);
                } else {
                  return Container();
                }
              },
              listener: (BuildContext context, state) {
                if (state is FuelInputReset) {
                  reset();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void reset() {
    distanceController.clear();
    avgController.clear();
    priceController.clear();
  }


  _onDropDownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }
}
