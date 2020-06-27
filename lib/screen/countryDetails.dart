import 'dart:math' as math;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'countrycases.dart';
import 'covid.dart';

class CountryDetails extends StatefulWidget {
  final Countries country;
  CountryDetails(this.country);
  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

List casess = new List<int>.generate(28, (i) => i + 1);

class _CountryDetailsState extends State<CountryDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CovidModel covidmod = CovidModel();
    updateUI(covidmod.getCovidChart(widget.country.slug));
  }

  void updateUI(dynamic covidata) async {
    await covidata.then((val) {
      setState(() {
        if (casess.length > 0) {
          casess.clear();
        }
        for (int i = 0; i < 28; i++) {
          casess.add(val[i + 1]['Cases'] - val[i]['Cases']);
        }

        print(casess);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Color(0xFF4c57C0),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF4c57C0),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.country.country.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: const EdgeInsets.only(right: 30.0),
                  child: new Container(
                    width: screenWidth,
                    padding: new EdgeInsets.all(60.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Total Confirmed',
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Color(0xFF7F87D2),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                widget.country.newConfirmed.toString(),
                                style: TextStyle(
                                  fontFamily: 'QuickSandBold',
                                  color: Color(0xFF4c57C0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  Text(
                                    'New Confirmed',
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Color(0xFF7F87D2),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    widget.country.confirmed.toString(),
                                    style: TextStyle(
                                      fontFamily: 'QuickSandBold',
                                      color: Color(0xFF4c57C0),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Total Recovered',
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Color(0xFF7F87D2),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    widget.country.totalrecovered.toString(),
                                    style: TextStyle(
                                      fontFamily: 'QuickSandBold',
                                      color: Color(0xFF4c57C0),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Total Deaths',
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Color(0xFF7F87D2),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    widget.country.toatldeath.toString(),
                                    style: TextStyle(
                                      fontFamily: 'QuickSandBold',
                                      color: Color(0xFF4c57C0),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    'New Death',
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      color: Color(0xFF7F87D2),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    widget.country.newdeaths.toString(),
                                    style: TextStyle(
                                      fontFamily: 'QuickSandBold',
                                      color: Color(0xFF4c57C0),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 15.0),
                child: Text(
                  'Case Growth Trend Within  Last 30 Days ',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Quicksand',
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.only(right: 25.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 300,
                    width: screenWidth,
                    child: charts.LineChart(_createSampleData(),
                        animate: true,
                        behaviors: [
                          new charts.PanAndZoomBehavior(),
                        ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<charts.Series<LinearSales, int>> _createSampleData() {
  final data = [
    new LinearSales(0, casess[0]),
    new LinearSales(2, casess[1]),
    new LinearSales(3, casess[2]),
    new LinearSales(4, casess[3]),
    new LinearSales(5, casess[4]),
    new LinearSales(6, casess[5]),
    new LinearSales(7, casess[6]),
    new LinearSales(8, casess[7]),
    new LinearSales(9, casess[8]),
    new LinearSales(10, casess[9]),
    new LinearSales(11, casess[10]),
    new LinearSales(12, casess[11]),
    new LinearSales(13, casess[12]),
    new LinearSales(14, casess[13]),
    new LinearSales(15, casess[14]),
    new LinearSales(16, casess[15]),
    new LinearSales(17, casess[16]),
    new LinearSales(18, casess[17]),
    new LinearSales(19, casess[18]),
    new LinearSales(20, casess[19]),
    new LinearSales(21, casess[20]),
    new LinearSales(22, casess[21]),
    new LinearSales(23, casess[22]),
    new LinearSales(24, casess[23]),
    new LinearSales(25, casess[24]),
    new LinearSales(26, casess[25]),
    new LinearSales(27, casess[26]),
    new LinearSales(28, casess[27]),
  ];

  return [
    new charts.Series<LinearSales, int>(
      id: 'Sales',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: data,
    )
  ];
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
