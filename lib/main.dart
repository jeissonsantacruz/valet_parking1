import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking1/aplicacion/paginas/home_page.dart';

import 'arquitectura/servicios/usuario_preferencias.dart';
import 'arquitectura/servicios/usuario_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final PreferenciasUsuario preferenciasUsuario = new PreferenciasUsuario();
  await preferenciasUsuario.initPrefs();
  Firebase.initializeApp().then((value) => 
  runApp(MyApp()));
  
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
 
  @override
  Widget build(BuildContext context) {
    return
        MultiProvider(
          providers: [
          ChangeNotifierProvider(create: (context) => ProvUsuario()),
        ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute:  '/homeVehiculos',
            navigatorKey: navigatorKey,
            routes: {
              '/homeVehiculos': (context) => HomePage()
            },
          ),
        );
  }




}