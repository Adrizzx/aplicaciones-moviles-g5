import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tarea22/main.dart';
import 'package:tarea22/model/mascota_model.dart';
import 'package:tarea22/view_model/mascota_viewmodel.dart';

void main() {
  testWidgets('doble toque, navegación y arrastre a Me interesa', (
    tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => MascotaViewmodel(),
        child: const MyApp(),
      ),
    );

    // Termina la animación del splash y se entra con el botón.
    await tester.pumpAndSettle();
    await tester.tap(find.text('Conoce a las mascotas'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Luna'));
    await tester.pumpAndSettle();
    expect(find.text('Favoritas: 0'), findsOneWidget);

    // Gesto 1: doble toque.
    await tester.tap(find.text('Luna'));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(find.text('Luna'));
    await tester.pumpAndSettle();
    expect(find.text('Favoritas: 1'), findsOneWidget);

    // Un toque abre el detalle con los datos recibidos por arguments.
    await tester.tap(find.text('Luna'));
    await tester.pumpAndSettle();
    expect(find.text('Siamés'), findsOneWidget);

    // Gesto 2: arrastrar la foto a la zona "Me interesa".
    final zona = find.text('Me interesa: arrastra la foto aquí');
    final gesto = await tester.startGesture(
      tester.getCenter(find.byType(Draggable<MascotaModel>)),
    );
    await tester.pump(const Duration(milliseconds: 50));
    await gesto.moveTo(tester.getCenter(zona));
    await tester.pump(const Duration(milliseconds: 50));
    await gesto.up();
    await tester.pumpAndSettle();
    expect(find.text('¡Luna te interesa!'), findsOneWidget);
  });
}
