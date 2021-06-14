
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Vehiculos vehiculosFromJson(String str) => Vehiculos.fromJson(json.decode(str));

String vehiculosToJson(Vehiculos data) => json.encode(data.toJson());

/* Clase que parsea los datos del backend */
class Vehiculos {
    Vehiculos({
        this.id,
        this.horaFin,
        this.tarifa,
        this.conductor,
        this.horaInicio,
        this.placa,
    });
    String id;
    String horaFin;
    String tarifa;
    String conductor;
    Timestamp horaInicio;
    String placa;

    factory Vehiculos.fromJson(Map<String, dynamic> json) => Vehiculos(
      
        horaFin: json["horaFin"],
        tarifa: json["tarifa"],
        conductor: json["conductor"],
        horaInicio: json["horaInicio"],
        placa: json["placa"],
    );

    Map<String, dynamic> toJson() => {
        "horaFin": horaFin,
        "tarifa": tarifa,
        "conductor": conductor,
        "horaInicio": horaInicio,
        "placa": placa,
    };
}
