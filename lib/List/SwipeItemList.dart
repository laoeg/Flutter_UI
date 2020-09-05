
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 可以左右滑动的list列表项
/// 1。左右滑动，显示删除按钮
/// 2。点击其他item，前一个item回弹（快速滑动失效，不知道为啥）
/// 3。删除item删除动画

class SwipeItemList extends StatefulWidget{

  @override
  State<SwipeItemList> createState() {
    // TODO: implement createState
    return StateSwipeItemList();
  }
}


class StateSwipeItemList extends State<SwipeItemList> with TickerProviderStateMixin{

  List data = [];
  double dx = 0;
  double lastDx = 0;
  double deleteItemHeight = 0;

  Animation<double> animation;
  Animation<double> backAnimation;
  Animation<double> deleteAnimation;
  AnimationController deleteController;
  AnimationController backController;
  AnimationController controller;
  int currentPosition;
  int lastPosition;
  int deletePosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<40;i++){
      data.add("${i} item value,list swipe view");
    }
    controller = new AnimationController(duration: Duration(milliseconds: 100),vsync: this);
    controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
//        print("cLastDx:"+dx.toString());
//        controller.dispose();
      }
    });

    backController = new AnimationController(duration: Duration(milliseconds: 300),vsync: this);
    backController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
//        controller.dispose();
      }
    });

    deleteController = new AnimationController(duration: Duration(milliseconds: 200),vsync: this);
    deleteController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        currentPosition = lastPosition = -1;
        data.removeAt(deletePosition);
        deletePosition = -1;
        setState(() {

        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("swipe list item",style: TextStyle(fontSize: 18,decoration: TextDecoration.none),),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context,int position){
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragStart: (detail){
                if(currentPosition != position){
                  currentPosition = position;
                  print("lastDx:"+lastDx.toString());
                  backAnimation = Tween<double>(begin: lastDx,end: 0).animate(backController)
                  ..addListener(() {
                    lastDx = backAnimation.value;
//                    print(lastDx);
                    setState(() {

                    });
                  });
                  backController.reset();
                  backController.forward();
                  dx = 0;
                  setState(() {

                  });
                }
              },
              onHorizontalDragUpdate: (detail){
//                print(detail.delta.dx);
                if(dx ==0 && detail.delta.dx>0){
                  return;
                }
                dx  += detail.delta.dx;
                setState(() {

                });
//                print("dx"+dx.toString());
              },
              onHorizontalDragEnd: (detail){
                print("onHorizontalDragEnd");
                print("dx"+dx.abs().toString());
                lastPosition = position;
                if(dx.abs()>60){
                  lastDx = -120;
                  print("aaaaaa:"+lastDx.toString());
                  animation = Tween<double>(begin: dx,end: -120).animate(controller)
                      ..addListener(() {
                        dx = animation.value;
                        setState(() {

                        });
                      });
                }else{
                  lastDx =0;
                  print("aaaaaa:"+lastDx.toString());
                  animation = Tween<double>(begin: dx,end: 0).animate(controller)
                    ..addListener(() {
                      dx = animation.value;
                      setState(() {

                      });
                    });
                }
                controller.reset();
                controller.forward();
              },
              child: currentPosition == position?
              Stack(
                children: [
                  Transform.translate(
                    offset: Offset(dx,0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: deletePosition== position?deleteItemHeight:50,
                      width: MediaQuery.of(context).size.width,
                      child: deletePosition==position?SizedBox():Text(data[position]),
                    ),),
                  Positioned(
                      right: 0,
                      child: Material(
                        color: Colors.white,
                        child: Ink(
                          child: InkWell(
                            onTap: (){
                              deletePosition = position;
                              // 这可以分两步，先红色背景拉长，在高度变小，我这里直接一起执行了
                              deleteAnimation = Tween<double>(begin: 50,end: 0).animate(deleteController)..addListener(() {
                                deleteItemHeight = deleteAnimation.value;
                                // 红色背景动画
//                                dx = MediaQuery.of(context).size.width*(50-deleteItemHeight)/50;
                                print("deleteItemHeight:"+deleteItemHeight.toString());
                                setState(() {

                                });
                              });
                              deleteController.reset();
                              deleteController.forward();
                            },
                            child: Container(
                                height: deletePosition== position?deleteItemHeight:50,
                                color: Colors.red,
                                alignment: Alignment.center,
                                width: dx.abs(),
                                child: Opacity(
                                  opacity: (50>dx.abs()&& dx.abs()>30)?((dx.abs()-30).abs()/20):dx.abs()<=30?0:1,
                                  child: deletePosition == position?SizedBox():Text("删除",style: TextStyle(color: Colors.white)),)
                            ),
                          ),
                        ),
                      )),
                ],
              ):lastPosition == position?Stack(
                children: [
                  Transform.translate(
                    offset: Offset(lastDx,0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: deletePosition== position?deleteItemHeight:50,
                      width: MediaQuery.of(context).size.width,
                      child: Text(data[position]),
                    ),),
                  Positioned(
                      right: 0,
                      child: Container(
                          height: 50,
                          color: Colors.red,
                          alignment: Alignment.center,
                          width: lastDx.abs(),
                          child: Opacity(
                            opacity: (50>lastDx.abs()&& lastDx.abs()>30)?((lastDx.abs()-30).abs()/20):lastDx.abs()<=30?0:1,
                            child: Text("删除",style: TextStyle(color: Colors.white)),)
                      )),
                ],
              ):Container(
                alignment: Alignment.centerLeft,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Text(data[position]),
              ),
            );
          }),
    );
  }
}