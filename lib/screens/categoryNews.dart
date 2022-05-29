import 'package:flutter/material.dart';

import '../helper/newsData.dart';
import '../helper/widgets.dart';

class CategoryNews extends StatefulWidget {
  final String newsCategory;

  const CategoryNews({Key? key, required this.newsCategory}) : super(key: key);

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  void getNews() async {
    NewsForCategory news = NewsForCategory();

    await news.getNewsForCategory(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(context),
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
        title: Text(
          widget.newsCategory.toUpperCase() + " NEWS",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7.0),
            child: Catlogo(context),
          ),
        ],
        backgroundColor: Colors.amber,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
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
                        category: widget.newsCategory.toUpperCase(),
                      );
                    }),
              ),
            ),
    );
  }
}
