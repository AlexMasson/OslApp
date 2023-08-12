import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osl/model/programme.dart';
import 'package:osl/programe/programme_detail_component.dart';
import 'package:osl/repository/google_sheet_repository.dart';

class ProgrammeListComponent extends StatefulWidget {
  const ProgrammeListComponent({super.key});

  @override
  State<StatefulWidget> createState() => _ProgrammeListComponentState();
}

class _ProgrammeListComponentState extends State<ProgrammeListComponent> {
  List<Programme>? programmeList;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    EasyLoading.show();
    programmeList = await fetchProgrammeAsync();
    if (mounted) {
      EasyLoading.dismiss();
      super.setState(() {}); // to update widget data
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: programmeList?.length ?? 0,
        separatorBuilder: (context, index) {
          return const Divider(thickness: 0.4);
        },
        itemBuilder: (context, index) {
          return programmeList != null && programmeList!.isNotEmpty
              ? ListTile(
                  leading: const Icon(Icons.library_music, size: 30),
                  title: Text(programmeList![index].nom, style: const TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProgrammeDetailsComponent(programme: programmeList![index])));
                  },
                )
              : null;
        });
  }
}
