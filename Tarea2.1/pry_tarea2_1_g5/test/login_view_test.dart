import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pry_tarea2_1_g5/domain/entities/usuario.dart';
import 'package:pry_tarea2_1_g5/domain/repositories/usuario_repository.dart';
import 'package:pry_tarea2_1_g5/domain/usecases/iniciar_sesion.dart';
import 'package:pry_tarea2_1_g5/presentation/viewmodels/sesion_viewmodel.dart';
import 'package:pry_tarea2_1_g5/presentation/views/login_view.dart';
import 'package:pry_tarea2_1_g5/presentation/widgets/fondo_encabezado.dart';
import 'package:pry_tarea2_1_g5/routes/app_routes.dart';
import 'package:pry_tarea2_1_g5/theme/colores_app.dart';

class RepositorioUsuariosLogin implements UsuarioRepository {
  final String rol;
  RepositorioUsuariosLogin(this.rol);

  @override
  Future<List<Usuario>> obtenerUsuarios() async => [];

  @override
  Future<Usuario?> iniciarSesion(String correo, String contrasena) async {
    if (correo != 'usuario@espe.edu.ec' || contrasena != 'clave') return null;
    return Usuario(
      id: '1',
      nombre: 'Usuario',
      correo: correo,
      tipo: 'Estudiante',
      rol: rol,
    );
  }
}

void main() {
  for (final rol in ['usuario', 'administrador']) {
    testWidgets('login muestra el logo y conserva el acceso de $rol', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 480);
      tester.view.devicePixelRatio = 1;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
        tester.view.resetViewInsets();
      });
      final sesion = SesionViewModel(
        IniciarSesion(RepositorioUsuariosLogin(rol)),
      );
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: sesion,
          child: MaterialApp(
            home: const LoginView(),
            routes: {
              AppRoutes.inicio: (_) => const Scaffold(body: Text('Inicio')),
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      final logo = tester.widget<Image>(find.byType(Image));
      expect((logo.image as AssetImage).assetName, 'assets/espe.jpg');
      expect(logo.fit, BoxFit.contain);
      final contenedorLogo = tester.widget<Container>(
        find
            .ancestor(of: find.byType(Image), matching: find.byType(Container))
            .first,
      );
      expect(
        (contenedorLogo.decoration as BoxDecoration).color,
        ColoresApp.blanco,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is ColoredBox && widget.color == ColoresApp.fondoMenta,
        ),
        findsOneWidget,
      );
      expect(
        find.ancestor(
          of: find.text('Bienvenido/a'),
          matching: find.byType(Card),
        ),
        findsOneWidget,
      );
      expect(find.byType(FondoEncabezado), findsOneWidget);
      expect(tester.getSize(find.byType(FondoEncabezado)).height, 104);
      expect(
        tester.getTopLeft(find.byType(Image)).dy -
            tester.getBottomLeft(find.byType(FondoEncabezado)).dy,
        lessThan(45),
      );
      expect(find.byType(AppBar), findsNothing);
      expect(find.byType(BackButton), findsNothing);
      expect(find.text('Bienvenido/a'), findsOneWidget);
      expect(find.text('Tu reporte, nuestra mejora'), findsOneWidget);
      expect(
        find.text('Sistema de Incidencias Universitarias'),
        findsOneWidget,
      );
      expect(
        find.text('Inicia sesión para acceder al sistema de incidencias'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);

      tester.view.viewInsets = FakeViewPadding(bottom: 200);
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Ingresar'));
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('Tu reporte, nuestra mejora'));
      expect(tester.takeException(), isNull);
      tester.view.resetViewInsets();
      await tester.pumpAndSettle();

      final campos = find.byType(TextFormField);
      await tester.enterText(campos.at(0), 'usuario@espe.edu.ec');
      await tester.enterText(campos.at(1), 'clave');
      await tester.ensureVisible(find.byIcon(Icons.visibility_outlined));
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pump();
      expect(
        tester
            .widget<EditableText>(
              find.descendant(
                of: campos.at(1),
                matching: find.byType(EditableText),
              ),
            )
            .obscureText,
        isFalse,
      );
      await tester.ensureVisible(find.text('Ingresar'));
      await tester.tap(find.text('Ingresar'));
      await tester.pumpAndSettle();

      expect(find.text('Inicio'), findsOneWidget);
      expect(sesion.esAdministrador, rol == 'administrador');
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('login distribuye el eslogan al pie en teléfono alto', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    final sesion = SesionViewModel(
      IniciarSesion(RepositorioUsuariosLogin('usuario')),
    );
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: sesion,
        child: const MaterialApp(home: LoginView()),
      ),
    );
    await tester.pumpAndSettle();

    final fondo = find.byType(FondoEncabezado);
    final eslogan = find.text('Tu reporte, nuestra mejora');
    expect(tester.getSize(fondo).height, 104);
    expect(
      tester.getTopLeft(find.byType(Image)).dy,
      greaterThan(tester.getBottomLeft(fondo).dy + 20),
    );
    expect(
      tester.getTopLeft(eslogan).dy,
      greaterThan(tester.getBottomLeft(find.byType(Card)).dy),
    );
    expect(
      tester
          .getBottomLeft(find.text('Sistema de Incidencias Universitarias'))
          .dy,
      lessThanOrEqualTo(800),
    );
    expect(tester.takeException(), isNull);
  });
}
