import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsLatte/helper/widgets.dart';
import 'package:newsLatte/screens/categoryNews.dart';
import 'package:newsLatte/screens/recordedPage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../helper/categoryData.dart';
import '../helper/newsData.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _loading;
  var newslist;

  List<CategoryModel> categories = <CategoryModel>[];

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  void getPermissions() async {
    await Permission.location.request();
  }

  @override
  void initState() {
    getPermissions();
    _loading = true;
    super.initState();

    categories = getCategories();
    getNews();

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Allow Notifications'),
            content:
                const Text('NewsLatte would like to send you notifications.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Don\'t Allow',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        );
      }
    });
    AwesomeNotifications().createdStream.listen((notification) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Notification Created on ${notification.channelKey}',
        ),
      ));
    });

    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) =>
                  AwesomeNotifications().setGlobalBadgeCounter(value - 1),
            );
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const RecordedPages(),
        ),
        (route) => route.isFirst,
      );
    });
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AwesomeNotifications();
    return Scaffold(
      drawer: MyDrawer(context),
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
        title: logo(context),
        backgroundColor: Colors.purple,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),

                  /// Categories
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 70,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            imageAssetUrl: categories[index].imageAssetUrl,
                            categoryName: categories[index].categoryName,
                          );
                        }),
                  ),

                  /// News Article
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: ListView.builder(
                        itemCount: newslist.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return NewsTile(
                            imgUrl: newslist[index].urlToImage ?? "",
                            title: newslist[index].title ?? "",
                            desc: newslist[index].description ?? "",
                            content: newslist[index].content ?? "",
                            postUrl: newslist[index].postUrl ?? "",
                            publishedAt: newslist[index].publishedAt ?? "",
                            category: '',
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  const CategoryCard(
      {Key? key, required this.imageAssetUrl, required this.categoryName})
      : super(key: key);

  String makeCapital(String category) {
    var word = category.split("");

    word[0] = word.elementAt(0).toUpperCase();
    String temp = "";

    for (int a = 0; a < word.length; a++) {
      temp += word[a];
    }

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(
              newsCategory: categoryName,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26),
              child: Text(
                makeCapital(categoryName),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomePageButtons extends StatelessWidget {
  final Future<void> Function() onPressedOne;
  final Future<void> Function() onPressedTwo;
  final Future<void> Function() onPressedThree;
  const HomePageButtons({
    Key? key,
    required this.onPressedOne,
    required this.onPressedTwo,
    required this.onPressedThree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 20)),
                backgroundColor: MaterialStateProperty.all(
                  Colors.teal[600],
                ),
              ),
              onPressed: onPressedOne,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.dollarSign,
                    size: 14,
                    color: Colors.teal[50],
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const Text(
                    'Plant Food',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 20)),
                backgroundColor: MaterialStateProperty.all(
                  Colors.teal[600],
                ),
              ),
              onPressed: onPressedTwo,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.tint,
                    size: 14,
                    color: Colors.teal[50],
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const Text(
                    'Water',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 20)),
                backgroundColor: MaterialStateProperty.all(
                  Colors.teal[600],
                ),
              ),
              onPressed: onPressedThree,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidTimesCircle,
                    size: 14,
                    color: Colors.teal[50],
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
