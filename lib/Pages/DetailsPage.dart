import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappus/Widgets/HeaderDetalis.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Widgets/ButtonBlue.dart';

class DetailsPage extends StatefulWidget {
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? title;
  final String? description;
  final String? author;
  final String? content;

  const DetailsPage({
    super.key,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.title,
    required this.description,
    required this.author,
    required this.content,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(onPageStarted: (url) {
        setState(() {
          loadingPercentage = 0;
        });
      }, onProgress: (progress) {
        setState(() {
          loadingPercentage = progress;
        });
      }, onPageFinished: (url) {
        setState(() {
          loadingPercentage = 100;
        });
      }))
      ..loadRequest(
        Uri.parse('${widget.url}'),
      );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      HeaderDetails(
        height: height,
        widget: widget,
        image: widget.urlToImage ?? 'assets/not found.png',
        title: '${widget.title}', subtitle: widget.author ?? "Unknown Author",
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.content == null || widget.content!.isEmpty ? "not found content" : widget.content}",
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  // color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Published AT : ${widget.publishedAt}",
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  // color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: width,
          height: height * .07,
          child: ButtonBlue(controller: controller),
        ),
      ),
    ])));
  }
}
