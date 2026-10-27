/// Funciones de ayuda para mostrar valores.
class Formato {
  static const List<String> _meses = [
    'ene.', 'feb.', 'mar.', 'abr.', 'may.', 'jun.',
    'jul.', 'ago.', 'sep.', 'oct.', 'nov.', 'dic.',
  ];

  /// 10.3 -> "$ 10,30"
  static String dinero(double valor) {
    return '\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  /// 3.0 -> "3%"   2.5 -> "2,5%"
  static String porcentaje(double valor) {
    final texto = valor % 1 == 0 ? valor.toStringAsFixed(0) : valor.toStringAsFixed(1);
    return '${texto.replaceAll('.', ',')}%';
  }

  /// "26 oct. 2026 - 16:42"
  static String fecha(DateTime f) {
    String dos(int n) => n.toString().padLeft(2, '0');
    return '${f.day} ${_meses[f.month - 1]} ${f.year} - ${dos(f.hour)}:${dos(f.minute)}';
  }

  /// "0987654321" -> "098 765 4321"
  static String telefono(String numero) {
    if (numero.length != 10) return numero;
    return '${numero.substring(0, 3)} ${numero.substring(3, 6)} ${numero.substring(6)}';
  }
}
