import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:valet_parking1/aplicacion/paginas/home_page.dart';
import 'package:valet_parking1/arquitectura/servicios/firebase_service.dart';
import 'package:valet_parking1/dominio/vehiculos_model.dart';

/* Clase que contiene la vista para finalizar el parking  */
class FinalizarParking extends StatefulWidget {
  final Vehiculos vehiculo;
  final Timestamp horaFin;
  FinalizarParking(this.vehiculo, this.horaFin);
  @override
  _FinalizarParkingState createState() => _FinalizarParkingState();
}

class _FinalizarParkingState extends State<FinalizarParking> {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Color(0xFFFB6A14),
    minimumSize: Size(100, 36),
    padding: EdgeInsets.symmetric(horizontal: 10),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );
  // funcion ue calcula el valor a pagar por el parking.
  String _calcularPago() {
    int totalMinutos = widget.horaFin
        .toDate()
        .difference(widget.vehiculo.horaInicio.toDate())
        .inMinutes;
    double totalPagar = (totalMinutos / 60);
    String pagarH =
        (int.parse(totalPagar.toString().split(".")[0]) * 1).toString();
    int pagarM = (int.parse(totalPagar.toString().split(".")[1]).round());
    String total =
        pagarH + '.' + (pagarM * 0.0166667).toString().substring(1, 3);
    return total;
  }

  // funciion que envía los datos actualizados al backend.
  _finalizarParking() {
    ServiciosFirebase serviciosFirebase = ServiciosFirebase();
    Vehiculos vehiculo = Vehiculos(
        id: widget.vehiculo.id,
        conductor: widget.vehiculo.conductor,
        horaFin: widget.horaFin.toDate().toString(),
        tarifa: _calcularPago(),
        horaInicio: widget.vehiculo.horaInicio,
        placa: widget.vehiculo.placa);
    serviciosFirebase.pagarValor(vehiculo).then((value) =>
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            ModalRoute.withName("homeUsuario")));
  }

  _mostrarAlerta() {
    final size = MediaQuery.of(context).size;
    return Alert(
      context: context,
      title: "Pagar Parking",
      desc: "¿Desea  finalizar el parking",
      buttons: [
        DialogButton(
            child: Text(
              "No",
              style:
                  TextStyle(fontSize: size.width * 0.033, color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.redAccent[700]),
        DialogButton(
            child: Text(
              "Si",
              style:
                  TextStyle(fontSize: size.width * 0.033, color: Colors.white),
            ),
            onPressed: () => _finalizarParking(),
            color: Colors.greenAccent[700]),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int hora = widget.vehiculo.horaInicio.toDate().hour.toInt();
    String minutos = widget.vehiculo.horaInicio.toDate().minute.toString();
    String horario = hora > 12 ? ' P.M' : 'A.M';

    int horaS = widget.horaFin.toDate().hour.toInt();
    String minutosS = widget.horaFin.toDate().minute.toString();
    String horarioS = horaS > 12 ? ' P.M' : 'A.M';

    String total = _calcularPago();

    return Scaffold(
      appBar: AppBar(
          title: Text('Detalle Vehiculo',
              style: TextStyle(
                  fontSize: size.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A2140))),
          backgroundColor: Colors.white12,
          elevation: 0,
          leading: new IconButton(
              icon: new Icon(
                FontAwesomeIcons.chevronLeft,
                color: Color(0xFFFB6A14),
                size: size.width * 0.1,
              ),
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  ModalRoute.withName("homeUsuario")))),
      body: Column(children: <Widget>[
        Container(
          height: size.height * 0.4,
          child: Image.asset(
            'assets/images/undraw_city_driver_re_0x5e.png',
          ),
        ),
        Container(
          height: size.height * 0.52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0)),
            color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListTile(
                  title: Text(
                    'Valet Parking ',
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * 0.06),
                  ),
                  trailing: Text(
                    ' \$1 / hr',
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * 0.06),
                  )),
              ListTile(
                  leading: Text('Placa vehiculo :',
                      style: TextStyle(color: Colors.white)),
                  title: Text(
                    widget.vehiculo.placa,
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * 0.06),
                  )),
              ListTile(
                  leading: Text('Hora entrada :',
                      style: TextStyle(color: Colors.white)),
                  title: Text(
                    hora.toString() + ' : ' + minutos + ' ' + horario,
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * 0.06),
                  )),
              ListTile(
                  leading: Text(
                    'Hora salida :',
                    style: TextStyle(color: Colors.white),
                  ),
                  title: Text(
                    horaS.toString() + ' : ' + minutosS + ' ' + horarioS,
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * 0.06),
                  )),
              ListTile(
                  leading: Text(
                    'Conductor :',
                    style: TextStyle(color: Colors.white),
                  ),
                  title: Text(
                    widget.vehiculo.conductor,
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * 0.06),
                  )),
              ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () => _mostrarAlerta(),
                child: Text('Valor a pagar: \$  $total'),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
