import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsDetail extends StatefulWidget {
  final DocumentSnapshot post;
  NewsDetail({this.post});
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    Timestamp t = widget.post.data['dateCreated'];
    DateTime d = t.toDate();
    var newDt = DateFormat.yMMMEd().format(d);
    print(newDt.toString());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10.0),
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
                          color: Colors.white,
                        ),
                        backgroundColor: Color(0xFF4c57C0),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            widget.post.data['title'],
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'QuickSandBold',
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 320,
                    width: screenWidth,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        widget.post.data['imageLink'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Date Posted: $newDt',
                      style: TextStyle(
                          height: 2,
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: 'QuickSand',
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                    elevation: 10,
                    color: Colors.white,
                    child: Container(
                      width: screenWidth,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                widget.post.data['content'],
                                style: TextStyle(
                                    height: 2,
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'QuickSand',
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
