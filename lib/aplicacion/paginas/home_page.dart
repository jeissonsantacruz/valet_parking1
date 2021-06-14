// Flutter dependencies
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:valet_parking1/aplicacion/paginas/inscripcionvehiculo_page.dart';
import 'package:valet_parking1/aplicacion/widgets/cardvehiculos_widget.dart';
import 'package:valet_parking1/arquitectura/servicios/firebase_service.dart';
import 'package:valet_parking1/dominio/vehiculos_model.dart';


/* Clase principal de la app +, donde muestra los vehiculos que estan en parking ( sin finalizar) */
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ServiciosFirebase servicioFirebase = ServiciosFirebase();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        refresh();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Valet Parking App',
              style: TextStyle(
                  fontSize: size.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          backgroundColor: Colors.orangeAccent,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(children: <Widget>[
            Expanded(
              child: FutureBuilder(
                  future: servicioFirebase.getVehiculos(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Vehiculos>> snapshot) {
                    if (snapshot.hasData) {
                      final vehiculos = snapshot.data;
                      return ListView.builder(
                          itemCount: vehiculos.length,
                          itemBuilder: (context, index) =>
                              vehiculos[index].tarifa != "0"
                                  ? Container()
                                  : CardVehiculo(vehiculos[index]));
                    } else {
                      return Center(
                        child: ListTile(
                            title: Text(
                              'Ups! aún no  tienes vehiculos a cargo!',
                              style: TextStyle(fontSize: 20),
                            ),
                            leading: Icon(
                              FontAwesomeIcons.sadTear,
                              color: Colors.redAccent[700],
                            )),
                      );
                    }
                  }),
            )
          ]),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.of(context)
              .push(new MaterialPageRoute(builder: (BuildContext context) {
            return RegistrarVehiculo();
          })),
          icon: Icon(
            Icons.add,
            color: Color(0xFFFB6A14),
          ),
          label: Text(
            "Ingresar",
            style: TextStyle(
                color: Color(0xFFFB6A14), fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  refresh() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
    Navigator.of(context).pop();
  }
}
