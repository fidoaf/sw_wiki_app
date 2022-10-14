import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// Display Web content in different ways
/// due to each platform's limitations:
/// - Android and iOS display the information in-app.
/// - Web opens a new window/tab.
/// - Desktop sends the URI to the default browser.
///
class WebViewerPage extends StatefulWidget {
  const WebViewerPage({super.key, required this.url, required this.name});

  final String url;
  final String name;

  @override
  State<WebViewerPage> createState() => _WebViewerPageState();
}

class _WebViewerPageState extends State<WebViewerPage> {
  Widget? _viewer;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url,
        mode: LaunchMode.externalApplication, webOnlyWindowName: widget.name)) {
      throw 'Could not launch $url';
    }
  }

  bool? _openNewWindow;
  Widget? getHtmlViewer(bool? openingMode) {
    switch (openingMode) {
      case true: // Opened in new window/tab
        // Return to the previous page
        Navigator.pop(context);
        return const Center(
            child: Text('Html content opened in new window/tab'));
      case false: // Rended web content using plugin
        return _viewer;
      default: // Rendering a web page is not possible in the current Platform
        return const Center(
            child: Text(
                'Rendering html content in current platform is not currently possible'));
    }
  }

  @override
  void initState() {
    super.initState();
    // Set the most suitable opening mode for each platform
    if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      _openNewWindow = true;
      _launchInBrowser(Uri.parse(widget.url));
    } else {
      if (Platform.isAndroid || Platform.isIOS) {
        _openNewWindow = false;
        _viewer = WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: getHtmlViewer(_openNewWindow),
    );
  }
}
