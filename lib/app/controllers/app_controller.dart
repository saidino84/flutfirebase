import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutfirebase/app/ui/global_widgets/error_widget.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppController extends GetxController {
  final googleSignIn = GoogleSignIn();
  late GoogleSignInAccount? _user;

  Stream get user_auth => FirebaseAuth.instance.authStateChanges();

  // este User 'e da classe FirebaseAUth
  late User? app_user = FirebaseAuth.instance.currentUser;

  User? get current_user => app_user;

  GoogleSignInAccount? get user => _user;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Get.defaultDialog(
        title: 'Erro no Login',
        content: AppDialogError(message: '[Erro ]: \n$e'),
      ); //Text('$e  [ GOOGLE PLAY SERVICE NOT AVAILABLE '));
      // AppDialogError(message: '[Erro ]: \n$e');
    }
    if (_user != null) {
      //DEpois do login ser bem sucedido vou pegar o as credencias do user logado
      app_user = FirebaseAuth.instance.currentUser!;
      Get.toNamed(AppRoutes.HOME);
    }
    update();
  }

  log_out_current_user() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        print('USER SE ENCONTRA NO APP $user_auth');
        await googleSignIn.disconnect();
        FirebaseAuth.instance.signOut();
        Get.toNamed(AppRoutes.AUTH);
      }
    } catch (err) {
      Get.snackbar('Falha no log out', '$err');
    }
    update();
    print('USER AUTH NOW :$user_auth');
  }
}
