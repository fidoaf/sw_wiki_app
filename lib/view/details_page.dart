import 'package:flutter/material.dart';
import 'package:sw_app/model/data_service.dart';
import 'package:sw_app/model/films_service.dart';
import 'package:sw_app/model/people_service.dart';
import 'package:sw_app/view/logo_progess_indicator.dart';
import 'package:sw_app/view/web_viewer_page.dart';

///
/// Use a FutureBuilder in order to retrieve the current character's
/// full data (on the roster we only have basic info).
///
class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.character});

  final Character character;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DataService.getFullCharacterData(widget.character),
        builder: (context, AsyncSnapshot<Character> snapshot) {
          if (snapshot.data == null) {
            return const LogoProgressIndicator();
          } else {
            Character char = snapshot.data as Character;
            String characterInfo =
                '${char.height == null ? "" : "${char.height}cm"} ${char.mass == null ? "" : "${char.mass}kg"}';
            String filmInfo = char.films!.fold(
                "",
                (String previousValue, Film element) =>
                    '$previousValue ${element.title}\n');
            String affInfo = char.affiliations.fold("",
                (String previousValue, String aff) => '$previousValue $aff\n');
            return Scaffold(
                appBar: AppBar(
                  title: Text(widget.character.name),
                ),
                // Expand the child widget to fill the entire parent
                body: Card(
                  elevation: 8,
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Image.network(widget.character.image ?? '')),
                      Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(widget.character.name),
                                  subtitle: Text(characterInfo),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: const Text('Appears in'),
                                  subtitle: Text(filmInfo),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: const Text('Affiliations'),
                                  subtitle: Text(affInfo),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                    tooltip: 'Read Wiki page',
                    child: const Icon(Icons.open_in_browser),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebViewerPage(
                            url: char.wiki ?? 'about:blank', name: 'Wiki page'),
                      ));
                    }));
          }
        });
  }
}
