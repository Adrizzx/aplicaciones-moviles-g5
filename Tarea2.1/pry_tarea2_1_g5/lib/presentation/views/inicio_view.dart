import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes/app_routes.dart';
import '../../theme/colores_app.dart';
import '../viewmodels/sesion_viewmodel.dart';
import '../widgets/encabezado_app.dart';

class InicioView extends StatelessWidget {
  const InicioView({super.key});
  @override
  Widget build(BuildContext context) {
    final sesion = context.watch<SesionViewModel>();
    final usuario = sesion.usuarioActual;
    if (usuario == null) {
      return const Scaffold(
        body: Center(child: Text('Inicie sesión para continuar')),
      );
    }
    return Scaffold(
      appBar: EncabezadoApp(
        titulo: 'Incidencias universitarias',
        acciones: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<SesionViewModel>().salir();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (_) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.school,
                  size: 72,
                  color: ColoresApp.verdeOscuro,
                ),
                const SizedBox(height: 12),
                Text(
                  'Bienvenido, ${usuario.nombre}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  sesion.esAdministrador
                      ? 'Rol: Administrador'
                      : 'Rol: Usuario',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.formulario),
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Reportar incidencia'),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.incidencias),
                  icon: const Icon(Icons.visibility),
                  label: Text(
                    sesion.esAdministrador
                        ? 'Consultar todas las incidencias'
                        : 'Mis incidencias',
                  ),
                ),
                if (sesion.esAdministrador) ...[
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.incidencias,
                      arguments: true,
                    ),
                    icon: const Icon(Icons.build),
                    label: const Text('Gestionar incidencias'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
