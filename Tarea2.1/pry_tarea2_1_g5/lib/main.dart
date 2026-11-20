import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasources/incidencia_api.dart';
import 'data/datasources/usuario_api.dart';
import 'data/datasources/area_responsable_api.dart';
import 'data/repositories/incidencia_repository_impl.dart';
import 'data/repositories/usuario_repository_impl.dart';
import 'data/repositories/area_responsable_repository_impl.dart';
import 'domain/usecases/obtener_incidencias.dart';
import 'domain/usecases/crear_incidencia.dart';
import 'domain/usecases/actualizar_incidencia.dart';
import 'domain/usecases/obtener_usuarios.dart';
import 'domain/usecases/obtener_area_responsables.dart';
import 'domain/usecases/iniciar_sesion.dart';
import 'presentation/viewmodels/incidencia_viewmodel.dart';
import 'presentation/viewmodels/sesion_viewmodel.dart';
import 'presentation/views/login_view.dart';
import 'presentation/views/inicio_view.dart';
import 'presentation/views/formulario_incidencia_view.dart';
import 'presentation/views/incidencias_view.dart';
import 'presentation/views/detalle_incidencia_view.dart';
import 'presentation/views/gestionar_incidencia_view.dart';
import 'routes/app_routes.dart';
import 'theme/tema_app.dart';

void main() {
  final incidenciaRepository = IncidenciaRepositoryImpl(IncidenciaApi());
  final usuarioRepository = UsuarioRepositoryImpl(UsuarioApi());
  final areaRepository = AreaResponsableRepositoryImpl(AreaResponsableApi());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SesionViewModel(IniciarSesion(usuarioRepository))),
    ChangeNotifierProvider(create: (_) => IncidenciaViewModel(
      ObtenerIncidencias(incidenciaRepository), CrearIncidencia(incidenciaRepository),
      ActualizarIncidencia(incidenciaRepository), ObtenerUsuarios(usuarioRepository),
      ObtenerAreaResponsables(areaRepository))),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Incidencias universitarias', debugShowCheckedModeBanner: false,
    theme: TemaApp.claro,
    initialRoute: AppRoutes.login,
    onGenerateRoute: (settings) {
      final sesion = context.read<SesionViewModel>();
      final protegida = settings.name != AppRoutes.login;
      if (protegida && !sesion.estaAutenticado) {
        return MaterialPageRoute(builder: (_) => const LoginView());
      }
      if (settings.name == AppRoutes.gestionar && !sesion.esAdministrador) {
        return MaterialPageRoute(builder: (_) => const InicioView());
      }
      final Widget pagina = switch (settings.name) {
        AppRoutes.login => const LoginView(),
        AppRoutes.inicio => const InicioView(),
        AppRoutes.formulario => const FormularioIncidenciaView(),
        AppRoutes.incidencias => const IncidenciasView(),
        AppRoutes.detalle => const DetalleIncidenciaView(),
        AppRoutes.gestionar => const GestionarIncidenciaView(),
        _ => const LoginView(),
      };
      return MaterialPageRoute(builder: (_) => pagina, settings: settings);
    },
  );
}
