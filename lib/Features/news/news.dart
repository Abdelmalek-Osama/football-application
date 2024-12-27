import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lab2/Custom-widgets/customtext.dart';
import 'package:flutter_lab2/constants.dart';
import 'package:flutter_lab2/Features/news/newsmodel.dart';
import 'package:flutter_lab2/Features/news/todaynews.dart';
import 'package:intl/intl.dart';

import '../../Custom-widgets/custom_app_bar.dart';

class NewsScreen extends StatelessWidget {
  final Todaynews todayNewsRepo;
  const NewsScreen({super.key, required this.todayNewsRepo});
  Future<List<News>> fetchMatches() async {
    return await todayNewsRepo.getTodayNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: CustomAppBar(title: 'Today\'s News'),
        body: FutureBuilder<List<News>>(
            future: fetchMatches(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                if (kDebugMode) {
                  print(snapshot.error);
                }
                return const Center(child: Text("Failed to load news"));
              } else if (snapshot.hasData) {
                final newsList = snapshot.data!;
                return ListView(children: [
                  ...List.generate(newsList.length, (index) {
                    String date = newsList[index].publishDate.toString();
                    DateTime dateTime = DateTime.parse(date);
                    String formattedDateTime =
                        DateFormat('h:mm a').format(dateTime);
                    return Center(
                        child: Card(
                            color: cardBackgroundColor,
                            margin: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  newsList[index].image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(10)),
                                          child: Image.network(
                                            newsList[index].image!,
                                            height: 200,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                child: Icon(Icons.broken_image,
                                                    size: 50,
                                                    color: Colors.grey),
                                              );
                                            },
                                          ),
                                        )
                                      : const SizedBox(height: 200),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomText(
                                        text:
                                            newsList[index].title ?? 'No Title',
                                        isBold: true,
                                        fontSize: 16,
                                        colours: primaryTextColor),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8.0),
                                    child: CustomText(
                                      text: 'Published at: $formattedDateTime ',
                                      fontSize: 14,
                                      colours: primaryTextColor,
                                      isBold: false,
                                    ),
                                  ),
                                ])));
                  })
                ]);
              } else {
                return const Center(child: Text("No news available"));
              }
            }));
  }
}
