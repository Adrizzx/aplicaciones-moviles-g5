import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pry_tarea2_1_g5/presentation/widgets/encabezado_app.dart';
import 'package:pry_tarea2_1_g5/presentation/widgets/fondo_encabezado.dart';
import 'package:pry_tarea2_1_g5/theme/colores_app.dart';

void main() {
  testWidgets(
    'el encabezado conserva acciones y navegación en teléfono estrecho',
    (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
      var refrescos = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              appBar: EncabezadoApp(
                titulo: 'Incidencias universitarias',
                acciones: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () => refrescos++,
                  ),
                ],
              ),
              body: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => Scaffold(
                      appBar: const EncabezadoApp(
                        titulo: 'Detalle de incidencia',
                      ),
                    ),
                  ),
                ),
                child: const Text('Abrir detalle'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(EncabezadoApp), findsOneWidget);
      expect(find.byType(FondoEncabezado), findsOneWidget);
      expect(find.byType(BackButton), findsNothing);
      expect(
        tester.getRect(find.text('Incidencias universitarias')).right,
        lessThanOrEqualTo(tester.getRect(find.byIcon(Icons.refresh)).left),
      );
      expect(tester.takeException(), isNull);
      await tester.tap(find.byIcon(Icons.refresh));
      expect(refrescos, 1);

      await tester.tap(find.text('Abrir detalle'));
      await tester.pumpAndSettle();
      expect(find.byType(BackButton), findsOneWidget);
      final titulo = tester.widget<Text>(find.text('Detalle de incidencia'));
      expect(titulo.style?.color, ColoresApp.blanco);
      expect(titulo.style?.fontWeight, FontWeight.w600);
      expect(tester.takeException(), isNull);
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.text('Incidencias universitarias'), findsOneWidget);
    },
  );
}
