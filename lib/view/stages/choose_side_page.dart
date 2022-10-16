import 'package:flutter/material.dart';
import 'package:sw_app/configuration/dynamic_configuration.dart';
import 'package:sw_app/view/character/roster_page.dart';

///
/// Dynamically change the theme of the application
/// depending on the side you choose
///
class ChooseSidePage extends StatefulWidget {
  const ChooseSidePage({super.key, required this.title});

  final String title;

  @override
  State<ChooseSidePage> createState() => _ChooseSidePageState();
}

class _ChooseSidePageState extends State<ChooseSidePage> {
  bool _choseSide = false;

  @override
  Widget build(BuildContext context) {
    bool isDark = DynamicConfiguration.of(context).isDark;
    String? subtitle = _choseSide ? (isDark ? "SITH" : "JEDI") : null;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}${subtitle == null ? "" : ": $subtitle"}'),
      ),
      body: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  _choseSide = true;
                  DynamicConfiguration.of(context).changeTheme(true);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                        color: Colors.red,
                        width: _choseSide && isDark ? 10.0 : 0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.asset(
                    'assets/images/imperial_emblem.webp',
                  ),
                ),
              ),
            )),
            Expanded(
                child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                  onTap: () {
                    _choseSide = true;
                    DynamicConfiguration.of(context).changeTheme(false);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.green,
                              width: _choseSide && !isDark ? 10.0 : 0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Image.asset(
                        'assets/images/jedi_emblem.png',
                      ))),
            ))
          ],
        ),
      ),
      floatingActionButton: _choseSide
          ? FloatingActionButton(
              tooltip: 'Confirm',
              child: const Icon(
                Icons.check,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RosterPage(
                      darkSide: isDark,
                    ),
                  ),
                );
              },
            )
          : Container(),
    );
  }
}
