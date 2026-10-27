import 'package:flutter/material.dart';

import '../../controladores/controlador_recarga.dart';
import '../../modelos/modelo_operadora.dart';
import '../../modelos/modelo_recarga.dart';
import '../../tema/colores_app.dart';
import '../atomos/boton_app.dart';
import '../atomos/campo_texto.dart';
import '../moleculas/banner_recarga.dart';
import '../moleculas/chip_valor.dart';
import '../moleculas/opcion_pago.dart';
import '../moleculas/tarjeta_operadora.dart';
import '../moleculas/titulo_seccion.dart';
import 'resumen_pago.dart';

/// ORGANISMO: formulario completo de la nueva recarga.
class RecargaForm extends StatefulWidget {
  final RecargaController controller;
  final ValueChanged<RecargaModel> onConfirm;

  const RecargaForm({super.key, required this.controller, required this.onConfirm});

  @override
  State<RecargaForm> createState() => _RecargaFormState();
}

class _RecargaFormState extends State<RecargaForm> {
  final _formKey = GlobalKey<FormState>();
  final _numeroCtrl = TextEditingController();
  final _otroValorCtrl = TextEditingController();

  OperadoraModel? _operadora;
  double? _valor;
  String? _formaPago;

  // Errores de las opciones que no son campos de texto
  String? _errorOperadora;
  String? _errorValor;
  String? _errorPago;

  @override
  void dispose() {
    _numeroCtrl.dispose();
    _otroValorCtrl.dispose();
    super.dispose();
  }

  void _enviar() {
    final c = widget.controller;
    final numeroValido = _formKey.currentState!.validate();

    setState(() {
      _errorOperadora = c.validarSeleccion(_operadora, 'una operadora');
      _errorValor = c.validarValor(_valor, _otroValorCtrl.text);
      _errorPago = c.validarSeleccion(_formaPago, 'una forma de pago');
    });

    if (numeroValido && _errorOperadora == null && _errorValor == null && _errorPago == null) {
      final recarga = c.crearRecarga(
        numero: _numeroCtrl.text,
        operadora: _operadora!,
        valor: c.obtenerValor(_valor, _otroValorCtrl.text)!,
        formaPago: _formaPago!,
      );
      widget.onConfirm(recarga);
      _limpiar();
    }
  }

  void _limpiar() {
    _formKey.currentState!.reset();
    _numeroCtrl.clear();
    _otroValorCtrl.clear();
    setState(() {
      _operadora = null;
      _valor = null;
      _formaPago = null;
    });
  }

  /// Recarga de muestra para el resumen (null si faltan datos).
  RecargaModel? _vistaPrevia() {
    final valor = widget.controller.obtenerValor(_valor, _otroValorCtrl.text);
    if (_operadora == null || valor == null || valor <= 0) return null;
    return widget.controller.crearRecarga(
      numero: '',
      operadora: _operadora!,
      valor: valor,
      formaPago: '',
    );
  }

  IconData _iconoPago(String forma) {
    if (forma.startsWith('Tarjeta')) return Icons.credit_card;
    if (forma.startsWith('Transferencia')) return Icons.account_balance_outlined;
    return Icons.local_atm_outlined;
  }

  Widget _mensajeError(String? mensaje) {
    if (mensaje == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 6),
      child: Text(mensaje, style: const TextStyle(color: AppColors.error, fontSize: 12)),
    );
  }

  /// Fila de 4 elementos con el mismo espacio entre ellos.
  Widget _fila(List<Widget> hijos) {
    return Row(
      children: [
        for (int i = 0; i < hijos.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(child: hijos[i]),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.controller;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const RecargaBanner(),
          const SizedBox(height: 22),

          // 1. Número telefónico
          const SectionTitle(numero: 1, texto: 'Número telefónico'),
          AppTextField(
            hint: 'Ingresa el número',
            icono: Icons.call_outlined,
            iconoFinal: Icons.account_box_outlined,
            controller: _numeroCtrl,
            tipoTeclado: TextInputType.phone,
            soloNumeros: true,
            maxLength: 10,
            validator: c.validarNumero,
          ),
          const SizedBox(height: 20),

          // 2. Operadora
          const SectionTitle(numero: 2, texto: 'Operadora'),
          _fila([
            for (final operadora in c.operadoras)
              OperadoraCard(
                nombre: operadora.nombre,
                seleccionada: _operadora == operadora,
                onTap: () => setState(() {
                  _operadora = operadora;
                  _errorOperadora = null;
                }),
              ),
          ]),
          _mensajeError(_errorOperadora),
          const SizedBox(height: 20),

          // 3. Valor de la recarga
          const SectionTitle(numero: 3, texto: 'Valor de la recarga'),
          _fila([
            for (final valor in c.valores)
              ValorChip(
                texto: '\$ ${valor.toStringAsFixed(0)}',
                seleccionado: _valor == valor,
                onTap: () => setState(() {
                  _valor = valor;
                  _otroValorCtrl.clear();
                  _errorValor = null;
                }),
              ),
          ]),
          const SizedBox(height: 14),
          AppTextField(
            etiqueta: 'Otro valor',
            hint: 'Ingresa el valor',
            icono: Icons.attach_money,
            controller: _otroValorCtrl,
            tipoTeclado: TextInputType.number,
            soloNumeros: true,
            maxLength: 3,
            onChanged: (_) => setState(() {
              _valor = null; // si escribe otro valor se quita el botón elegido
              _errorValor = null;
            }),
          ),
          _mensajeError(_errorValor),
          const SizedBox(height: 20),

          // 4. Forma de pago
          const SectionTitle(numero: 4, texto: 'Forma de pago'),
          for (final forma in c.formasPago)
            PagoOption(
              texto: forma,
              icono: _iconoPago(forma),
              seleccionada: _formaPago == forma,
              onTap: () => setState(() {
                _formaPago = forma;
                _errorPago = null;
              }),
            ),
          _mensajeError(_errorPago),
          const SizedBox(height: 12),

          ResumenCard(recarga: _vistaPrevia()),
          const SizedBox(height: 16),
          AppButton(
            texto: 'Continuar',
            icono: Icons.arrow_forward,
            iconoAlFinal: true,
            alto: 46,
            onPressed: _enviar,
          ),
        ],
      ),
    );
  }
}
