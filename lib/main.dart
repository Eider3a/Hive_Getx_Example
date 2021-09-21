import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:learning_hive_app/src/models_db/user.dart';
import 'package:learning_hive_app/src/pages/home_page.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await  getApplicationDocumentsDirectory();
  //! Inicializo hive y le paso la ruta donde va a guardar.
  Hive.init(appDocDir.path.toString());
  //! Le paso a hive el adapter para el modelo.
  Hive.registerAdapter(UserAdapter());
  //! Creo las hive box. (son como las tablas)
  await Hive.openBox<User>('users');

  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hive DB',
      showSemanticsDebugger: false,
      home: HomePage()
    );
  }
}

//! Comando de hive para generar los adapters.
//! Se usa luego de crear el modelo y agregarle las anotaciones.
//!>> flutter packages pub run build_runner build