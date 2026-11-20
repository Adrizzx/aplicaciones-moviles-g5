import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pry_tarea2_1_g5/domain/entities/area_responsable.dart';
import 'package:pry_tarea2_1_g5/domain/entities/incidencia.dart';
import 'package:pry_tarea2_1_g5/domain/entities/usuario.dart';
import 'package:pry_tarea2_1_g5/domain/repositories/area_responsable_repository.dart';
import 'package:pry_tarea2_1_g5/domain/repositories/incidencia_repository.dart';
import 'package:pry_tarea2_1_g5/domain/repositories/usuario_repository.dart';
import 'package:pry_tarea2_1_g5/domain/usecases/actualizar_incidencia.dart';
import 'package:pry_tarea2_1_g5/domain/usecases/crear_incidencia.dart';
import 'package:pry_tarea2_1_g5/domain/usecases/iniciar_sesion.dart';
import 'package:pry_tarea2_1_g5/domain/usecases/obtener_area_responsables.dart';
import 'package:pry_tarea2_1_g5/domain/usecases/obtener_incidencias.dart';
import 'package:pry_tarea2_1_g5/domain/usecases/obtener_usuarios.dart';
import 'package:pry_tarea2_1_g5/presentation/viewmodels/incidencia_viewmodel.dart';
import 'package:pry_tarea2_1_g5/presentation/viewmodels/sesion_viewmodel.dart';
import 'package:pry_tarea2_1_g5/presentation/views/gestionar_incidencia_view.dart';
import 'package:pry_tarea2_1_g5/presentation/views/formulario_incidencia_view.dart';
import 'package:pry_tarea2_1_g5/presentation/views/detalle_incidencia_view.dart';
import 'package:pry_tarea2_1_g5/presentation/widgets/campo_formulario.dart';

class RepositorioIncidenciasGestion implements IncidenciaRepository {
  Incidencia? guardada;

  @override
  Future<List<Incidencia>> obtenerIncidencias() async =>
      guardada == null ? [] : [guardada!];

  @override
  Future<Incidencia> crearIncidencia(Incidencia incidencia) async {
    guardada = incidencia;
    return incidencia;
  }

  @override
  Future<Incidencia> actualizarIncidencia(Incidencia incidencia) async {
    guardada = incidencia;
    return incidencia;
  }
}

class RepositorioUsuariosGestion implements UsuarioRepository {
  @override
  Future<List<Usuario>> obtenerUsuarios() async => [];

  @override
  Future<Usuario?> iniciarSesion(String correo, String contrasena) async =>
      null;
}

class RepositorioAreasGestion implements AreaResponsableRepository {
  @override
  Future<List<AreaResponsable>> obtenerAreaResponsables() async => [
    AreaResponsable(id: '2', nombre: 'Mantenimiento', descripcion: ''),
  ];
}

