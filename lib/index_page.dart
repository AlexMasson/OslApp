import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:osl/model/lien.dart';
import 'package:osl/repository/google_sheet_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<StatefulWidget> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<Lien>? liens;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    EasyLoading.show();
    liens = await fetchLiensAsync();
    if (mounted) {
      EasyLoading.dismiss();
      super.setState(() {}); // to update widget data
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView(physics: const AlwaysScrollableScrollPhysics(), padding: const EdgeInsets.all(15), children: [
          const Text('Bienvenue sur la nouvelle application interne de l\'Orchestre Symphonique de Lyon !'),
          const SizedBox(height: 10),
          const Text('Vous trouverez dans cette première version les éléments essentiels sur :'),
          const Text('• Les répétitions (lieux et programme).'),
          const Text('• Les concerts (lieux et programme).'),
          const Text('• Les oeuvres jouées (partitions et extraits audios).'),
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
                getLiens()
              ]))
        ]),
        onRefresh: () async {
          liens = await fetchLiensAsync();
          super.setState(() {}); // to update widget data
        });
  }

  Column getLiens() {
    if (liens == null || liens!.isEmpty) {
      return const Column(
        children: [Text('Aucun lien pour le moment.')],
      );
    }

    List<Widget> widgets = [];
    for (final lien in liens!) {
      widgets.add(Row(children: [
        Text('• ${lien.nom}'),
        IconButton(icon: const Icon(Icons.link), onPressed: () => launchLien(lien.url))
      ]));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  void launchLien(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) {
      EasyLoading.showError('Lien invalide.');
      return;
    }
    launchUrl(uri);
  }
}
