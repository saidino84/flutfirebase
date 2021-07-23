import 'package:flutfirebase/app/ui/utils/shared.dart';

class HomeTopCustomPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var x = size.width; //,
    var y = size.height;
    var controllPoint = Offset(x, y);
    path.lineTo(0, y * 0.5);
    // path.lineTo(x * 0.5 / 2, y * 0.7);
    // path.lineTo((x / 2) / 2, y * 0.7);
    // path.lineTo((x / 2) / 2, y);
    // path.lineTo((x * 0.7), y);
    // path.lineTo(x * 0.7, y * 0.7);
    // path.lineTo(x, y * 0.7);

    path.quadraticBezierTo(x * 0.7, y, x, y * 0.5);
    path.lineTo(x, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
