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
  int? _preferredSide;
  int? _chosenSide;

  Widget _createSideWidget(int currentSide) {
    final isDark = currentSide == 0;
    final double totalWidth = MediaQuery.of(context).size.width;
    final double sideOffset = totalWidth / 15;
    final double defaultContainerWidth = MediaQuery.of(context).size.width / 2;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _preferredSide = currentSide),
      onExit: (_) => setState(() => _preferredSide = null),
      child: GestureDetector(
        onTap: () {
          if (_chosenSide == null || _chosenSide != currentSide) {
            _chosenSide = currentSide;
            DynamicConfiguration.of(context).changeTheme(currentSide == 0);
          } else {
            _chosenSide = null;
            DynamicConfiguration.of(context).revertToDefault();
          }
        },
        child: Opacity(
          opacity:
              _preferredSide == null || _preferredSide == currentSide ? 1 : 0.7,
          child: AnimatedContainer(
            width: defaultContainerWidth +
                (_preferredSide == null
                    ? 0
                    : (_preferredSide == currentSide
                        ? sideOffset
                        : -sideOffset)),
            decoration: BoxDecoration(
              color: isDark ? Colors.black : Colors.white,
              border: Border.all(
                  color: Colors.red,
                  width: _chosenSide != null && _chosenSide == currentSide
                      ? 10.0
                      : 0),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: Image.asset(
              isDark
                  ? 'assets/images/imperial_emblem.webp'
                  : 'assets/images/jedi_emblem.png',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = DynamicConfiguration.of(context).isDark;
    String? subtitle = _chosenSide != null ? (isDark ? "SITH" : "JEDI") : null;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}${subtitle == null ? "" : ": $subtitle"}'),
      ),
      body: Center(
        child: Row(
          children: [
            _createSideWidget(0),
            _createSideWidget(1),
          ],
        ),
      ),
      // body: SizedBox(
      //   child: Row(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       Expanded(
      //           child: MouseRegion(
      //         cursor: SystemMouseCursors.click,
      //         child: GestureDetector(
      //           onTap: () {
      //             _choseSide = true;
      //             DynamicConfiguration.of(context).changeTheme(true);
      //           },
      //           child: Container(
      //             padding: const EdgeInsets.all(20),
      //             decoration: BoxDecoration(
      //               color: Colors.black,
      //               border: Border.all(
      //                   color: Colors.red,
      //                   width: _choseSide && isDark ? 10.0 : 0),
      //               borderRadius: const BorderRadius.all(Radius.circular(10)),
      //             ),
      //             child: Image.asset(
      //               'assets/images/imperial_emblem.webp',
      //             ),
      //           ),
      //         ),
      //       )),
      //       Expanded(
      //           child: MouseRegion(
      //         cursor: SystemMouseCursors.click,
      //         child: GestureDetector(
      //             onTap: () {
      //               _choseSide = true;
      //               DynamicConfiguration.of(context).changeTheme(false);
      //             },
      //             child: Container(
      //                 padding: const EdgeInsets.all(20),
      //                 decoration: BoxDecoration(
      //                     color: Colors.white,
      //                     border: Border.all(
      //                         color: Colors.green,
      //                         width: _choseSide && !isDark ? 10.0 : 0),
      //                     borderRadius:
      //                         const BorderRadius.all(Radius.circular(10))),
      //                 child: Image.asset(
      //                   'assets/images/jedi_emblem.png',
      //                 ))),
      //       ))
      //     ],
      //   ),
      // ),
      floatingActionButton: _chosenSide != null
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
