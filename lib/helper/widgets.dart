import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsLatte/helper/weather.dart';
import 'package:newsLatte/screens/localDatabase.dart';
import 'package:newsLatte/screens/recordedPage.dart';

import '../../login_main.dart';
import '../screens/articleView.dart';
import '../screens/homePage.dart';
import '../screens/profilePage.dart';
import '../screens/settingsPage.dart';

const String assetName = 'assets/images/newsLatteLogo.svg';

final Widget svg = SvgPicture.asset(
  assetName,
  semanticsLabel: 'News Latte Logo',
);

Future<void> createNewsNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: '${Emojis.hand_thumbs_up + Emojis.paper_newspaper} News Saved!!!',
      body: 'This news is saved to "Read Downloaded News" page.',
      bigPicture: 'asset://assets/newsLatteLogo.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

Widget logo(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    },
    child: Center(
      child: SvgPicture.asset(
        assetName,
        height: 58,
      ),
    ),
  );
}

Widget Emptylogo(BuildContext context) {
  return GestureDetector(
    onTap: () {},
    child: Center(
      child: SvgPicture.asset(
        assetName,
        height: 47,
      ),
    ),
  );
}

Widget Catlogo(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    },
    child: Center(
      child: SvgPicture.asset(
        assetName,
        height: 47,
      ),
    ),
  );
}

Widget MyDrawer(BuildContext context) {
  return Drawer(
    elevation: 1.5,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Center(
                child: Container(
                  color: Colors.purple,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 41.0, bottom: 41.0),
                    child: Center(
                      child: SvgPicture.asset(
                        assetName,
                        width: 230,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Center(
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
              ),
              ListTile(
                title: const Center(
                  child: Text(
                    'Read Downloaded News',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RecordedPages()));
                },
              ),
              ListTile(
                title: const Center(
                  child: Text(
                    'Read Later (Available Soon...)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Center(
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
              ),
              ListTile(
                title: const Center(
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()),
                  );
                },
              ),
              ListTile(
                title: const Center(
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                onTap: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginProcess()));
                },
              ),
            ],
          ),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Container(
            color: Colors.purple,
            height: 120,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: weather().getWeatherByLocation(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data.location + " ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            snapshot.data.temperature.toString() + "°",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

const String tableNewsTile = 'tableNewsTile';

class NewsTileFields {
  static final List<String> values = [
    //id,
    id, imgUrl, title, desc, content, category, publishedAt
  ];
  static const String id = '_id';
  static const String imgUrl = 'imgUrl';
  static const String title = 'title';
  static const String desc = 'desc';
  static const String content = 'content';

  //static const String postUrl = 'postUrl';
  static const String category = 'category';
  static const String publishedAt = 'publishedAt';
}

class NewsTileCopy extends StatefulWidget {
  final String imgUrl, title, desc, content, postUrl, category;

  final int? id;
  final publishedAt;

  const NewsTileCopy({
    this.id,
    required this.imgUrl,
    required this.desc,
    required this.title,
    required this.content,
    required this.postUrl,
    required this.publishedAt,
    required this.category,
  });

  @override
  State<NewsTileCopy> createState() => _NewsTileCopyState();
}

class _NewsTileCopyState extends State<NewsTileCopy> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleViewCopy(
              imgUrl: widget.imgUrl,
              title: widget.title,
              content: widget.content,
              postUrl: widget.postUrl,
              time: widget.publishedAt,
              category: widget.category,
            ),
          ),
        );
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CachedNetworkImage(
                            imageUrl: widget.imgUrl,
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: IconButton(
                              onPressed: () async {
                                await NewsDatabase.instance.delete(widget.id!);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecordedPages()),
                                );
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  widget.title,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.desc,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                )
              ],
            ),
          )),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, postUrl, category;

  final int? id;
  final publishedAt;

  const NewsTile({
    this.id,
    required this.imgUrl,
    required this.desc,
    required this.title,
    required this.content,
    required this.postUrl,
    required this.publishedAt,
    required this.category,
  });

  NewsTile copy({
    int? id,
    String? imgUrl,
    String? desc,
    String? title,
    String? content,
    String? postUrl,
    DateTime? publishedAt,
    String? category,
  }) =>
      NewsTile(
        id: id ?? this.id,
        imgUrl: imgUrl ?? this.imgUrl,
        desc: desc ?? this.desc,
        title: title ?? this.title,
        content: content ?? this.content,
        postUrl: postUrl ?? this.postUrl,
        publishedAt: publishedAt ?? this.publishedAt,
        category: category ?? this.category,
      );

  static NewsTile fromJson(Map<String, Object?> json) => NewsTile(
        id: json[NewsTileFields.id] as int?,
        imgUrl: json[NewsTileFields.imgUrl]! as String,
        desc: json[NewsTileFields.desc]! as String,
        title: json[NewsTileFields.title]! as String,
        content: json[NewsTileFields.content]! as String,
        postUrl: "",
        publishedAt: json[NewsTileFields.publishedAt]! as String,
        category: json[NewsTileFields.category]! as String,
      );

  Map<String, Object?> toJson() => {
        NewsTileFields.id: id,
        NewsTileFields.imgUrl: imgUrl,
        NewsTileFields.desc: desc,
        NewsTileFields.title: title,
        NewsTileFields.content: content,
        NewsTileFields.publishedAt: publishedAt,
        NewsTileFields.category: category,
      };

  Future addNew() async {
    final note = NewsTile(
        imgUrl: imgUrl,
        desc: desc,
        title: title,
        content: content,
        postUrl: postUrl,
        publishedAt: publishedAt,
        category: category);

    await NewsDatabase.instance.create(note);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              imgUrl: imgUrl,
              title: title,
              content: content,
              postUrl: postUrl,
              time: publishedAt,
              category: category,
            ),
          ),
        );
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.network(
                            imgUrl,
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: Favorite(
                              iconSize: 45,
                              iconColor: Colors.amber,
                              valueChanged: (_isFavorite) {},
                            ),
                          )
                        ],
                      ),
                      Stack(
                        children: <Widget>[
                          const Positioned(
                            left: 5,
                            top: 6,
                            child: Icon(
                              Icons.file_download,
                              size: 35,
                              color: Colors.black54,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              createNewsNotification();
                              addNew();
                            },
                            icon: const Icon(
                              Icons.file_download,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  title,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  desc,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                )
              ],
            ),
          )),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('publishedAt', publishedAt));
    properties.add(DiagnosticsProperty('publishedAt', publishedAt));
    properties.add(DiagnosticsProperty('publishedAt', publishedAt));
  }
}

