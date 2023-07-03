import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Pages/DetailsPage.dart';
class HeaderDetails extends StatelessWidget {
   HeaderDetails({
    super.key,
    required this.height,
    required this.widget,
     required this.image,
     required this.title,
     required this.subtitle,
  });
  String ?image;
  String ?title;
  String ?subtitle;
  final double height;
  final DetailsPage widget;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width:width *double.infinity,
      height: height * .5,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              "$image"
            ),
            fit: BoxFit.cover,
            onError: (Object exception, StackTrace? stackTrace) {
              Image.asset(
                'assets/not found.png',
                fit: BoxFit.contain,
              );
            }),
        color: const Color(0xffbdbdbd),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 35, 24, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width=40,
                    height: height=40,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0x99f1f1f1),width: 2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(

                        border: Border.all(color: const Color(0x99f1f1f1),width: 2 ),
                        borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share_sharp,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height:170,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title',
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        // color: Color(0xFF1A237E),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "$subtitle",
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        // color: Colors.grey[800],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}