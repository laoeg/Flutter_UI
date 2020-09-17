import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateScrollTabBar();
  }
}

class StateScrollTabBar extends State<ScrollTabBar> {
  List<String> itemBarText = [];

  PageController pageController = PageController(keepPage: false,viewportFraction: .2,initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 10; i++) {
      itemBarText.add("标题${i}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TabBar",
          style: TextStyle(decoration: TextDecoration.none),
        ),
      ),
      body: Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
            controller: pageController,
            itemCount: itemBarText.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: 100,
                height: 40,
                child: Text(itemBarText[index]),
              );
            }),
      ),
    );
  }
}
