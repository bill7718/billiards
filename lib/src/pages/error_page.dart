import 'package:flutter/material.dart';

///
/// Display a system exception
///
class BilliardsErrorPage extends StatelessWidget {
  const BilliardsErrorPage({Key? key, required this.error}) : super(key: key);

  final Error error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center( child: Text('Ooops Something Went Wrong'), )),
      body: Center(
        child: Column(
          children: [
            Container(margin: const EdgeInsets.all(25),
              child: const Text('An error has occurred. '),),
            Container(margin: const EdgeInsets.all(25),
            child: Text(error.toString()),)
          ],
        ),
      ),
    );
  }
}