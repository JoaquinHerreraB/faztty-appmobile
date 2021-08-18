import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(home: HomePage()),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data;
  List productosData;
  getProductos() async {
    http.Response response = await http
        .get('http://faztty-back.herokuapp.com/faztty-ms/productosByNegocio/3');
    //debugPrint(response.body);
    data = json.decode(response.body);
    setState(() {
      productosData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getProductos();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text("P'acha"), backgroundColor: Colors.pink[900]),
        body: ListView.builder(
            itemCount: productosData == null ? 0 : productosData.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.arrow_drop_down_circle),
                      title: Text("${productosData[index]["nombre"]}"),
                      subtitle: Text(
                        "S./ ${productosData[index]["precio"]} \n${productosData[index]["marca"]} ",
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ),
                    Image.network(
                        'https://i.pinimg.com/originals/9e/ff/4e/9eff4e78a8ff0a9c7fa1881b2d2fc7c7.png',
                        width: 300,
                        height: 150,
                        fit: BoxFit.fill),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        FlatButton(
                          textColor: const Color.fromRGBO(199, 21, 133, 0.6),
                          onPressed: () {
                            // Perform some action
                          },
                          child: const Text('Eliminar',
                              style: TextStyle(fontSize: 20.0)),
                        ),
                        FlatButton(
                          textColor: const Color.fromRGBO(199, 21, 133, 0.6),
                          onPressed: () {
                            // Perform some action
                          },
                          child: const Text('Editar',
                              style: TextStyle(fontSize: 20.0)),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }));
  }
}
