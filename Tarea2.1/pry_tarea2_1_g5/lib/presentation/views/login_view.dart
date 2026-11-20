import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes/app_routes.dart';
import '../../theme/colores_app.dart';
import '../viewmodels/sesion_viewmodel.dart';
import '../widgets/fondo_encabezado.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formulario = GlobalKey<FormState>();
  final correo = TextEditingController();
  final contrasena = TextEditingController();
  bool mostrar = false;

  @override
  void dispose() {
    correo.dispose();
    contrasena.dispose();
    super.dispose();
  }

  Future<void> ingresar() async {
    if (!formulario.currentState!.validate()) return;
    final sesion = context.read<SesionViewModel>();
    final correcto = await sesion.ingresar(correo.text, contrasena.text);
    if (!mounted) return;
    if (correcto) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.inicio,
        (_) => false,
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(sesion.error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final sesion = context.watch<SesionViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 104,
              width: double.infinity,
              child: FondoEncabezado(),
            ),
            Expanded(
              child: ColoredBox(
                color: ColoresApp.fondoMenta,
                child: LayoutBuilder(
                  builder: (context, limites) => SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 430,
                          minHeight: limites.maxHeight > 40
                              ? limites.maxHeight - 40
                              : 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: ColoresApp.blanco,
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: ColoresApp.verdeSuave,
                                      ),
                                    ),
                                    child: Image.asset(
                                      'assets/espe.jpg',
                                      width: 150,
                                      height: 125,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Card(
                                  margin: EdgeInsets.zero,
                                  color: ColoresApp.blanco,
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Form(
                                      key: formulario,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Bienvenido/a',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium
                                                ?.copyWith(
                                                  color: ColoresApp.verdeOscuro,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Inicia sesión para acceder al sistema de incidencias',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: ColoresApp
                                                      .textoSecundario,
                                                ),
                                          ),
                                          const SizedBox(height: 24),
                                          TextFormField(
                                            controller: correo,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: const InputDecoration(
                                              labelText: 'Correo institucional',
                                              prefixIcon: Icon(
                                                Icons.email_outlined,
                                              ),
                                            ),
                                            validator: (v) =>
                                                v == null || v.trim().isEmpty
                                                ? 'Ingrese el correo'
                                                : null,
                                          ),
                                          const SizedBox(height: 14),
                                          TextFormField(
                                            controller: contrasena,
                                            obscureText: !mostrar,
                                            decoration: InputDecoration(
                                              labelText: 'Contraseña',
                                              prefixIcon: const Icon(
                                                Icons.lock_outline,
                                              ),
                                              suffixIcon: IconButton(
                                                onPressed: () => setState(
                                                  () => mostrar = !mostrar,
                                                ),
                                                icon: Icon(
                                                  mostrar
                                                      ? Icons
                                                            .visibility_off_outlined
                                                      : Icons
                                                            .visibility_outlined,
                                                ),
                                              ),
                                            ),
                                            validator: (v) =>
                                                v == null || v.isEmpty
                                                ? 'Ingrese la contraseña'
                                                : null,
                                          ),
                                          const SizedBox(height: 22),
                                          ElevatedButton.icon(
                                            onPressed: sesion.cargando
                                                ? null
                                                : ingresar,
                                            icon: const Icon(Icons.login),
                                            label: Text(
                                              sesion.cargando
                                                  ? 'Ingresando...'
                                                  : 'Ingresar',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: Column(
                                children: [
                                  Text(
                                    'Tu reporte, nuestra mejora',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: ColoresApp.verdeOscuro,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Sistema de Incidencias Universitarias',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: ColoresApp.textoSecundario,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
