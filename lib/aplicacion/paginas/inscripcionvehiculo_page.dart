import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:valet_parking1/aplicacion/paginas/home_page.dart';
import 'package:valet_parking1/arquitectura/servicios/firebase_service.dart';
import 'package:valet_parking1/dominio/vehiculos_model.dart';

/* Clase que muestra el registro del vehiculo y el conductor para el valet parking */
class RegistrarVehiculo extends StatefulWidget {
  @override
  _RegistrarVehiculoState createState() => _RegistrarVehiculoState();
}

class _RegistrarVehiculoState extends State<RegistrarVehiculo> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _placaController = new TextEditingController();
  TextEditingController _nombreController = new TextEditingController();
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Color(0xFFFB6A14),
    minimumSize: Size(100, 36),
    padding: EdgeInsets.symmetric(horizontal: 10),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );

  // funcion que  toma la hora del dispositivo y los datos del formulario.
  _guardarVehiculo() async {
    ServiciosFirebase serviciosFirebase = ServiciosFirebase();

    Vehiculos vehiculo = Vehiculos(
        conductor: _nombreController.text,
        placa: _placaController.text,
        horaInicio: Timestamp.now());
    if (formkey.currentState.validate()) {
      serviciosFirebase.agregarVehiculo(vehiculo).then((value) =>
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              ModalRoute.withName("homeUsuario")));
    }
  }

  _mostrarAlerta() {
    final size = MediaQuery.of(context).size;
    return Alert(
      context: context,
      title: "Registrar vehiculo",
      desc: "¿Desea  registrar  el parking",
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
            onPressed: () => _guardarVehiculo(),
            color: Colors.greenAccent[700]),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
            title: Text('Ingresar Vehiculo',
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset(
                  'assets/images/undraw_city_driver_re_0x5e.png',
                ),
              ),
              Form(
                  autovalidateMode: AutovalidateMode
                      .onUserInteraction, //check for validation while typing
                  key: formkey,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          size.width * 0.1, 0, size.width * 0.1, 0),
                      child: Column(children: <Widget>[
                        TextFormField(
                            controller: _placaController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  FontAwesomeIcons.car,
                                  color: Color(0xFFFEDD7C),
                                ),
                                labelText: 'Placa',
                                hintText: 'Ingrese la placa'),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Requerido"),
                            ])),
                        TextFormField(
                            controller: _nombreController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  FontAwesomeIcons.user,
                                  color: Color(0xFFFEDD7C),
                                ),
                                labelText: 'Conductor',
                                hintText: 'Ingrese el conductor'),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Requerido"),
                            ])),
                      ]))),
              ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () => _mostrarAlerta(),
                child: Text('Ingresar vehiculo '),
              ),
            ],
          ),
        ));
  }
}
