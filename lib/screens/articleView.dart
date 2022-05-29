import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/widgets.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

class ArticleView extends StatefulWidget {
  final String imgUrl;
  final String title;
  final String content;
  final String postUrl;
  final String time;
  final String category;
  const ArticleView(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.content,
      required this.postUrl,
      required this.time,
      required this.category})
      : super(key: key);

  @override
  _ArticleViewState createState() =>
      _ArticleViewState(imgUrl, title, content, postUrl, time, category);
}

class _ArticleViewState extends State<ArticleView> {
  final String imgUrl;
  final String title;
  final String content;
  final String postUrl;
  final String time;
  final String category;
  _ArticleViewState(this.imgUrl, this.title, this.content, this.postUrl,
      this.time, this.category);

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
        title: logo(context),
        // leading: BackButton(),
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(
                Icons.share,
              ))
        ],
        backgroundColor: Colors.purple,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: Image.network(imgUrl),
                ),
                Positioned(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.bookmark,
                      color: Colors.white,
                    ),
                  ),
                  top: 10,
                  right: 10,
                ),
                Positioned(
                  top: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            addVerticalSpace(10),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.purple,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Colors.purple,
                        ),
                        addHorizontalSpace(7),

                        //published at part

                        Text(time,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            addVerticalSpace(10),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  wordSpacing: 2,
                  height: 1.5,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.web_outlined,
                        color: Colors.black54,
                      ),
                      addHorizontalSpace(7),
                      const Text("50",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: RichText(
                text: TextSpan(
                  text: content,
                  style: const TextStyle(
                    height: 2,
                    color: Colors.black45,
                  ),
                ),
              ),
              //content part

              // child: Text(
              //   content,
              //   softWrap: true,
              //   style: const TextStyle(
              //     height: 2,
              //     color: Colors.black45,
              //   ),
              // ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "For Details",
                softWrap: true,
                style: TextStyle(
                    height: 2,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            addVerticalSpace(10),
            Container(
              color: Colors.purple,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () => launch(postUrl),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        postUrl,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ArticleViewCopy extends StatefulWidget {
  final String imgUrl;
  final String title;
  final String content;
  final String postUrl;
  final String time;
  final String category;
  const ArticleViewCopy(
      {Key? key,
        required this.imgUrl,
        required this.title,
        required this.content,
        required this.postUrl,
        required this.time,
        required this.category})
      : super(key: key);

  @override
  _ArticleViewStateCopy createState() =>
      _ArticleViewStateCopy(imgUrl, title, content, postUrl, time, category);
}

class _ArticleViewStateCopy extends State<ArticleViewCopy> {
  final String imgUrl;
  final String title;
  final String content;
  final String postUrl;
  final String time;
  final String category;
  _ArticleViewStateCopy(this.imgUrl, this.title, this.content, this.postUrl,
      this.time, this.category);

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
        title: logo(context),
        // leading: BackButton(),
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(
                Icons.share,
              ))
        ],
        backgroundColor: Colors.purple,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: CachedNetworkImage(imageUrl:imgUrl),
                ),
                Positioned(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.bookmark,
                      color: Colors.white,
                    ),
                  ),
                  top: 10,
                  right: 10,
                ),
                Positioned(
                  top: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            addVerticalSpace(10),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.purple,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Colors.purple,
                        ),
                        addHorizontalSpace(7),

                        //published at part

                        Text(time,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            addVerticalSpace(10),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  wordSpacing: 2,
                  height: 1.5,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.web_outlined,
                        color: Colors.black54,
                      ),
                      addHorizontalSpace(7),
                      const Text("50",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: RichText(
                text: TextSpan(
                  text: content,
                  style: const TextStyle(
                    height: 2,
                    color: Colors.black45,
                  ),
                ),
              ),
              //content part

              // child: Text(
              //   content,
              //   softWrap: true,
              //   style: const TextStyle(
              //     height: 2,
              //     color: Colors.black45,
              //   ),
              // ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "For Details",
                softWrap: true,
                style: TextStyle(
                    height: 2,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            addVerticalSpace(10),
            Container(
              color: Colors.purple,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () => launch(postUrl),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        postUrl,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


