

import 'package:flutter/material.dart';

class DrawButton extends StatelessWidget {

    final Color? btnColor;
    final Color? btnColorRadius;
    final Color? btnColorTopBlik;
    final Color? btnColorBotBlik;

  DrawButton({Key? key, required this.btnColor, required this.btnColorRadius, required this.btnColorTopBlik, required this.btnColorBotBlik}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100.0.toDouble(), 100.0.toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
      painter: RPSCustomPainter(),
    );
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.color = Color(0x1fabfa).withOpacity(1.0);
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.4, size.height * 0.33), width: size.width * 1, height: size.height * 0.85), paint0fill);

    Paint paint0stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08;
    paint0stroke.color = Color(0x3cc3f8).withOpacity(1.0);
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.4, size.height * 0.33), width: size.width * 0.90, height: size.height * 0.75), paint0stroke);

    Path pathtopblik = Path();
    pathtopblik.moveTo(size.width * 0.5, size.height * 0.1);
    pathtopblik.cubicTo(size.width * 0.5, size.height * 0.1, size.width * 0.85, size.height * 0.17, size.width * 0.69, size.height * 0.45);
    pathtopblik.cubicTo(size.width * 0.69, size.height * 0.45, size.width * 0.78, size.height * 0.23, size.width * 0.5, size.height * 0.1);

    Paint paint1stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint1stroke.color = Color(0x7cdaf3).withOpacity(1.0);
    canvas.drawPath(pathtopblik, paint1stroke);

    Paint paint1fill = Paint()..style = PaintingStyle.fill;
    paint1fill.color = Color(0x3cc3f8).withOpacity(1.0);
    canvas.drawPath(pathtopblik, paint1fill);

    Path pathbottonblik = Path();
    pathbottonblik.moveTo(size.width * 0.07, size.height * 0.3);
    pathbottonblik.cubicTo(size.width * 0.07, size.height * 0.3, size.width * 0.06, size.height * 0.63, size.width * 0.4, size.height * 0.6);
    pathbottonblik.cubicTo(size.width * 0.4, size.height * 0.6, size.width * 0.2, size.height * 0.6, size.width * 0.07, size.height * 0.3);

    Paint paint2stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint2stroke.color = Color(0x07a1dc).withOpacity(1.0);
    canvas.drawPath(pathbottonblik, paint2stroke);

    Paint paint2fill = Paint()..style = PaintingStyle.fill;
    paint2fill.color = Color(0x07a1dc).withOpacity(1.0);
    canvas.drawPath(pathbottonblik, paint2fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
