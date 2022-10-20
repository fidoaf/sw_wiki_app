import 'package:flutter/material.dart';
import 'package:sw_app/model/data_service.dart';
import 'package:sw_app/view/stages/choose_side_page.dart';

import 'package:sw_app/view/loader/custom_progress_indicator.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.title});

  final String title;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

///
/// Load all the required data
/// json file assets in these case,
/// evethough the information could be easily retrieved
/// from a webservice, just changing the DataService class.
class _LandingPageState extends State<LandingPage> {
  bool _complete = false;

  final DataService backend = DataService();

  Future<void> loadDataAssets(BuildContext context) async {
    int? next = await backend.loadNextAsset(context);
    if (next != null) {
      setState(() {
        _complete = backend.complete;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: FutureBuilder(
      future: loadDataAssets(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else {
          if (_complete) {
            return const ChooseSidePage(title: 'Choose your side');
          } else {
            return Column(children: <Widget>[
              Expanded(
                  child: ImageProgressIndicator(
                label: backend.complete
                    ? 'Data complete!'
                    : 'Loading ${backend.currentAsset}...',
                imagepath: 'assets/images/bb8-clipart-hq.png',
                ratio: backend.ratio,
              ))
            ]);
          }
        }
      },
    ))));
  }
}
