import 'package:flutter/material.dart';
import 'package:sw_app/model/data_service.dart';
import 'package:sw_app/view/choose_side.dart';
import 'package:sw_app/view/image_progess_indicator.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key, required this.title});

  final String title;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
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
        body: FutureBuilder(
      future: loadDataAssets(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          if (_complete) {
            return const ChooseSidePage(title: 'Choose your side');
          } else {
            return ImageProgressIndicator(
              label: backend.complete
                  ? 'Data complete!'
                  : 'Loading ${backend.currentAsset}...',
              imagepath: 'assets/images/bb8-clipart-hq.png',
              ratio: backend.ratio,
            );
          }
        }
      },
    ));
  }
}
