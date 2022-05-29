import 'package:flutter/material.dart';
import 'package:newsLatte/helper/widgets.dart';

import 'localDatabase.dart';

class RecordedPages extends StatefulWidget {
  const RecordedPages({Key? key}) : super(key: key);

  @override
  _RecordedPagesState createState() => _RecordedPagesState();
}

class _RecordedPagesState extends State<RecordedPages> {
  late bool _loading;
  late List<NewsTile> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    refreshNotes();
  }

  @override
  void dispose() {
    NewsDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    notes = await NewsDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
        leading: const BackButton(),
        title: const Text(
          "Downloaded News",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7.0),
            child: Emptylogo(context),
          ),
        ],
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: ListView.builder(
                  itemCount: notes.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NewsTileCopy(
                      category: notes[index].category,
                      publishedAt: notes[index].publishedAt,
                      content: notes[index].content,
                      title: notes[index].title,
                      desc: notes[index].desc,
                      imgUrl: notes[index].imgUrl,
                      postUrl: notes[index].postUrl,
                      id: notes[index].id,
                    );
                  }),
            ),
    );
  }
}
