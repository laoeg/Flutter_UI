import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
///用贝塞尔二阶曲线绘制下拉的阴影

class PullDownShadow extends CustomPainter {

  double _centerX;
  double _centerY;
  double _screenWidth;


  PullDownShadow(this._centerX, this._centerY,this._screenWidth);

  Paint _paint = Paint()
    ..color = Colors.blueGrey
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..strokeWidth = 10;
  Path _path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    _path.moveTo(0, 0);
    _path.quadraticBezierTo(_centerX, _centerY, _screenWidth, 0);
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
