import 'package:flutfirebase/app/ui/utils/shared.dart';

class QueryError extends StatelessWidget {
  const QueryError({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Color primaryColor = Theme.of(context).primaryColor;
    return Center(
      child: Container(
        height: size.height * 0.26,
        // color: Colors.green[400],
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '[Erro ]: \n${message}',
                  style: TextStyle(color: Colors.red[300]),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: size.width / 2,
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(43),
                ),
                child: Icon(FontAwesomeIcons.userLock, color: primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
