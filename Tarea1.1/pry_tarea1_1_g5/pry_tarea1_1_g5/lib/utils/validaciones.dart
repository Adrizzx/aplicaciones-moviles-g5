// Funciones de apoyo para leer y validar lo que el usuario escribe
// en los campos de texto, y para mostrar los resultados.

/// Convierte un texto a número decimal. Acepta coma o punto.
/// Devuelve null si el texto está vacío o no es un número válido.
double? leerDecimal(String? texto) {
  if (texto == null) return null;
  final limpio = texto.trim().replaceAll(',', '.');
  if (limpio.isEmpty) return null;
  final valor = double.tryParse(limpio);
  if (valor == null || !valor.isFinite) return null;
  return valor;
}

/// Convierte un texto a número entero. Devuelve null si no es válido.
int? leerEntero(String? texto) {
  if (texto == null) return null;
  return int.tryParse(texto.trim());
}

String? validarTextoObligatorio(String? texto) {
  if (texto == null || texto.trim().isEmpty) {
    return 'Este campo es obligatorio';
  }
  return null;
}

/// Acepta cualquier número (positivo, negativo o cero).
String? validarNumero(String? texto) {
  if (texto == null || texto.trim().isEmpty) {
    return 'Este campo es obligatorio';
  }
  if (leerDecimal(texto) == null) {
    return 'Ingrese un número válido';
  }
  return null;
}

/// Acepta números mayores o iguales a cero.
String? validarNoNegativo(String? texto) {
  final error = validarNumero(texto);
  if (error != null) return error;
  if (leerDecimal(texto)! < 0) {
    return 'No se permiten valores negativos';
  }
  return null;
}

/// Acepta solo números mayores a cero.
String? validarPositivo(String? texto) {
  final error = validarNumero(texto);
  if (error != null) return error;
  if (leerDecimal(texto)! <= 0) {
    return 'El valor debe ser mayor que 0';
  }
  return null;
}

/// Muestra un valor como dinero, por ejemplo $1250.50
String formatoDinero(double valor) => '\$${valor.toStringAsFixed(2)}';

/// Muestra un número sin decimales si es entero (15 en vez de 15.0).
String formatoNumero(double valor) {
  if (valor == valor.truncateToDouble()) {
    return valor.toStringAsFixed(0);
  }
  return valor.toStringAsFixed(2);
}
