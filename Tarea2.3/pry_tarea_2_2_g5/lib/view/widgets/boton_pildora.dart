import 'package:flutter/material.dart';
import 'package:tarea22/view/tema.dart';

class BotonPildora extends StatelessWidget {
  final String texto;
  final VoidCallback alPresionar;

  const BotonPildora({
    super.key,
    required this.texto,
    required this.alPresionar,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: alPresionar,
      style: ElevatedButton.styleFrom(
        backgroundColor: Tema.verde,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.fromLTRB(24, 8, 8, 8),
        shape: const StadiumBorder(),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              texto,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: Tema.letraTitulos,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(Icons.pets, color: Tema.verde, size: 22),
          ),
        ],
      ),
    );
  }
}
