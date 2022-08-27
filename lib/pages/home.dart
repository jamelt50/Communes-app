import 'dart:io';

import 'package:communes/classes/city.dart';
import 'package:communes/pages/details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert' as convert;
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<City> items = [];
  bool firstSearch = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void fetchCities(city) async {
    setState(() {
      firstSearch = true;
    });

    var url = Uri.https('geo.api.gouv.fr', '/communes',{"nom":city,"fields":"nom,centre,codeRegion,codesPostaux,codeDepartement,population"});

    this.items = [];
    var response = await http.get(url);
    print(url);
    if (response.statusCode == 200) {
      List<dynamic> items = convert.jsonDecode(response.body);

      items.forEach((dynamic e) {
        setState(() {
          this.items.add(City.fromJson(e));
        });
      });

    }
  }

  String city = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Communes App"),
          backgroundColor: Colors.amber[900],
          actions: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/camera',
                  );
                },
                child: Icon(
                  Icons.photo_camera, // add custom icons also
                ),
              ),
            ),
          ]),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 70,
              color: Colors.amber[800],
              child: Form(
                key: _formKey,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          onSaved: (String? value) {
                            city = value ?? "";
                          },
                          decoration: const InputDecoration(
                            hintText: 'Entrer le nom de la ville',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();
                              fetchCities(city);
                            }
                          },
                          child: const Text('Submit'),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: items.isEmpty && firstSearch
                      ? [Lottie.asset('assets/lottie/loader.json')]
                      : items
                          .map<Widget>((e) => Container(
                                height: 50,
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Details(city: e),
                                        ))
                                  },
                                  child: Card(
                                    color: Colors.amber[900],
                                    child: Center(
                                        child: Text(
                                      e.nom,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ))
                          .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
