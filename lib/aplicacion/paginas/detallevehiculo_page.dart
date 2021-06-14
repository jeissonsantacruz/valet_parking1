import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:valet_parking1/aplicacion/paginas/finalizarparking_page.dart';
import 'package:valet_parking1/aplicacion/paginas/home_page.dart';
import 'package:valet_parking1/dominio/vehiculos_model.dart';



/*  Clase que contiene la vista de detalle del vehiculo */
class DetalleVehiculo extends StatefulWidget {
  final Vehiculos vehiculo;
  DetalleVehiculo(this.vehiculo);
  @override
  _DetalleVehiculoState createState() => _DetalleVehiculoState();
}

class _DetalleVehiculoState extends State<DetalleVehiculo> {


  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Color(0xFFFB6A14),
    minimumSize: Size(100, 36),
    padding: EdgeInsets.symmetric(horizontal: 10),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );

  // funcion que muestra alerta para pasar a registrar la hora de salida del vehiculo.
  _mostrarAlerta() {
    final size = MediaQuery.of(context).size;
    return Alert(
      context: context,
      title: "Finalizar Parking",
      desc: "¿Desea ingresar y finalizar la hora de salida?",
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
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FinalizarParking(widget.vehiculo, Timestamp.now())),
                ModalRoute.withName("homeUsuario")),
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
                        color: Colors.white, fontSize: size.width * 0.04),
                  )),
              Center(
                  child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.car,
                        color: Colors.white,
                      ),
                      title: Text(widget.vehiculo.placa,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.06)))),
              Center(
                  child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.clock,
                        color: Colors.white,
                      ),
                      title: Text(
                        hora.toString() + ' : ' + minutos + ' ' + horario,
                        style: TextStyle(
                            color: Colors.white, fontSize: size.width * 0.1),
                      ))),
              ListTile(
                  leading: Icon(
                    FontAwesomeIcons.idCard,
                    color: Colors.white,
                  ),
                  title: Text(
                    widget.vehiculo.conductor,
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * 0.06),
                  )),
              ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () => _mostrarAlerta(),
                child: Text('Finalizar Parking'),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
