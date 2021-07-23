import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  var app_controller = Get.find<AppController>();
  void _pushPage(String page) {
    Get.toNamed(page);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        // height: ,
        decoration: BoxDecoration(),
        child: Column(
          children: [
            Container(height: size.height * 0.3, color: Colors.amberAccent),
            Container(
              margin: EdgeInsets.only(top: kToolbarHeight, left: 8),
              child: RichText(
                  text: TextSpan(
                      text: 'E Ai \n',
                      style: TextStyle(fontSize: 18),
                      children: [
                    TextSpan(
                      text: '\nSeja Bem Vindo de Volta\n',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        // fontSize: 23,
                      ),
                    ),
                    TextSpan(
                        text: '\nEntre com sua conta google para usar',
                        style: TextStyle(fontSize: 8)),
                  ])),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      minimumSize: Size(double.infinity, 50)),
                  label: Text('Use seu email',
                      style: TextStyle(color: Colors.black)),
                  icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  // text: 'Registration',
                  onPressed: () {
                    print('LOgging ...');
                    app_controller.googleLogin();
                    print('Loged sucess');
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(text: ' Ja Tiveste aqui ?', children: [
                  TextSpan(
                      text: 'Entrar',
                      style: TextStyle(color: Colors.greenAccent))
                ]),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
