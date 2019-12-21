import 'package:flutter/material.dart';

class WaterWave extends StatefulWidget {
  @override
  _WaterWaveState createState() => _WaterWaveState();
}

class _WaterWaveState extends State<WaterWave> with SingleTickerProviderStateMixin{

  double waveRadius = 0.0;
  double waveGap = 10.0;
  Animation<double> _animation ;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 1500),
        vsync: this
    );

    _animation = Tween(begin: 0.0, end: 10.0).animate(controller)
      ..addListener(() {
        setState(() {
          waveRadius = _animation.value;
        });
      });

    controller.forward();
    controller.repeat();

  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: PatternPainter(waveRadius: waveRadius),
      ),
    );
  }
}

class PatternPainter extends CustomPainter{

  double waveRadius = 0.0;
  PatternPainter({this.waveRadius});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    int nos = 0;
    while(nos <= 100) {
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), nos*10.0 + waveRadius, paint);
      nos+=1;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}