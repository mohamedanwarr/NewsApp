import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsappus/Pages/DetailsPage.dart';
import 'package:newsappus/Provider/ProviderApi.dart';
import 'package:newsappus/Provider/ProviderTheme.dart';

import 'package:provider/provider.dart';

import '../Model/TopHeadlineNews.dart';
import '../Widgets/CardNews.dart';
import '../Widgets/CategoryList.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentDate = '';
  String? selectedCategory;

  @override
  void initState() {
    super.initState();

    getCurrentDate();
  }

  void getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('d MMMM, y');
    setState(() {
      currentDate = formatter.format(now);
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
              Text('News Today',
                  style: GoogleFonts.abrilFatface(
                      textStyle: const TextStyle(
                          color: Color(0xFF1A237E),
                          fontSize: 28,
                          fontWeight: FontWeight.bold))),
              const SizedBox(height: 0),
              Text(
                currentDate,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
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
              onPressed: () => context.read<providertheme>().changetheme(),
              icon: Icon(
                NEWSAPP.themeNotfifier.value == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: Colors.amber,
              ))
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              onCategorySelected: (category) {
                context.read<CategoryProvider>().setCategory(category);
              },
            ),
            ListTile(
              title: Text(
                'Latest News',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Most Recent at the moment',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => context.read<CategoryProvider>().refreshNews(),
                child: Consumer<CategoryProvider>(
                  builder: (context, CategoryProvider, child) {
                    final news = CategoryProvider.news;
                    return FutureBuilder<TopHeadline>(
                      future: news,
                      builder: (context, AsyncSnapshot<TopHeadline> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                            url: snapshot
                                                .data!.articles![index].url,
                                            urlToImage: snapshot.data!
                                                .articles![index].urlToImage,
                                            publishedAt: snapshot.data!
                                                .articles![index].publishedAt,
                                            description: snapshot.data!
                                                .articles![index].description,
                                            author: snapshot
                                                .data!.articles![index].author,
                                            title: snapshot
                                                .data!.articles![index].title,
                                            content: snapshot
                                                .data!.articles![index].content,
                                          ),
                                        ),
                                      );
                                    },
                                    child: CardNews(
                                      text:
                                          '${snapshot.data!.articles![index].title}',
                                      image: snapshot.data!.articles![index]
                                              .urlToImage ??
                                          'assets/not_found.png',
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => const Divider(
                              height: 1.0,
                              thickness: 2,
                              color: Color(0xFFE0E0E0),
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text('No news available.'),
                          );
                        }
                      },
                    );
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
