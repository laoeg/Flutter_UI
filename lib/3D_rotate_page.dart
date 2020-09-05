import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 根据手指触摸屏幕，旋转页面动画

class TransformDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TransformDemoState();
  }
}

class TransformDemoState extends State<TransformDemo>{

  double _rotateX =.0;
  double _rotateY = .0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Transform(transform: Matrix4.identity()
      ..setEntry(3,2,0.001)
      ..rotateX(_rotateX)
      ..rotateY(_rotateY),
      alignment: Alignment.center,
      child: Scaffold(
        appBar: AppBar(
          title: Text("3D 变换Demo"),
        ),
        body: GestureDetector(
          onPanUpdate: (detail){
            print("$detail");
            setState(() {
              _rotateX += detail.delta.dy * .01;
              _rotateY += detail.delta.dx * -.01;
            });
          },
          child: Container(
            alignment: Alignment.center,
            color: Colors.white,
            child:  Text("3D 变换Demo"),
          ),
        ),
      ),);
  }
}