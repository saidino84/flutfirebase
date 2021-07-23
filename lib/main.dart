import 'package:firebase_core/firebase_core.dart';

import 'app/ui/utils/shared.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Firebase App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.grey[900],

        // brightness: Brightness.dark,
      ),
      getPages: AppPages.app_pages,
      initialRoute: AppRoutes.AUTH,
    );
  }
}
