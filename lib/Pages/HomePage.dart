import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsappus/Network/NewsServices.dart';
import 'package:newsappus/Pages/DetailsPage.dart';
import 'package:newsappus/constant.dart';

import '../Model/TopHeadlineNews.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentDate = '';
  Future<TopHeadline>? news;
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    news = Serviceapi.fetchTopNews();
    getCurrentDate();
  }

  void getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('d MMMM, y');
    setState(() {
      currentDate = formatter.format(now);
    });
  }

  void fetchNewsByCategory(String category) {
    setState(() {
      if (category == "All") {
        news = Serviceapi.fetchTopNews();
      } else {
        news = Serviceapi.fetchTopHeadlinesByCategory(category);
      }
    });
  }

  Future<void> _refreshNews() async {
    setState(() {
      if (selectedCategory == "All") {
        news = Serviceapi.fetchTopNews();
      } else {
        news = Serviceapi.fetchTopHeadlinesByCategory(selectedCategory!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'News Today',
                 style: GoogleFonts.abrilFatface(
                   textStyle: TextStyle(
                     color: Theme.of(context).primaryColor,
                     fontSize: 28,
                        fontWeight: FontWeight.bold

                   )
                 )
                 // TextStyle(
                //   color: Theme.of(context).primaryColor,
                //   fontSize: 28,
                //   fontWeight: FontWeight.bold
                // ),
              ),
              SizedBox(height:0),
              Text(
                currentDate,
                style: const TextStyle(
                  color: Color(0xFF616161),
                  fontSize: 15,
                ),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.zero,
              splashColor: Colors.transparent,
              onPressed: () {
                NEWSAPP.themeNotfifier.value =
                    NEWSAPP.themeNotfifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              },
              icon: Icon(NEWSAPP.themeNotfifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,))
        ],
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SizedBox(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Categories(
              width: width,
              height: height,
              onCategorySelected: fetchNewsByCategory,
            ),
            const ListTile(
              title: Text(
                'Latest News',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Most Recent at the moment',
                style: TextStyle(
                  color: Color(0xFF616161),
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshNews,
                child: FutureBuilder<TopHeadline>(
                  future: news,
                  builder: (context, AsyncSnapshot<TopHeadline> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.separated(
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: SizedBox(
                              width: width,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                        url: snapshot.data!.articles![index].url,
                                        urlToImage: snapshot
                                            .data!.articles![index].urlToImage,
                                        publishedAt: snapshot
                                            .data!.articles![index].publishedAt,
                                        description: snapshot
                                            .data!.articles![index].description,
                                        author: snapshot
                                            .data!.articles![index].author,
                                        title:
                                            snapshot.data!.articles![index].title,
                                        content: snapshot
                                            .data!.articles![index].content,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  color: Colors.white,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${snapshot.data!.articles![index].title}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1A237E),
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
                                          borderRadius: BorderRadius.circular(20),
                                          child: Image.network(
                                            snapshot.data!.articles![index]
                                                    .urlToImage ??
                                                'assets/not_found.png',
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
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(
                          height: 1.0,thickness: 2,

                          color: Color(0xFFE0E0E0),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('No news available.'),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      height: height*.2,
      child: ListView.builder(
        itemCount: AvatarItem.items.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 25),
        itemBuilder: (context, index) {
          final item = AvatarItem.items[index];
          return Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: GestureDetector(
              onTap: () {
                onCategorySelected(item.name);
              },
              child: Container(
              width: 90,
                height: 90,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    SizedBox(height: 8),
                    SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.name,
                            style:TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )
                          ),
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
