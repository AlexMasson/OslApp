import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Bienvenue sur la nouvelle application interne de l\'Orchestre Symphonique de Lyon !'),
          const SizedBox(height: 10),
          const Text('Vous trouverez dans cette première version les éléments essentiels sur :'),
          const Text('\u2022 Les répétitions (lieux et programme).'),
          const Text('\u2022 Les concerts (lieux et programme).'),
          const Text('\u2022 Les oeuvres jouées (partitions et extraits audios).'),
          const SizedBox(height: 20),
          const Text(
            'Application consultable depuis mobile, tablette ou pc.',
            style: TextStyle(color: Colors.black45),
          ),
          const SizedBox(height: 30),
          Container(
              padding: const EdgeInsets.all(10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Liens externes', style: Theme.of(context).textTheme.titleLarge),
                const Divider(thickness: 0.4),
                Row(children: [
                  const Text('\u2022 Drive partitions'),
                  IconButton(
                      icon: const Icon(Icons.link),
                      onPressed: () => launchUrl(Uri.parse('https://drive.google.com/drive/folders/0B4HDAVad2lrtalVmX01zMWdLS1U')))
                ]),
                Row(children: [
                  const Text('\u2022 Trombinoscope'),
                  IconButton(
                      icon: const Icon(Icons.link),
                      onPressed: () => launchUrl(Uri.parse('https://drive.google.com/file/d/1berEUYaZ2uFsThjnoAEqVX6btew_fIi_/view?usp=share_link')))
                ]),
              ]))
        ]));
  }
}
