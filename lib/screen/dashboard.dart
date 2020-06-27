import 'dart:collection';
import 'dart:convert';

import 'package:coviddashboard/networking.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nice_button/NiceButton.dart';
import '../indicator.dart';
import '../covid.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int touchedIndex;
  int totalConfirmed;
  int newConfirmed;
  int totalRecovered;
  int totalDeaths;
  int newDeaths;
  List _list = new List<int>.generate(186, (i) => i + 1);
  var name185;
  var name184;
  var name183;
  var name182;
  var name181;
  var details = new Map();
  var detail = new Map();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CovidModel covidmod = CovidModel();
    updateUI(covidmod.getCovidata());
  }

  void updateUI(dynamic covidata) async {
    await covidata.then((val) {
      setState(() {
        totalConfirmed = val['Global']['TotalConfirmed'];
        newConfirmed = val['Global']['NewConfirmed'];
        totalRecovered = val['Global']['TotalRecovered'];
        totalDeaths = val['Global']['TotalDeaths'];
        newDeaths = val['Global']['NewDeaths'];
        for (int i = 0; i < 186; i++) {
          details[val['Countries'][i]['Country']] =
              val['Countries'][i]['TotalConfirmed'];
        }
        var sortedKeys = details.keys.toList(growable: false)
          ..sort((k1, k2) => details[k1].compareTo(details[k2]));
        LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
            key: (k) => k, value: (k) => details[k]);
        _list = sortedMap.values.toList();
        name185 = sortedMap.keys
            .firstWhere((k) => sortedMap[k] == _list[185], orElse: () => null);
        name184 = sortedMap.keys
            .firstWhere((k) => sortedMap[k] == _list[184], orElse: () => null);
        name183 = sortedMap.keys
            .firstWhere((k) => sortedMap[k] == _list[183], orElse: () => null);
        name182 = sortedMap.keys
            .firstWhere((k) => sortedMap[k] == _list[182], orElse: () => null);
        name181 = sortedMap.keys
            .firstWhere((k) => sortedMap[k] == _list[181], orElse: () => null);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: screenHeight / 2.5,
            width: screenWidth,
            color: Color(0xFF4c57C0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total Confirmed Cases',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            color: Color(0xFF7F87D2),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Icon(
                          Icons.notifications,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '$totalConfirmed',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      '+ $newConfirmed today',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Color(0xFF81C599),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'Total Recovered',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          NiceButton(
                            width: 80,
                            elevation: 8.0,
                            radius: 52.0,
                            text: '$totalRecovered',
                            textColor: Color(0xFF4c57C0),
                            fontSize: 10.0,
                            background: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Total Deaths',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          NiceButton(
                            width: 80,
                            elevation: 8.0,
                            radius: 52.0,
                            text: '$totalDeaths',
                            textColor: Color(0xFF4c57C0),
                            fontSize: 10.0,
                            background: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'New Death',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          NiceButton(
                            width: 80,
                            elevation: 8.0,
                            radius: 52.0,
                            text: '$newDeaths',
                            textColor: Color(0xFF4c57C0),
                            fontSize: 10.0,
                            background: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {},
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 50.0, right: 15.0),
                          child: Text(
                            'Top 5 Countries With Highest Cases',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 1.3,
            child: Card(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse.touchInput
                                        is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  touchedIndex = -1;
                                } else {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                }
                              });
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections()),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Indicator(
                        color: Color(0xff0293ee),
                        text: '$name185',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xfff8b250),
                        text: '$name184',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xff845bef),
                        text: '$name183',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xff13d38e),
                        text: '$name182',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Colors.brown,
                        text: '$name181',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: _list[185].toDouble(),
            title: _list[185].toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: _list[184].toDouble(),
            title: _list[184].toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: _list[183].toDouble(),
            title: _list[183].toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: _list[182].toDouble(),
            title: _list[182].toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.brown,
            value: _list[181].toDouble(),
            title: _list[181].toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
