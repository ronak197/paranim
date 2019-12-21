import 'dart:math';
import 'package:flutter/material.dart';

class ParticleBlast extends StatefulWidget {
  @override
  _ParticleBlastState createState() => _ParticleBlastState();
}

class _ParticleBlastState extends State<ParticleBlast> with SingleTickerProviderStateMixin {

  double time = 0.0;
  double waveGap = 10.0;
  Animation<double> _animation ;
  AnimationController controller;

  List<double> velocity = [];
  List<double> angle = [];
  List<int> sides = [];
  List<int> colorIndex = [];

  void generateParticlesData(){
    velocity.clear();
    angle.clear();
    sides.clear();
    colorIndex.clear();
    for(int i=0; i<300; i+=1){
      velocity.insert(i,Random().nextDouble()*20);
      angle.insert(i,Random().nextDouble()*pi*2);
      sides.insert(i,Random().nextInt(4) + 3);
      colorIndex.insert(i,Random().nextInt(4));
    }
  }

  @override
  void initState() {
    super.initState();

    generateParticlesData();

    controller = AnimationController(
        duration: Duration(seconds: 2, milliseconds: 500),
        vsync: this
    )..addListener(() {
      setState(() {
        time = _animation.value;
      });
    });

    _animation = Tween(begin: 0.0, end: 35.0).animate(CurvedAnimation(
      curve: Curves.easeOutQuad,
      parent: controller
    ));



    generateParticlesData();

  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_animation.status == AnimationStatus.completed){
            controller.reset();
            controller.stop();
            generateParticlesData();
            controller.forward();
          } else {
            controller.forward();
          }
          },
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: ParticlePainter(
            time: time,
            sides: sides,
            colorIndex: colorIndex,
            angle: angle,
            velocity: velocity
          ),
        ),
      ),
    );
  }
}

Path getPolygonPath(int sides, Size size, int radius, {Offset shift = const Offset(0.0,0.0)}){
  var path = Path();
  List<Offset> points = [];
  double theta = 2*pi / sides;
  double x0 = size.width/2;
  double y0 = size.height/2;
  for (int i=0; i<sides; i+=1){
    points.add(Offset(x0-radius*sin(theta*i),y0+radius*cos(theta*i)) + shift);
  }

  path..addPolygon(points, true);
  return path;
}

class ParticlePainter extends CustomPainter {

  double time = 0;
  List<double> velocity = [];
  List<double> angle = [];
  List<int> sides = [];
  List<int> colorIndex = [];

  List<MaterialColor> colors = [
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.purple
  ];

  ParticlePainter({this.time, this.velocity, this.angle, this.sides, this.colorIndex});

  @override
  void paint(Canvas canvas, Size size) {
    for(int i=0; i<velocity.length; i+=1) {
      canvas.drawPath(
          getPolygonPath(sides[i], size, 4, shift: Offset(velocity[i]*time*cos(angle[i]), velocity[i]*time*sin(angle[i]))),
          Paint()..color = colors[colorIndex[i]]
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}

