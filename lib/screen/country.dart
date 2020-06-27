import 'dart:async';
import 'dart:convert';

import 'package:coviddashboard/screen/countryDetails.dart';
import 'package:coviddashboard/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;

import '../countrycases.dart';

class Country extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  TextEditingController controller = new TextEditingController();
  Countries coaff;
  final debouncer = Debouncer(milliseconds: 1000);
  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    Services.ser.forEach((seriesDetail) {
      if (seriesDetail.country.toLowerCase().contains(text.toLowerCase())) {
        _searchResult.clear();
        _searchResult.add(seriesDetail);
      }
    });

    setState(() {});
  }

  circularProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF4c57C0),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 40),
                      child: Text(
                        'Stats By Country',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(25.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(15.0),
                            hintText: 'Filter by Country Name',
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black45,
                            )),
                        onChanged: (string) {
                          debouncer.run(() {
                            setState(() {});
                            if (_searchResult.length > 0) {
                              _searchResult.clear();
                            }
                            onSearchTextChanged(string);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: _searchResult.length != 0 || controller.text.isNotEmpty
                      ? new FutureBuilder(
                          future: Services.getCountries(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Container(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            } else {
                              return AnimationLimiter(
                                child: ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: _searchResult.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AnimationConfiguration.staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          CountryDetails(
                                                              _searchResult[
                                                                  index])));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 2.0,
                                                      blurRadius: 5.0,
                                                    )
                                                  ]),
                                              margin: EdgeInsets.all(2.0),
                                              child: Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            _searchResult[index]
                                                                .country,
                                                            style: TextStyle(
                                                                fontSize: 15.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontFamily:
                                                                    'Quicksand'),
                                                          ),
                                                          SizedBox(
                                                              height: 10.0),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            2.0,
                                                                        bottom:
                                                                            2.0),
                                                                child: Text(
                                                                  'Total Confirmed: ' +
                                                                      _searchResult[
                                                                              index]
                                                                          .newConfirmed
                                                                          .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontFamily:
                                                                        'Quicksand',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 20.0),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            2.0,
                                                                        bottom:
                                                                            2.0),
                                                                child: Text(
                                                                  'Total Deaths: ' +
                                                                      _searchResult[
                                                                              index]
                                                                          .toatldeath
                                                                          .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontFamily:
                                                                        'Quicksand',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15.0,
                                                              right: 10),
                                                      child: ClipOval(
                                                        child: Material(
                                                          color: Color(
                                                              0xFF4c57C0), // button color
                                                          child: InkWell(
                                                            splashColor: Color(
                                                                0xFF4c57C0), // inkwell color
                                                            child: SizedBox(
                                                                width: 35,
                                                                height: 35,
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            onTap: () {},
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                              );
                            }
                          })
                      : new FutureBuilder<List<Countries>>(
                          future: Services.getCountries(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error ${snapshot.error}');
                            }
                            if (snapshot.hasData) {
                              _searchResult.clear();
                              return AnimationLimiter(
                                child: ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AnimationConfiguration.staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          CountryDetails(
                                                              snapshot.data[
                                                                  index])));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 2.0,
                                                      blurRadius: 5.0,
                                                    )
                                                  ]),
                                              margin: EdgeInsets.all(2.0),
                                              child: Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            snapshot.data[index]
                                                                .country,
                                                            style: TextStyle(
                                                                fontSize: 15.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontFamily:
                                                                    'Quicksand'),
                                                          ),
                                                          SizedBox(
                                                              height: 10.0),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            2.0,
                                                                        bottom:
                                                                            2.0),
                                                                child: Text(
                                                                  'Total Confirmed: ' +
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .newConfirmed
                                                                          .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontFamily:
                                                                        'Quicksand',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 20.0),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            2.0,
                                                                        bottom:
                                                                            2.0),
                                                                child: Text(
                                                                  'Total Deaths: ' +
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .toatldeath
                                                                          .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontFamily:
                                                                        'Quicksand',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15.0,
                                                              right: 10.0),
                                                      child: ClipOval(
                                                        child: Material(
                                                          color: Color(
                                                              0xFF4c57C0), // button color
                                                          child: InkWell(
                                                            splashColor: Color(
                                                                0xFF4c57C0), // inkwell color
                                                            child: SizedBox(
                                                                width: 35,
                                                                height: 35,
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            onTap: () {},
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                              );
                            }
                            return circularProgress();
                          },
                        ),
                ),
              ),
            ],
          ),
        ));
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

List<Countries> _searchResult = [];
