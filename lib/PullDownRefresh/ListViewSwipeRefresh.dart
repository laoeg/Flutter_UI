import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PaintPullDownShadow.dart';

class ListViewSwiperRefresh extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateListViewSwiperRefresh();
  }
}

class StateListViewSwiperRefresh extends State<ListViewSwiperRefresh> with TickerProviderStateMixin{
  double maxHeight = 120;
  double dy = 0;
  double angle = 0;

  Animation<double> backAnimation;

  AnimationController backAnimationController;
  Animation<double> loadingAnimation;
  AnimationController loadingAnimationController;
  Animation<double> dismissAnimation;
  AnimationController dismissAnimationController;
  bool loading = false;
  ScrollController scrollController;
  bool absorbing = true;
  bool isTop = true;
  bool isBottm = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.maxScrollExtent <=
            scrollController.offset) {
          //滑动到底部
          isBottm = true;
        } else if (scrollController.position.minScrollExtent >=
            scrollController.offset) {
          //滑动到顶部
          isTop = true;
        } else {
          //其他
          isBottm = false;
          isTop = false;
        }
      });
    backAnimationController = new AnimationController(
        duration: Duration(milliseconds: 100), vsync: this)
      ..addStatusListener((statu) {
        if (statu == AnimationStatus.completed) {
          loadingAnimation = Tween<double>(begin: 0, end: 360)
              .animate(loadingAnimationController)
            ..addListener(() {
              angle = loadingAnimation.value;
              setState(() {});
            });
          loadingAnimationController.reset();
          loadingAnimationController.forward();
          // 模拟耗时操作
          new Timer(Duration(seconds: 1), () {
            dismissAnimationFun();
            loadingAnimationController.stop();
          });
        }
      });
    loadingAnimationController = new AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this)
      ..addStatusListener((statu) {
        if (statu == AnimationStatus.completed) {
          loadingAnimationController.reset();
          loadingAnimationController.forward();
        }
      });
    dismissAnimationController = new AnimationController(
        duration: Duration(milliseconds: 150), vsync: this)
      ..addStatusListener((statu) {
        if (statu == AnimationStatus.completed) {
          loading = false;
        }
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    backAnimationController.dispose();
    loadingAnimationController.dispose();
    dismissAnimationController.dispose();
  }

  // 加载完成的隐藏动画
  void dismissAnimationFun() {
    dismissAnimation =
    Tween<double>(begin: dy, end: 0).animate(dismissAnimationController)
      ..addListener(() {
        dy = dismissAnimation.value;
        setState(() {});
      });
    dismissAnimationController.reset();
    dismissAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("listview pull down refresh"),
      ),
      body:
      Listener(
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  top: -50 + dy,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    alignment: Alignment.center,
                    child: Transform.rotate(
                      angle: loading
                          ? -angle
                          : ((dy > 50 && dy < 140)
                          ? (dy - 50) * 4 * (pi / 180)
                          : 0),
                      //修改下面的图标和图片即可更换效果
                      child: loading
                          ? Icon(
                        Icons.refresh,
                        size: 40,
                        color: Colors.grey,
                      )
                          : Image.asset(
                        "assets/images/jiantou.png",
                        color: Colors.grey,
                      ),
                    ),
                  )),
              // 下拉阴影
              Positioned(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.transparent,
                    child: CustomPaint(
                      painter: PullDownShadow(MediaQuery.of(context).size.width / 2,
                          dy - 60, MediaQuery.of(context).size.width),
                    ),
                  )),
              Positioned(
                  top: -50 + dy,
                  child: Container(
                    padding: EdgeInsets.only(top: 50),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 50,
                    alignment: Alignment.center,
                    //这里将"ListView"替换成你想要下拉刷新的widget即可
                    child: ListView.builder(
                        itemCount: 100,
                        controller: scrollController,
                        itemBuilder: (BuildContext context, int position) {
                          return Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: Text("List view Swiper Refresh ${position}"),
                          );
                        }),
                  )),
            ],
          ),
        ),
        onPointerDown: (detail) {
          print("onVerticalDragStart----");
          if (loading) {
            return;
          }
          if(!isTop){
            return;
          }
          dy = 0;
        },
        onPointerMove: (detail) {
          if (loading) {
            return;
          }
          if(!isTop){
            return;
          }
          if (dy >= 150) {
//            dy = maxHeight;
            // 设置阻尼系数，相当于摩擦力变大
            if (dy >= 250) {
              // 阻尼系数3
              dy += detail.delta.dy / 3;
            } else {
              // 阻尼系数1.5
              dy += detail.delta.dy / 1.5;
            }
          } else {
            dy += detail.delta.dy;
          }
          setState(() {});
        },
        onPointerUp: (detail) {
          if (loading) {
            return;
          }
          if(!isTop){
            return;
          }
          print("end:" + dy.toString());
          if (dy >= 120) {
            backAnimation = Tween<double>(begin: dy, end: 60)
                .animate(backAnimationController)
              ..addListener(() {
                dy = backAnimation.value;
                setState(() {});
              });
            backAnimationController.reset();
            backAnimationController.forward();
            loading = true;
          } else {
            dismissAnimationFun();
          }
//          dy = 0;
        },
      )
    );
  }
}
