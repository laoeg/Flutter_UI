import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnePageTwoTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateOnePageTwoTabBar();
  }
}

class StateOnePageTwoTabBar extends State<OnePageTwoTabBar> {
  int activePosition = 1;
  List<String> titlesOne = ["关注", "推荐"];
  int activePositionOne = 1;
  List<String> titlesTwo = [];
  int activePositionTwo = 0;
  PageController pageController = PageController(initialPage: 1);

  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 10; i++) {
      titlesTwo.add("标题${i}");
    }
    pageController.addListener(() {
      offset = pageController.offset;
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(offset==0){
      offset = MediaQuery.of(context).size.width;
    }
    // TODO: implement build
    return Listener(
      onPointerDown: (detail){

      },
      onPointerMove: (detail){

      },
      onPointerUp: (detail){

      },
      child: Column(
        children: [
          Container(
            height: 40,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: titlesOne.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 60,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(titlesOne[index]),
                  );
                }),
          ),
          Transform.translate(
            offset: Offset(offset, 0),
            child: Container(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: titlesTwo.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 60,
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(titlesTwo[index]),
                    );
                  }),
            ),),
          Expanded(
            child: PageView.builder(
                controller: pageController,
                itemCount: 11,
                onPageChanged: (position){
                  activePosition = position;
                  setState(() {

                  });
                },
                itemBuilder: (context, position) {
                  return Center(
                    child: Text("page${position}"),
                  );
                }),
          )
        ],
      ),
    );
  }
}