class Favorite extends StatefulWidget {
  const Favorite({
    double? iconSize,
    Color? iconColor,
    Color? iconDisabledColor,
    bool? isFavorite,
    required Function valueChanged,
    Key? key,
  })  : _iconSize = iconSize ?? 60.0,
        _iconColor = iconColor ?? Colors.red,
        _iconDisabledColor = iconDisabledColor ?? Colors.white,
        _isFavorite = isFavorite ?? false,
        _valueChanged = valueChanged,
        super(key: key);

  final double _iconSize;
  final Color _iconColor;
  final bool _isFavorite;
  final Function _valueChanged;
  final Color? _iconDisabledColor;

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;

  late CurvedAnimation _curve;

  double _maxIconSize = 0.0;
  double _minIconSize = 0.0;

  final int _animationTime = 400;

  bool _isFavorite = false;
  bool _isAnimationCompleted = false;

  @override
  void initState() {
    super.initState();

    _isFavorite = widget._isFavorite;
    _maxIconSize = (widget._iconSize < 20.0)
        ? 20.0
        : (widget._iconSize > 100.0)
            ? 100.0
            : widget._iconSize;
    final double _sizeDifference = _maxIconSize * 0.30;
    _minIconSize = _maxIconSize - _sizeDifference;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationTime),
    );

    _curve = CurvedAnimation(curve: Curves.slowMiddle, parent: _controller);
    Animation<Color?> _selectedColorAnimation = ColorTween(
      begin: widget._iconColor,
      end: widget._iconDisabledColor,
    ).animate(_curve);

    Animation<Color?> _deSelectedColorAnimation = ColorTween(
      begin: widget._iconDisabledColor,
      end: widget._iconColor,
    ).animate(_curve);

    _colorAnimation = (_isFavorite == true)
        ? _selectedColorAnimation
        : _deSelectedColorAnimation;
    _sizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: _minIconSize,
            end: _maxIconSize,
          ),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: _maxIconSize,
            end: _minIconSize,
          ),
          weight: 50,
        ),
      ],
    ).animate(_curve);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isAnimationCompleted = true;
        _isFavorite = !_isFavorite;
        widget._valueChanged(_isFavorite);
      } else if (status == AnimationStatus.dismissed) {
        _isAnimationCompleted = false;
        _isFavorite = !_isFavorite;
        widget._valueChanged(_isFavorite);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        return InkResponse(
          onTap: () {
            setState(() {
              if (_isAnimationCompleted == true) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            });
          },
          child: Icon(
            (Icons.favorite),
            color: _colorAnimation.value,
            size: _sizeAnimation.value,
          ),
        );
      },
    );
  }
}
