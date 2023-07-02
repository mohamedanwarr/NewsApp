import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Webviwe extends StatefulWidget {
  const Webviwe({
    super.key,
    required this.controller,
  });

  final WebViewController controller;

  @override
  State<Webviwe> createState() => _WebviweState();
}

class _WebviweState extends State<Webviwe> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text
        ('Web Viwe'),
        centerTitle: true,
      ),
      body: WebViewWidget(
        controller: widget.controller,
      ),
    );
  }
}

