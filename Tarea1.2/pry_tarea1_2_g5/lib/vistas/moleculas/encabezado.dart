import 'package:flutter/material.dart';

import '../../tema/colores_app.dart';
import '../../tema/tema_app.dart';
import '../atomos/logo_app.dart';

/// MOLÉCULA: logo + "RecargaFácil" + eslogan (pantalla de login).
class Encabezado extends StatelessWidget {
  const Encabezado({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppLogo(alto: 115),
        SizedBox(height: 18),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Recarga', style: TextStyle(color: Colors.white)),
              TextSpan(text: 'Fácil', style: TextStyle(color: AppColors.rosa)),
            ],
          ),
          style: TextStyle(
            fontFamily: AppTheme.fuenteLogo,
            fontSize: 42,
            fontWeight: FontWeight.w500,
            height: 1.1,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Tu recarga, en un solo lugar',
          style: TextStyle(
            fontFamily: AppTheme.fuenteTitulos,
            fontSize: 19,
            color: AppColors.rosa,
          ),
        ),
      ],
    );
  }
}
