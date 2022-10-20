import 'dart:convert';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parcial3/paginas/Description.dart';
import 'package:transition/transition.dart';
// import 'package:cached_network_image/cached_network_image.dart'; Las imagenes de la API no son compatibles con Flutter :(

class Home extends StatefulWidget {
  Home({Key ?key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  //API:
  var API = "www.freetogame.com/api/games?platform=pc";
  List Data = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ancho = MediaQuery.of(context).size.width;
    var alto = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(60, 60, 90, 100),
      body: Stack(
        children: [
          //Titulo
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              width: ancho,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Secret criminal DataBase", style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ],
              ),
            ),
          ),

          //TODO contenido:
          Positioned(
              top: 140,
              bottom: 0,
              width: ancho,
              child: Column(
                children: [
                  Data.length != null
                  ?  Expanded(
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 2.8
                        ),
                        itemCount: Data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(image: AssetImage("assets/images/carpeta.jpg"), fit: BoxFit.fill),
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 5),
                                  child: Row(
                                    children: [
                                      //Titulos:
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text("Age range: ", style: TextStyle(
                                            color: Colors.orangeAccent,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          )),
                                          Text("Location: ", style: TextStyle(
                                              color: Colors.orangeAccent,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          )),
                                          Text("Status: ", style: TextStyle(
                                              color: Colors.orangeAccent,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          )),
                                          Text("Description: ", style: TextStyle(
                                              color: Colors.orangeAccent,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ))
                                        ],
                                      ),

                                      //Datos
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 300,
                                            child: Text(Data[index]['title'], maxLines: 1,style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18)),
                                          ),
                                          Text(Data[index]['place_of_birth'] ?? "unknown"
                                              , style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18)),
                                          Text(Data[index]['status']=="na"?"Searching":Data[index]['status']
                                              , style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                          Container(
                                            width: 320,
                                            child: Text(Data[index]['description'], maxLines: 3
                                                , style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18))
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ),
                            ),
                            onTap: () {
                              //Mas detalles
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (_) => Description(detalles: Data[index])
                              ));
                            },
                          );
                        }
                    ),

                  ): const Center(
                    child: Text(
                      "NOT DATA", style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  )
                ],

              )
          )
        ],
      ),
    );
  }
  
  //Configuracion y obtencion de la api
  @override
  void initState() {
    super.initState();
    if (mounted) {
      gamesData();
    }
  }
  
  void gamesData() {
    var url = Uri.http("api.fbi.gov", "/wanted/v1/list");
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodejsonData = jsonDecode(value.body);
        Data = decodejsonData['items'];
        setState(() {

        });
      }
    });
  }
}