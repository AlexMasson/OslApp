import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: const Center(
            child: Column(children: [
          Text('Bienvenue sur l\'application de l\'OSL !'),
        ])));
  }
}
