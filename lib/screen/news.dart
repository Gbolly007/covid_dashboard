import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

import 'newsDetail.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  Firestore firestore = Firestore.instance;
  List<DocumentSnapshot> _newsItem = [];
  bool _loadingnews = true;
  int perpage = 4;
  DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMorePost = false;
  bool _morePostAvailable = true;
  Future getPosts() async {
    Query q = firestore.collection('posts').orderBy('title').limit(perpage);

    setState(() {
      _loadingnews = true;
    });

    QuerySnapshot querySnapshot = await q.getDocuments();
    _newsItem = querySnapshot.documents;
    _lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
    setState(() {
      _loadingnews = false;
    });
  }

  getMorePost() async {
    print('getMoreProducts called');
    if (_morePostAvailable == false) {
      return;
    }
    if (_gettingMorePost == true) {
      return;
    }
    _gettingMorePost = true;
    Query q = firestore
        .collection('posts')
        .orderBy('title')
        .startAfter([_lastDocument.data['title']]).limit(perpage);

    QuerySnapshot querySnapshot = await q.getDocuments();
    if (querySnapshot.documents.length < perpage) {
      _morePostAvailable = false;
    }
    _lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
    _newsItem.addAll(querySnapshot.documents);
    setState(() {});
    _gettingMorePost = false;
  }

  navigateToDetailPage(DocumentSnapshot post) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NewsDetail(post: post);
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if (maxScroll - currentScroll <= delta) {
        getMorePost();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    BorderRadiusGeometry radius = BorderRadius.only(
      bottomLeft: Radius.circular(24.0),
      bottomRight: Radius.circular(24.0),
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    PageController controller = PageController(
      viewportFraction: 1,
      initialPage: 1,
    );
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: screenWidth,
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
                    padding: const EdgeInsets.only(left: 15.0, top: 30),
                    child: Text(
                      'Covid Related News',
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
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
                flex: 3,
                child: _loadingnews == true
                    ? Container(
                        child: ListTileShimmer(
                          // Step 1: set hasCustomColors property to try
                          hasCustomColors: true,
                          // Step 2: give 3 colors to colors property
                        ),
                      )
                    : Container(
                        child: _newsItem.length == 0
                            ? Center(
                                child: Text('No news item'),
                              )
                            : ListView.builder(
                                controller: _scrollController,
                                itemCount: _newsItem.length,
                                itemBuilder: (_, index) {
                                  return Column(
                                    children: <Widget>[
//                                      Card(
//                                          elevation: 10,
//                                          shape: RoundedRectangleBorder(
//                                            borderRadius:
//                                                BorderRadius.circular(20.0),
//                                          ),
//                                          margin: const EdgeInsets.only(
//                                              right: 10.0, left: 10, top: 10),
//                                          child: InkWell(
//                                            splashColor:
//                                                Colors.blue.withAlpha(30),
//                                            onTap: () {
//                                              navigateToDetailPage(
//                                                  _newsItem[index]);
//                                            },
//                                            child: Container(
//                                              height: 200,
//                                              width: screenWidth,
//                                              child: ClipRRect(
//                                                borderRadius:
//                                                    BorderRadius.circular(15.0),
//                                                child: Image.network(
//                                                  _newsItem[index]
//                                                      .data['imageLink'],
//                                                  fit: BoxFit.cover,
//                                                ),
//                                              ),
//                                            ),
//                                          )),
//                                      Card(
//                                        margin: EdgeInsets.only(
//                                            left: 10, right: 10, top: 5),
//                                        elevation: 10,
//                                        color: Color(0xFF7F87D2),
//                                        child: InkWell(
//                                          splashColor:
//                                              Colors.blue.withAlpha(30),
//                                          onTap: () {
//                                            navigateToDetailPage(
//                                                _newsItem[index]);
//                                          },
//                                          child: Container(
//                                            width: screenWidth,
//                                            child: Padding(
//                                              padding: EdgeInsets.all(12.0),
//                                              child: Column(
//                                                children: <Widget>[
//                                                  Padding(
//                                                    padding:
//                                                        const EdgeInsets.only(
//                                                            left: 5.0,
//                                                            right: 5.0),
//                                                    child: Text(
//                                                      _newsItem[index]
//                                                          .data['title'],
//                                                      style: TextStyle(
//                                                          fontSize: 11,
//                                                          color: Colors.white,
//                                                          fontFamily:
//                                                              'QuickSand',
//                                                          fontWeight:
//                                                              FontWeight.w800),
//                                                    ),
//                                                  ),
//                                                ],
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//                                      ),
                                      Container(
                                        width: screenWidth,
                                        margin: EdgeInsets.only(
                                            left: 30, right: 30, bottom: 10),
                                        height: 250,
                                        child: PageView(
                                          controller: controller,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                navigateToDetailPage(
                                                    _newsItem[index]);
                                              },
                                              child: Container(
                                                child: Stack(
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      borderRadius: radius,
                                                      child: Image.network(
                                                        _newsItem[index]
                                                            .data['imageLink'],
                                                        fit: BoxFit.cover,
                                                        height: 250,
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          24.0)),
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: <Color>[
                                                                Colors
                                                                    .transparent,
                                                                Colors.black,
                                                              ])),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            _newsItem[index]
                                                                .data['title'],
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'QuickSand',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                      )),
          ],
        ),
      ),
    ));
  }
}
