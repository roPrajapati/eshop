import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:online_store_fl_app/screens/e_shop_home_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('StoargeToken');
  
  runApp(EshopApp());
}

class EshopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final Box box = Hive.box('StoargeToken');
    print("User signed in: ${box.get('userToken')}");
    return GetMaterialApp(
      home: EshopHomePage()
    );
  }
}



