import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:valet_parking1/dominio/vehiculos_model.dart';

/* Clase que contiene los servicios para conectarse con el Backend ( Firebase) */
class ServiciosFirebase {
  //=============================================================================== POST BUSCAR USuARIO

  // funcion que obtiene todos los documentos de firebase
  Future<List<Vehiculos>> getVehiculos() async {
    List<Vehiculos> _vehiculos = [];
    List _ids = [];
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("vehiculos");

    QuerySnapshot vehiculos = await collectionReference.get();
    if (vehiculos.docs.isNotEmpty) {
      _vehiculos =
          vehiculos.docs.map((i) => Vehiculos.fromJson(i.data())).toList();
      for (var item in vehiculos.docs) {
        _ids.add(item.id);
      }

      for (int index = 0; index < _ids.length; index++) {
        _vehiculos[index].id = _ids[index];
      }
      return _vehiculos;
    }
    return _vehiculos;
  }

  // funcion que registar un vehiculo al valet parking
  Future agregarVehiculo(Vehiculos vehiculo) async {
    final vehiculoReference =
        FirebaseFirestore.instance.collection("vehiculos");

    vehiculoReference.add({
      "horaFin": vehiculo.horaFin,
      "tarifa": "0",
      "conductor": vehiculo.conductor,
      "horaInicio": vehiculo.horaInicio,
      "placa": vehiculo.placa,
    });
  }

  // funcion que actualiza los datos de vehiculo cuando el parking finaliza.
  Future pagarValor(Vehiculos vehiculo) async {
    final vehiculoReference =
        FirebaseFirestore.instance.collection("vehiculos");

    vehiculoReference.doc(vehiculo.id).update({
      "horaFin": vehiculo.horaFin,
      "tarifa": vehiculo.tarifa,
      "conductor": vehiculo.conductor,
      "horaInicio": vehiculo.horaInicio,
      "placa": vehiculo.placa,
    });
  }
}
