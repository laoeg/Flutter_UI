import 'package:flutter/material.dart';
import 'package:flutter_ui/3D_rotate_page.dart';
import 'package:flutter_ui/Hero/Hero.dart';
import 'package:flutter_ui/List/SwipeItemList.dart';
import 'package:flutter_ui/PullDownRefresh/PullDownRefresh.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: "UI Demo",),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List data = [];
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data.add(DataEntity("3D rotate page","页面根据手势，触发页面3D旋转动画",TransformDemo()));
    data.add(DataEntity("Hero", "共享元素动画",FirstPage()));
    data.add(DataEntity("List", "List swipe item",SwipeItemList()));
    data.add(DataEntity("Refresh", "Pull down refresh",PullDownRefresh()));
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: data.length,
          itemBuilder: (BuildContext context,int position){
        return InkWell(
          onTap: (){
            print("点击了：$position");
            Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context,Animation animation,Animation secondAnimation){
              return data[position].goto;
            }));
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text(data[position].name),
                      SizedBox(height: 10,),
                      Text(data[position].desc),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class DataEntity{
  final String name;
  final String desc;
  final Widget goto;

  DataEntity(this.name,this.desc,this.goto);
}