void main() {
  testWidgets('detalle muestra la ficha y la observación solo cuando existe', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    final repositorio = RepositorioIncidenciasGestion();
    final usuarios = RepositorioUsuariosGestion();
    final areas = RepositorioAreasGestion();
    final sesion = SesionViewModel(IniciarSesion(usuarios))
      ..usuarioActual = Usuario(
        id: 'usuario',
        nombre: 'María Torres',
        correo: 'maria@test.ec',
        tipo: 'Administrativo',
        rol: 'usuario',
      );
    final vistaModelo = IncidenciaViewModel(
      ObtenerIncidencias(repositorio),
      CrearIncidencia(repositorio),
      ActualizarIncidencia(repositorio),
      ObtenerUsuarios(usuarios),
      ObtenerAreaResponsables(areas),
    );
    vistaModelo.usuarios = [sesion.usuarioActual!];
    final incidencia = Incidencia(
      id: '1',
      usuarioId: 'usuario',
      titulo: 'Falla de internet en el laboratorio de computación',
      descripcion: 'No hay acceso a internet en ningún equipo del aula.',
      ubicacion: 'Bloque B, laboratorio 3',
      fecha: DateTime(2026, 11, 16),
      estado: 'Reportada',
      observacionSolucion: '',
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: sesion),
          ChangeNotifierProvider.value(value: vistaModelo),
        ],
        child: MaterialApp(
          initialRoute: '/detalle',
          onGenerateRoute: (settings) => MaterialPageRoute<void>(
            settings: RouteSettings(name: settings.name, arguments: incidencia),
            builder: (_) => const DetalleIncidenciaView(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(incidencia.titulo), findsOneWidget);
    expect(
      find.ancestor(
        of: find.text(incidencia.titulo),
        matching: find.byType(Card),
      ),
      findsOneWidget,
    );
    expect(find.text('Reportada'), findsOneWidget);
    expect(find.text('16/11/2026'), findsOneWidget);
    expect(find.text('Pendiente de clasificación'), findsOneWidget);
    expect(find.text('María Torres'), findsOneWidget);
    expect(find.text('Administrativo'), findsOneWidget);
    expect(find.text(incidencia.ubicacion), findsOneWidget);
    expect(find.text('Sin asignar'), findsOneWidget);
    expect(find.text('Observación de solución'), findsNothing);
    expect(tester.takeException(), isNull);
    expect(tester.getTopLeft(find.text(incidencia.titulo)).dy, lessThan(130));
    expect(
      tester.getTopLeft(find.text('Fecha')).dy,
      lessThan(tester.getTopLeft(find.text('Prioridad')).dy),
    );
    tester.view.physicalSize = const Size(360, 800);
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.text('Fecha')).dy,
      tester.getTopLeft(find.text('Prioridad')).dy,
    );
    expect(tester.takeException(), isNull);
    tester.view.physicalSize = const Size(600, 800);
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.text('Fecha')).dy,
      tester.getTopLeft(find.text('Prioridad')).dy,
    );
    expect(tester.takeException(), isNull);
    tester.view.physicalSize = const Size(320, 800);
    await tester.pumpAndSettle();
    sesion.usuarioActual = Usuario(
      id: 'admin',
      nombre: 'Administrador',
      correo: 'admin@test.ec',
      tipo: 'Administrativo',
      rol: 'administrador',
    );
    sesion.notifyListeners();
    await tester.pumpAndSettle();
    expect(find.text(incidencia.titulo), findsOneWidget);
    expect(find.text('María Torres'), findsOneWidget);
    expect(find.text('Pendiente de clasificación'), findsOneWidget);
    expect(tester.takeException(), isNull);

    vistaModelo.incidencias = [
      incidencia.copiar(
        estado: 'Cerrada',
        observacionSolucion: 'Red reparada y verificada',
      ),
    ];
    vistaModelo.notifyListeners();
    await tester.pumpAndSettle();
    expect(find.text('Cerrada'), findsOneWidget);
    expect(find.text('Red reparada y verificada'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('el formulario muestra fecha y datos automáticos sin desbordar', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    final repositorio = RepositorioIncidenciasGestion();
    final usuarios = RepositorioUsuariosGestion();
    final areas = RepositorioAreasGestion();
    final sesion = SesionViewModel(IniciarSesion(usuarios))
      ..usuarioActual = Usuario(
        id: 'usuario',
        nombre: 'María Torres',
        correo: 'maria@test.ec',
        tipo: 'Administrativo',
        rol: 'usuario',
      );
    final vistaModelo = IncidenciaViewModel(
      ObtenerIncidencias(repositorio),
      CrearIncidencia(repositorio),
      ActualizarIncidencia(repositorio),
      ObtenerUsuarios(usuarios),
      ObtenerAreaResponsables(areas),
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: sesion),
          ChangeNotifierProvider.value(value: vistaModelo),
        ],
        child: const MaterialApp(home: FormularioIncidenciaView()),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byType(CampoFormulario), findsNWidgets(5));
    expect(find.text('María Torres'), findsOneWidget);
    expect(find.text('Administrativo'), findsOneWidget);
    final campos = find.byType(TextFormField);
    final fechaVisible = tester
        .widget<TextFormField>(campos.at(3))
        .initialValue;
    expect(
      tester
          .widget<EditableText>(
            find.descendant(
              of: campos.at(3),
              matching: find.byType(EditableText),
            ),
          )
          .readOnly,
      isTrue,
    );
    expect(
      tester.widget<TextFormField>(campos.at(4)).initialValue,
      'Reportada',
    );
    expect(
      tester
          .widget<EditableText>(
            find.descendant(
              of: campos.at(4),
              matching: find.byType(EditableText),
            ),
          )
          .readOnly,
      isTrue,
    );
    tester.view.physicalSize = const Size(600, 800);
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(campos.at(3)).dy,
      tester.getTopLeft(campos.at(4)).dy,
    );
    expect(tester.takeException(), isNull);
    tester.view.physicalSize = const Size(320, 800);
    await tester.pumpAndSettle();

    await tester.enterText(campos.at(0), 'Falla de internet');
    await tester.enterText(campos.at(1), 'Sin acceso a la red');
    await tester.enterText(campos.at(2), 'Bloque B');
    expect(
      tester.widget<TextFormField>(campos.at(0)).controller?.text,
      'Falla de internet',
    );
    expect(
      tester.widget<TextFormField>(campos.at(1)).controller?.text,
      'Sin acceso a la red',
    );
    expect(
      tester.widget<TextFormField>(campos.at(2)).controller?.text,
      'Bloque B',
    );
    await tester.ensureVisible(find.text('Registrar incidencia'));
    await tester.tap(find.text('Registrar incidencia'));
    await tester.pumpAndSettle();

    expect(repositorio.guardada, isNotNull);
    final guardada = repositorio.guardada!;
    final fechaGuardada = guardada.fecha.toLocal();
    expect(
      fechaVisible,
      '${fechaGuardada.day.toString().padLeft(2, '0')}/'
      '${fechaGuardada.month.toString().padLeft(2, '0')}/${fechaGuardada.year}',
    );
    expect(guardada.usuarioId, 'usuario');
    expect(guardada.estado, 'Reportada');
    expect(tester.takeException(), isNull);
  });

  testWidgets('el área anticipa Asignada y solo se guarda al confirmar', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    final repositorio = RepositorioIncidenciasGestion();
    final usuarios = RepositorioUsuariosGestion();
    final areas = RepositorioAreasGestion();
    final sesion = SesionViewModel(IniciarSesion(usuarios))
      ..usuarioActual = Usuario(
        id: 'admin',
        nombre: 'Admin',
        correo: 'admin@test.ec',
        tipo: 'Administrativo',
        rol: 'administrador',
      );
    final vistaModelo = IncidenciaViewModel(
      ObtenerIncidencias(repositorio),
      CrearIncidencia(repositorio),
      ActualizarIncidencia(repositorio),
      ObtenerUsuarios(usuarios),
      ObtenerAreaResponsables(areas),
    );
    vistaModelo.areas = await areas.obtenerAreaResponsables();
    vistaModelo.usuarios = [
      Usuario(
        id: 'usuario',
        nombre: 'Carlos Pérez',
        correo: 'carlos@test.ec',
        tipo: 'Docente',
        rol: 'usuario',
      ),
    ];
    final incidencia = Incidencia(
      id: 'J-pXsh13iNg',
      usuarioId: 'usuario',
      titulo: 'Falla',
      descripcion: 'Detalle',
      ubicacion: 'Aula',
      fecha: DateTime(2026, 11, 16),
      estado: 'Reportada',
      observacionSolucion: '',
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: sesion),
          ChangeNotifierProvider.value(value: vistaModelo),
        ],
        child: MaterialApp(
          initialRoute: '/gestionar',
          onGenerateRoute: (settings) => MaterialPageRoute<void>(
            settings: RouteSettings(name: settings.name, arguments: incidencia),
            builder: (_) => const GestionarIncidenciaView(),
          ),
        ),
      ),
    );
    expect(find.text('J-pXsh13iNg'), findsNothing);
    expect(find.byType(CampoFormulario), findsNWidgets(3));
    expect(find.text('Carlos Pérez'), findsOneWidget);
    expect(find.text('Docente'), findsOneWidget);
    expect(tester.takeException(), isNull);
    expect(
      tester.getTopLeft(find.text('Reportado por')).dy,
      tester.getTopLeft(find.text('Fecha de reporte')).dy,
    );
    tester.view.physicalSize = const Size(600, 800);
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.text('Reportado por')).dy,
      tester.getTopLeft(find.text('Fecha de reporte')).dy,
    );
    expect(tester.takeException(), isNull);
    tester.view.physicalSize = const Size(320, 800);
    await tester.pumpAndSettle();

    final estadoInicial = tester
        .widgetList<DropdownButtonFormField<String>>(
          find.byType(DropdownButtonFormField<String>),
        )
        .last;
    expect(estadoInicial.initialValue, 'Reportada');
    expect(estadoInicial.onChanged, isNull);

    await tester.tap(find.byType(DropdownButtonFormField<String>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mantenimiento').last);
    await tester.pumpAndSettle();

    final estadoAsignado = tester
        .widgetList<DropdownButtonFormField<String>>(
          find.byType(DropdownButtonFormField<String>),
        )
        .last;
    expect(estadoAsignado.initialValue, 'Asignada');
    expect(estadoAsignado.onChanged, isNull);
    expect(find.text('Reportada'), findsOneWidget);
    expect(repositorio.guardada, isNull);

    await tester.scrollUntilVisible(
      find.text('Crítica'),
      160,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Crítica'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widgetList<ChoiceChip>(find.byType(ChoiceChip))
          .singleWhere((chip) => (chip.label as Text).data == 'Crítica')
          .selected,
      isTrue,
    );
    expect(repositorio.guardada, isNull);

    await tester.scrollUntilVisible(
      find.text('Guardar cambios'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Guardar cambios'));
    await tester.pumpAndSettle();
    expect(repositorio.guardada?.areaId, '2');
    expect(repositorio.guardada?.id, 'J-pXsh13iNg');
    expect(repositorio.guardada?.estado, 'Asignada');
    expect(repositorio.guardada?.prioridad, 'Crítica');
  });

  testWidgets('una incidencia asignada puede avanzar a En proceso', (
    tester,
  ) async {
    final repositorio = RepositorioIncidenciasGestion();
    final usuarios = RepositorioUsuariosGestion();
    final areas = RepositorioAreasGestion();
    final sesion = SesionViewModel(IniciarSesion(usuarios))
      ..usuarioActual = Usuario(
        id: 'admin',
        nombre: 'Admin',
        correo: 'admin@test.ec',
        tipo: 'Administrativo',
        rol: 'administrador',
      );
    final vistaModelo = IncidenciaViewModel(
      ObtenerIncidencias(repositorio),
      CrearIncidencia(repositorio),
      ActualizarIncidencia(repositorio),
      ObtenerUsuarios(usuarios),
      ObtenerAreaResponsables(areas),
    );
    vistaModelo.areas = await areas.obtenerAreaResponsables();
    final incidencia = Incidencia(
      id: '2',
      usuarioId: 'usuario',
      titulo: 'Falla',
      descripcion: 'Detalle',
      ubicacion: 'Aula',
      fecha: DateTime(2026, 11, 16),
      estado: 'Asignada',
      areaId: '2',
      observacionSolucion: '',
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: sesion),
          ChangeNotifierProvider.value(value: vistaModelo),
        ],
        child: MaterialApp(
          initialRoute: '/gestionar',
          onGenerateRoute: (settings) => MaterialPageRoute<void>(
            settings: RouteSettings(name: settings.name, arguments: incidencia),
            builder: (_) => const GestionarIncidenciaView(),
          ),
        ),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Alta'),
      160,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Alta'));
    await tester.pumpAndSettle();
    final estado = tester
        .widgetList<DropdownButtonFormField<String>>(
          find.byType(DropdownButtonFormField<String>),
        )
        .last;
    expect(estado.onChanged, isNotNull);
    await tester.ensureVisible(
      find.byType(DropdownButtonFormField<String>).last,
    );
    await tester.tap(find.byType(DropdownButtonFormField<String>).last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('En proceso').last);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Guardar cambios'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Guardar cambios'));
    await tester.pumpAndSettle();

    expect(repositorio.guardada?.prioridad, 'Alta');
    expect(repositorio.guardada?.estado, 'En proceso');
  });

  testWidgets('resuelta conserva área y prioridad al pasar a Cerrada', (
    tester,
  ) async {
    final repositorio = RepositorioIncidenciasGestion();
    final usuarios = RepositorioUsuariosGestion();
    final areas = RepositorioAreasGestion();
    final sesion = SesionViewModel(IniciarSesion(usuarios))
      ..usuarioActual = Usuario(
        id: 'admin',
        nombre: 'Admin',
        correo: 'admin@test.ec',
        tipo: 'Administrativo',
        rol: 'administrador',
      );
    final vistaModelo = IncidenciaViewModel(
      ObtenerIncidencias(repositorio),
      CrearIncidencia(repositorio),
      ActualizarIncidencia(repositorio),
      ObtenerUsuarios(usuarios),
      ObtenerAreaResponsables(areas),
    );
    vistaModelo.areas = await areas.obtenerAreaResponsables();
    final incidencia = Incidencia(
      id: '3',
      usuarioId: 'usuario',
      titulo: 'Falla',
      descripcion: 'Detalle',
      ubicacion: 'Aula',
      fecha: DateTime(2026, 11, 16),
      estado: 'Resuelta',
      areaId: '2',
      prioridad: 'Alta',
      observacionSolucion: 'Reparada',
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: sesion),
          ChangeNotifierProvider.value(value: vistaModelo),
        ],
        child: MaterialApp(
          initialRoute: '/gestionar',
          onGenerateRoute: (settings) => MaterialPageRoute<void>(
            settings: RouteSettings(name: settings.name, arguments: incidencia),
            builder: (_) => const GestionarIncidenciaView(),
          ),
        ),
      ),
    );

    final campos = tester
        .widgetList<DropdownButtonFormField<String>>(
          find.byType(DropdownButtonFormField<String>),
        )
        .toList();
    expect(campos.first.initialValue, '2');
    expect(campos.first.onChanged, isNull);
    expect(campos.last.initialValue, 'Resuelta');
    expect(campos.last.onChanged, isNotNull);
    final prioridades = tester.widgetList<ChoiceChip>(find.byType(ChoiceChip));
    expect(prioridades.every((chip) => chip.onSelected == null), isTrue);
    expect(
      prioridades
          .singleWhere((chip) => (chip.label as Text).data == 'Alta')
          .selected,
      isTrue,
    );

    await tester.ensureVisible(
      find.byType(DropdownButtonFormField<String>).last,
    );
    await tester.tap(find.byType(DropdownButtonFormField<String>).last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cerrada').last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Guardar cambios'));
    await tester.tap(find.text('Guardar cambios'));
    await tester.pumpAndSettle();

    expect(repositorio.guardada?.estado, 'Cerrada');
    expect(repositorio.guardada?.areaId, '2');
    expect(repositorio.guardada?.prioridad, 'Alta');
    expect(repositorio.guardada?.observacionSolucion, 'Reparada');
  });
}
