import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          const Center(child: Column(children: [Text('Bienvenue sur l\'application de l\'OSL !')])),
          Container(
              padding: const EdgeInsets.all(10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Liens', style: Theme.of(context).textTheme.titleLarge),
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
