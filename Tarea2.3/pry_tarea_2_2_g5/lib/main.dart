import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tarea22/view/pantallas/detalle_pantalla.dart';
import 'package:tarea22/view/pantallas/mascotas_pantalla.dart';
import 'package:tarea22/view/pantallas/splash_pantalla.dart';
import 'package:tarea22/view/tema.dart';
import 'package:tarea22/view_model/mascota_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Solo vertical para que la pantalla de detalle siempre tenga espacio.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(
    ChangeNotifierProvider(
      create: (_) => MascotaViewmodel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adopción de mascotas',
      theme: ThemeData(
        fontFamily: Tema.letraTextos,
        colorScheme: ColorScheme.fromSeed(seedColor: Tema.verde),
        scaffoldBackgroundColor: Tema.crema,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPantalla(),
        '/mascotas': (context) => const MascotasPantalla(),
        '/detalle': (context) => const DetallePantalla(),
      },
    );
  }
}
