import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sw_app/model/data_service.dart';
import 'package:sw_app/model/people_service.dart';
import 'package:sw_app/view/details_page.dart';
import 'package:sw_app/view/logo_progess_indicator.dart';

class RosterPage extends StatefulWidget {
  const RosterPage({super.key, required this.darkSide});

  final bool darkSide;

  @override
  State<RosterPage> createState() => _RosterPageState();
}

class _RosterPageState extends State<RosterPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        // show the confirm dialog
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title:
                      const Text('Are you sure you want to change allegiance?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          willLeave = true;
                          Navigator.of(context).pop();
                        },
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('No'))
                  ],
                ));
        return willLeave;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pick your character'),
        ),
        body: FutureBuilder(
            future: DataService.filterPeopleBySide(widget.darkSide),
            builder: (context, AsyncSnapshot<List<Character>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LogoProgressIndicator();
              } else {
                List<Character> people = snapshot.data ?? <Character>[];
                return GridView.builder(
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsPage(character: people[index]),
                                ),
                              );
                            },
                            child: Tooltip(
                                message: people[index].name,
                                child: GridTile(
                                    footer: Center(
                                        child: Text(people[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge)),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      alignment: Alignment.topCenter,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 5),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                        image: DecorationImage(
                                            fit: BoxFit.fitHeight,
                                            image: NetworkImage(
                                              people[index].image ?? '',
                                            )),
                                      ),
                                    )))));
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        max(MediaQuery.of(context).size.shortestSide ~/ 150, 0),
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                );
              }
            }),
      ),
    );
  }
}
