import 'package:flutter/material.dart';

import '../constant.dart';
class Categories extends StatelessWidget {

  const Categories({
    Key? key,
    required this.width,
    required this.height,
    required this.onCategorySelected,
  }) : super(key: key);

  final double width;
  final double height;
  final Function(String) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height * .2,
      child: ListView.builder(
        itemCount: AvatarItem.items.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 25),
        itemBuilder: (context, index) {
          final item = AvatarItem.items[index];
          return Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: GestureDetector(
              onTap: () {
                // categoryProvider.setCategory(item.name);

                onCategorySelected(item.name);
              },
              child: Container(
                width: 90,
                height: 90,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 1,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                        image: DecorationImage(
                          image: AssetImage(item.image),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item.name,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
