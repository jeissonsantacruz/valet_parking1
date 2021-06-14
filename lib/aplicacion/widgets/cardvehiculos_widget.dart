import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:valet_parking1/aplicacion/paginas/detallevehiculo_page.dart';
import 'package:valet_parking1/dominio/vehiculos_model.dart';

/* Clase Custom para mostrar la tarjeta de vehiculos en parking */
class CardVehiculo extends StatelessWidget {
  final Vehiculos vehiculo;
  CardVehiculo(this.vehiculo);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          print(vehiculo.id);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetalleVehiculo(vehiculo)));
        },
        child: Container(
          height: size.width * 0.25,
          child: Card(
              elevation: 2,
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.car,
                  color: Color(0xFFFB6A14),
                ),
                title: Text(
                  vehiculo.placa,
                  style: TextStyle(
                      color: Colors.black, fontSize: size.width * 0.06),
                ),
                subtitle: Text('\u{1F4CD}${vehiculo.conductor.toString()}'),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Color(0xFF0A2140),
                ),
              )),
        ));
  }
}
