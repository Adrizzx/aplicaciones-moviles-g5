import 'package:flutter/material.dart';
import 'package:tarea22/view/tema.dart';
import 'package:tarea22/view/widgets/boton_pildora.dart';

class SplashPantalla extends StatefulWidget {
  const SplashPantalla({super.key});

  @override
  State<SplashPantalla> createState() => _SplashPantallaState();
}

class _SplashPantallaState extends State<SplashPantalla>
    with SingleTickerProviderStateMixin {
  late final AnimationController controlador;
  late final Animation<double> animacion;

  @override
  void initState() {
    super.initState();
    controlador = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animacion = CurvedAnimation(parent: controlador, curve: Curves.easeOutBack);
    controlador.forward();
  }

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: Tema.fondo),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/mascotas/doodles.png', fit: BoxFit.cover),
            SafeArea(
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: controlador,
                  curve: Curves.easeIn,
                ),
                child: ScaleTransition(
                  scale: animacion,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Patitas',
                          textAlign: TextAlign.center,
                          style: Tema.logo.copyWith(fontSize: 72),
                        ),
                        const Text(
                          'Un hogar para cada mascota 💚',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Tema.texto),
                        ),
                        const SizedBox(height: 30),
                        Flexible(
                          child: Image.asset('assets/mascotas/grupo.png'),
                        ),
                        const SizedBox(height: 30),
                        BotonPildora(
                          texto: 'Conoce a las mascotas',
                          alPresionar: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/mascotas',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
