import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../tema/colores_app.dart';

/// ÁTOMO: campo de texto. Tiene versión clara y oscura (login).
class AppTextField extends StatefulWidget {
  final String hint;
  final String? etiqueta; // texto pequeño arriba (ej. "Otro valor")
  final IconData icono;
  final IconData? iconoFinal;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType tipoTeclado;
  final bool esContrasena;
  final bool soloNumeros;
  final int? maxLength;
  final bool oscuro;

  const AppTextField({
    super.key,
    required this.hint,
    required this.icono,
    required this.controller,
    this.etiqueta,
    this.iconoFinal,
    this.validator,
    this.onChanged,
    this.tipoTeclado = TextInputType.text,
    this.esContrasena = false,
    this.soloNumeros = false,
    this.maxLength,
    this.oscuro = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _oculto = true; // mostrar u ocultar la contraseña

  @override
  Widget build(BuildContext context) {
    final colorIcono = widget.oscuro ? const Color(0xFFD5DCDB) : AppColors.texto;

    Widget? sufijo;
    if (widget.esContrasena) {
      sufijo = IconButton(
        icon: Icon(
          _oculto ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: colorIcono,
          size: 22,
        ),
        onPressed: () => setState(() => _oculto = !_oculto),
      );
    } else if (widget.iconoFinal != null) {
      sufijo = Icon(widget.iconoFinal, color: colorIcono, size: 22);
    }

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      keyboardType: widget.tipoTeclado,
      obscureText: widget.esContrasena && _oculto,
      maxLength: widget.maxLength,
      inputFormatters: widget.soloNumeros ? [FilteringTextInputFormatter.digitsOnly] : null,
      cursorColor: widget.oscuro ? AppColors.rosa : AppColors.vino,
      style: TextStyle(
        color: widget.oscuro ? Colors.white : AppColors.texto,
        fontSize: widget.oscuro ? 16 : 14,
      ),
      decoration: widget.oscuro
          ? _decoracionOscura(colorIcono, sufijo)
          : InputDecoration(
              hintText: widget.hint,
              labelText: widget.etiqueta,
              floatingLabelBehavior:
                  widget.etiqueta != null ? FloatingLabelBehavior.always : null,
              prefixIcon: Icon(widget.icono, size: 22),
              suffixIcon: sufijo,
              counterText: '',
            ),
    );
  }

  InputDecoration _decoracionOscura(Color colorIcono, Widget? sufijo) {
    OutlineInputBorder borde(Color color) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color, width: 1.2),
        );
    const colorError = Color(0xFFFF9E9E);

    return InputDecoration(
      hintText: widget.hint,
      hintStyle: const TextStyle(color: Color(0xFFE4E9E8), fontSize: 16),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 16, right: 10),
        child: Icon(widget.icono, color: colorIcono, size: 24),
      ),
      suffixIcon: sufijo,
      counterText: '',
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      enabledBorder: borde(const Color(0xFF5E6E6E)),
      focusedBorder: borde(AppColors.rosa),
      errorBorder: borde(colorError),
      focusedErrorBorder: borde(colorError),
      errorStyle: const TextStyle(color: colorError),
    );
  }
}
