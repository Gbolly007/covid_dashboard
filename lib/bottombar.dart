import 'package:coviddashboard/screen/country.dart';
import 'package:coviddashboard/screen/news.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'screen/dashboard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int currentPage;
  Color currentColor = Colors.deepPurple;
  Color inactiveColor = Colors.black;
  TabController tabBarController;
  List<Tabs> tabs = new List();
  final widgetOptions = [
    Dashboard(),
    Country(),
    News(),
  ];

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    tabs.add(Tabs(
      Icons.show_chart,
      "Dashbaord",
      Colors.deepPurple,
      getGradient(Colors.deepPurple),
    ));
    tabs.add(Tabs(Icons.public, "Country", Colors.deepPurple,
        getGradient(Colors.deepPurple)));
    tabs.add(Tabs(
        Icons.info, "News", Colors.deepPurple, getGradient(Colors.deepPurple)));
    tabBarController =
        new TabController(initialIndex: currentPage, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: widgetOptions[currentPage],
        bucket: bucket,
      ),
      bottomNavigationBar: CubertoBottomBar(
        inactiveIconColor: inactiveColor,
        tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND,
        selectedTab: currentPage,
        tabs: tabs
            .map((value) => TabData(
                iconData: value.icon,
                title: value.title,
                tabColor: value.color,
                tabGradient: value.gradient))
            .toList(),
        onTabChangedListener: (position, title, color) {
          setState(() {
            tabBarController.animateTo(position);
            currentPage = position;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }
}

final PageStorageBucket bucket = PageStorageBucket();

class Tabs {
  final IconData icon;
  final String title;
  final Color color;
  final Gradient gradient;

  Tabs(this.icon, this.title, this.color, this.gradient);
}

getGradient(Color color) {
  return LinearGradient(
      colors: [color.withOpacity(0.5), color.withOpacity(0.1)],
      stops: [0.0, 0.7]);
}
