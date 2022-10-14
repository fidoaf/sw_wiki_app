import 'package:flutter/material.dart';

class ImageProgressIndicator extends StatelessWidget {
  const ImageProgressIndicator(
      {super.key,
      required this.label,
      required this.imagepath,
      required this.ratio});

  final String label;
  final String imagepath;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    bool isonline = imagepath.startsWith('http');
    return Container(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(children: [
          Text(
            label,
            style: const TextStyle(fontSize: 36),
          ),
          Opacity(
              opacity: 0.5,
              child: ClipRect(
                  child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 1 - ratio,
                child: isonline
                    ? Image.network(
                        imagepath,
                      )
                    : Image.asset(imagepath),
              ))),
          Opacity(
              opacity: 1,
              child: ClipRect(
                  child: Align(
                alignment: Alignment.bottomCenter,
                heightFactor: ratio,
                child: isonline
                    ? Image.network(imagepath)
                    : Image.asset(imagepath),
              ))),
        ]));
  }
}
