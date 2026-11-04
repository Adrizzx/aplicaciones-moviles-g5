import 'package:flutter/material.dart';
import 'package:tarea22/model/mascota_model.dart';

class MascotaViewmodel extends ChangeNotifier {
  final List<MascotaModel> mascotas = const [
    MascotaModel(
      nombre: 'Luna',
      edad: '2 años',
      raza: 'Siamés',
      imagen: 'assets/mascotas/luna.png',
      icono: '🐱',
    ),
    MascotaModel(
      nombre: 'Rocky',
      edad: '3 años',
      raza: 'Labrador',
      imagen: 'assets/mascotas/rocky.png',
      icono: '🐶',
    ),
    MascotaModel(
      nombre: 'Toby',
      edad: '8 meses',
      raza: 'Beagle',
      imagen: 'assets/mascotas/toby.png',
      icono: '🐶',
    ),
    MascotaModel(
      nombre: 'Mia',
      edad: '1 año',
      raza: 'Persa',
      imagen: 'assets/mascotas/mia.png',
      icono: '🐱',
    ),
    MascotaModel(
      nombre: 'Max',
      edad: '5 años',
      raza: 'Mestizo',
      imagen: 'assets/mascotas/max.png',
      icono: '🐶',
    ),
  ];

  final List<MascotaModel> favoritas = [];
  final List<MascotaModel> interesadas = [];
  MascotaModel? seleccionada;
  String filtro = 'Todas';

  // Mascotas que se muestran segun la categoria elegida.
  List<MascotaModel> get mascotasVisibles {
    if (filtro == 'Perros') {
      return mascotas.where((m) => m.icono == '🐶').toList();
    } else if (filtro == 'Gatos') {
      return mascotas.where((m) => m.icono == '🐱').toList();
    } else if (filtro == 'Favoritas') {
      return favoritas;
    }
    return mascotas;
  }

  void seleccionarFiltro(String nuevoFiltro) {
    filtro = nuevoFiltro;
    notifyListeners();
  }

  bool esFavorita(MascotaModel mascota) => favoritas.contains(mascota);

  bool tieneInteres(MascotaModel mascota) => interesadas.contains(mascota);

  // Doble toque: agrega la mascota a favoritas o la quita si ya estaba.
  void alternarFavorita(MascotaModel mascota) {
    if (esFavorita(mascota)) {
      favoritas.remove(mascota);
    } else {
      favoritas.add(mascota);
    }
    notifyListeners();
  }

  void seleccionarMascota(MascotaModel mascota) {
    seleccionada = mascota;
    notifyListeners();
  }

  // Arrastrar: se llama cuando la foto se suelta en la zona "Me interesa".
  void marcarInteres(MascotaModel mascota) {
    if (!tieneInteres(mascota)) {
      interesadas.add(mascota);
      notifyListeners();
    }
  }

  void quitarInteres(MascotaModel mascota) {
    interesadas.remove(mascota);
    notifyListeners();
  }
}
