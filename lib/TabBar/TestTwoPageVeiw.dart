import 'package:flutter/cupertino.dart';

class TestTwoPageVeiw extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateTestTwoPageVeiw();
  }
}

class StateTestTwoPageVeiw extends State<TestTwoPageVeiw> {

  double moveDx = 0;
  List<Widget> pages = [FirstPage1(),SecondPage()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Listener(
      onPointerDown: (detail){
        print("aaaadown:"+detail.localPosition.dx.toString());
      },
      onPointerMove: (detail){
        print("aaaaaMove:"+detail.delta.dx.toString());
      },
      onPointerUp: (detail){
        print("aaaaUp:"+detail.localPosition.dx.toString());
      },
      child: PageView.builder(
//      physics: NeverScrollableScrollPhysics(),
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          }),
    );
  }
}

class FirstPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text("FirstPage"),
    );
  }
}

class SecondPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateSecondPage();
  }
}

class StateSecondPage extends State<SecondPage>{
  double moveDx = 0;
  int activePosition = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Listener(
      onPointerDown: (detail){
        print("bbbbbdown:"+detail.localPosition.dx.toString());
      },
      onPointerMove: (detail){
        print("bbbbbMove:"+detail.delta.dx.toString());
        moveDx = detail.delta.dx;
        setState(() {

        });
      },
      onPointerUp: (detail){
        print("bbbbbup:"+detail.localPosition.dx.toString());
      },
      child: PageView.builder(
          itemCount: 5,
          onPageChanged: (index){
            activePosition = index;
            setState(() {

            });
          },
          physics: activePosition==0&&moveDx>0?NeverScrollableScrollPhysics():null,
          itemBuilder: (context, index) {
            return Center(
              child: Text("MainPage${index}"),
            );
          }),
    );
  }
}
