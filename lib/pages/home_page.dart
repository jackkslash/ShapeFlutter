import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shapeflutter/models/cocktail.dart';
import 'package:shapeflutter/pages/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Cocktail> _rndCocktail = [];
  String _cocktailName = "";
  String _cocktailInstruc = "";
  String _cocktailUrl = "";

  Future getCocktail() async {
    _rndCocktail.clear();
    var response = await http.get(
        Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/random.php'));
    var jsonData = jsonDecode(response.body);

    setState(() {
      for (var eachDrink in jsonData['drinks']) {
        final cocktail = Cocktail(
            idDrink: eachDrink['idDrink'],
            drinkName: eachDrink['strDrink'],
            drinkInstruc: eachDrink['strInstructions'],
            drinkUrl: eachDrink['strDrinkThumb']);
        _rndCocktail.add(cocktail);
      }
      _cocktailName = _rndCocktail[0].drinkName;
      _cocktailInstruc = _rndCocktail[0].drinkInstruc;
      _cocktailUrl = _rndCocktail[0].drinkUrl;
    });
  }

  @override
  void initState() {
    getCocktail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Cocktail Generator"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(top: 128.0, bottom: 64.0),
                  child: Text(
                    'Randomly Chosen Drink:',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Image.network(
                    _cocktailUrl,
                    height: 200,
                    width: 300,
                  )),
              Text(
                _cocktailName,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 128.0),
              child: FloatingActionButton.large(
                  onPressed: getCocktail,
                  tooltip: 'New Cocktail',
                  heroTag: "btn1",
                  child: const Text("Random Cocktail",
                      textAlign: TextAlign.center)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 128.0),
              child: FloatingActionButton.large(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                  name: _cocktailName,
                                  instruc: _cocktailInstruc,
                                  url: _cocktailUrl,
                                )));
                  },
                  tooltip: 'More Info',
                  heroTag: "btn2",
                  child: const Text("More Info", textAlign: TextAlign.center)),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .centerDocked // This trailing comma makes auto-formatting nicer for build methods.

        );
  }
}
