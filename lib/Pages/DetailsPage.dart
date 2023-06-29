
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailsPage extends StatefulWidget {
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? title;
  final String? description;
  final String? author;
  final String? content;

  const DetailsPage({super.key,
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
var loadingPercentage=0;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
    ..setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url){
        setState(() {
          loadingPercentage = 0;
        });
      },
      onProgress: (progress){
        setState(() {
          loadingPercentage=progress;
        });
      },
      onPageFinished: (url){
        setState(() {
          loadingPercentage = 100;
        });
      }
    ))
      ..loadRequest(
        Uri.parse('${widget.url}'),
      );
  }

  void author() {
    setState(() {
      if (widget.author == null || widget.author!.isEmpty) {
        const Text('');
      } else {
        widget.author;
      }
    });
  }

  void poster() {
    setState(() {
      if (widget.urlToImage == null || widget.urlToImage!.isEmpty) {
        Image.asset("assets/not found.png");
      } else {
        widget.urlToImage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        // color: Colors.grey.withOpacity(0.3),
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      )
                    ],
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      )
                    ],
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width * 1,
            height: height * .4,
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                widget.urlToImage ?? 'assets/not found.png',
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    'assets/not found.png',
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Expanded(
                flex: 1,
                child: Text(
                  '${widget.title}',
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // color: Color(0xFF1A237E),
                    ),
                  ),
                ),
              )),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                  widget.author ?? "Unknown Author",
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      // color: Colors.grey[800],
                    ),
                  ),
                )),

                Text(
                  "${widget.publishedAt}",
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      // color: Colors.grey[800],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(
                "${widget.content == null || widget.content!.isEmpty ? "not found content" : widget.author}",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    // color: Colors.grey[700],
                  ),
                ),
              )),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: width,
              height: height * .07,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Webviwe(controller: controller),
                    ),

                  );
                },
                child: Text(
                  'Read More',
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Webviwe extends StatelessWidget {
  const Webviwe({
    super.key,
    required this.controller,
  });

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text
        ('Web Viwe'),
        centerTitle: true,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

