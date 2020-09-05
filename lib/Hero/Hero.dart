
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("第一个页面"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context,Animation animation,Animation secondAnimation){
                      return SeconedPage2();
                    }));
                  },
                  child: Hero(
                    tag: "container2",
                    child: Container(
                      color: Colors.blue,
                      width: 100,
                      height: 100,
                      child: Icon(
                          Icons.favorite
                      ),
                    ),
                  ),
                ),GestureDetector(
                  onTap: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context,Animation animation,Animation secondAnimation){
                      return SeconedPage1();
                    }));
                  },
                  child: Hero(
                    tag: "container1",
                    child: Container(
                      color: Colors.blue,
                      width: 100,
                      height: 100,
                      child: Icon(
                          Icons.collections
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context,Animation animation,Animation secondAnimation){
                      return SeconedPage();
                    }));
                  },
                  child: Hero(
                    tag: "container",
                    child: Container(
                      color: Colors.blue,
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.access_alarm
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}


class SeconedPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("第二个页面"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Hero(tag: "container", child: Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Icon(
                    Icons.access_alarm,
                  size: MediaQuery.of(context).size.width,
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}

class SeconedPage2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("第二个页面"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Hero(tag: "container2", child: Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Icon(
                  Icons.favorite,
                  size: MediaQuery.of(context).size.width,
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}

class SeconedPage1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("第二个页面"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Hero(tag: "container1", child: Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Icon(
                  Icons.collections,
                  size: MediaQuery.of(context).size.width,
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
