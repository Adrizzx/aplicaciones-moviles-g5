import 'package:flutter/material.dart';

/// MOLÉCULA: título numerado de cada sección ("1.  Número telefónico").
class SectionTitle extends StatelessWidget {
  final int numero;
  final String texto;

  const SectionTitle({super.key, required this.numero, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 2),
      child: Text('$numero.  $texto', style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
