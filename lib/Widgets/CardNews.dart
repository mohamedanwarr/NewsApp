import 'package:flutter/material.dart';
class CardNews extends StatelessWidget {
  CardNews({
    required this.text,required this.image,
    super.key,
  });
  String ?text;
  String ?image;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(

                "${text}"
                ,
                style:  TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(20),
              child: Image.network(
                "${image}",
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context,
                    Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    'assets/not found.png',
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

