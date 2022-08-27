import 'package:flutter/material.dart';
import 'package:communes/classes/city.dart';
import 'package:communes/pages/map.dart';

class Details extends StatefulWidget {
  final City city;
  const Details({Key? key, required this.city}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState(this.city);
}

class _DetailsState extends State<Details> {
  final City city;
  _DetailsState(this.city);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(city.nom),
          backgroundColor: Colors.amber[900],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 34.00, 8.0, 34.00),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Center(
                      child: Text('Code: '),
                    ),
                    Center(child: Text(city.code))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Center(
                      child: Text('Code Departement: '),
                    ),
                    Center(child: Text(city.codeDepartement))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Center(
                      child: Text('Code Region: '),
                    ),
                    Center(child: Text(city.codeRegion))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Center(
                      child: Text('Population: '),
                    ),
                    Center(child: Text(city.population.toString()))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Center(
                      child: Text('Code Postaux: '),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                    children: city.codesPostaux
                        .map((e) => Card(
                            color: Colors.amber[900],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e,style: TextStyle(color: Colors.white),),
                            )))
                        .toList()),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,18.0,8.0,18.0),
                  child: ElevatedButton(
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Map(
                                latitude: city.centre.latitude,
                                longitude: city.centre.longitude),
                          ))
                    },
                    child: Text('Voir la carte'),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
