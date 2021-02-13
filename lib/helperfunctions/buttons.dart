// import 'package:flutter/material.dart';
//
// class CustomIconPainter extends CustomPainter {
//   String pathString;
//   Color fillColor;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = fillColor
//       ..strokeWidth = 1
//       ..style = PaintingStyle.fill
//       ..strokeCap = StrokeCap.round;
//
//     canvas.drawPath(parseSvgPathData(pathString), paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
//
// class CircleButton extends StatelessWidget {
//   final Widget child;
//   final height;
//   final width;
//
//   final Function onTap;
//   CircleButton({this.height = 64, this.width = 64, this.onTap, this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: this.onTap,
//       child: Ink(
//         height: height,
//         width: width,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.pinkAccent.withOpacity(0.12),
//               blurRadius: 30,
//               spreadRadius: 0,
//               offset: Offset(0, 20),
//             ),
//           ],
//         ),
//         child: Center(
//           child: this.child,
//         ),
//       ),
//     );
//   }
// }
