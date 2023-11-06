import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {super.key,
      required this.name,
      required this.instruc,
      required this.url});
  final String name;
  final String instruc;
  final String url;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Cocktail Details"),
          automaticallyImplyLeading: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Image.network(
                  widget.url,
                  height: 200,
                  width: 300,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.name,
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(widget.instruc),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 128.0),
              child: FloatingActionButton.large(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  tooltip: 'Return',
                  heroTag: "btn2",
                  child: const Text("Return", textAlign: TextAlign.center)),
            )
          ],
        ),
      ),
    );
  }
}
