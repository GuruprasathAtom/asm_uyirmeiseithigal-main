// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, prefer_const_constructors, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, deprecated_member_use, prefer_const_declarations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uyirmeiseithigal/categorynews.dart';
import 'package:uyirmeiseithigal/gallery.dart';
import 'package:uyirmeiseithigal/joiningpage.dart';
import 'package:uyirmeiseithigal/seithipirivu.dart';

import 'package:uyirmeiseithigal/tags.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Related extends StatefulWidget {
  var index;
  var jsonList;
  var categoryjsonList;
  var relatednewsjsonList;
  var galleryresponselist;
  Related({
    super.key,
    required this.index,
    required this.jsonList,
    required this.categoryjsonList,
    required this.relatednewsjsonList,
    required this.galleryresponselist,
  });
  @override
  State<Related> createState() => _RelatedState();
}

class _RelatedState extends State<Related> {
  late YoutubePlayerController _controller;
  final ScrollController _scrollController = ScrollController();
  bool _isAtTop = true;
  bool tagsvisibiity = true;
  Color homecolor = Colors.white;
  Color seithigalcolor = Colors.white;
  Color cinemacolor = Colors.white;
  Color vilaiyatucolor = Colors.white;
  Color anmigamcolor = Colors.white;
  Color puthagamcolor = Colors.white;
  bool isRedContainerClicked = false;
  bool seithigalvisibility = false;
  bool cinemavisibility = false;
  bool anmigamvisibility = false;
  bool vilaiyatuvisibility = false;
  bool puthagangalvisibility = false;
  bool webstoriesvisibility = false;
  bool tvvisibility = false;
  bool isOpen = true;
  List<Color> redtowhitetextcolor = [];
  List<Color> categorycontainercolor = [];
  List<Color> redtowhitesubcategorycolor = [];
  List<Color> subcategorycontainercolor = [];
  List<bool> _subcategoryVisibilityList = [];
  bool showFullContent = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _scrollController.addListener(_scrollListener);

    redtowhitetextcolor = List.filled(
      1000,
      Colors.black,
    );
    _subcategoryVisibilityList = List<bool>.filled(100, false);
    categorycontainercolor = List.filled(
      1000,
      Colors.white,
    );

    subcategorycontainercolor = List.filled(
      1000,
      Colors.white,
    );

    redtowhitesubcategorycolor = List.filled(
      1000,
      Colors.black,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset == 0) {
      setState(() {
        _isAtTop = true;
      });
    } else {
      setState(() {
        _isAtTop = false;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _incrementIndex() {
    setState(() {
      if (widget.index < 8) {
        widget.index++;
        showFullContent = false;
      }
    });
  }

  void _decrementIndex() {
    setState(() {
      if (widget.index > 0) {
        widget.index--;
        showFullContent = false;
      }
    });
  }

  void changeContainerColor(int index) {
    setState(() {
      homecolor = (index == 0) ? Colors.red : Colors.white;
      seithigalcolor = (index == 1) ? Colors.red : Colors.white;
      cinemacolor = (index == 2) ? Colors.red : Colors.white;
      vilaiyatucolor = (index == 3) ? Colors.red : Colors.white;
      anmigamcolor = (index == 4) ? Colors.red : Colors.white;
      puthagamcolor = (index == 5) ? Colors.red : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.relatednewsjsonList == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/uyirmeimainlogo.jpg',
                width: 300,
                height: 100,
              ),
            ),
            CircularProgressIndicator(),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            _decrementIndex();
          } else {
            _incrementIndex();
          }
        },
        child: GestureDetector(
          onTap: () {
            print("objects");
            changeContainerColor(0);
            homecolor = Colors.white;
            seithigalcolor = Colors.white;
            cinemacolor = Colors.white;
            vilaiyatucolor = Colors.white;
            anmigamcolor = Colors.white;
            puthagamcolor = Colors.white;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 80,
              shape: Border(bottom: BorderSide(color: Colors.blue)),
              leading: Builder(
                builder: (BuildContext context) {
                  return Material(
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: IconButton(
                      color: Colors.blue,
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: 'Categories',
                    ),
                  );
                },
              ),
              title: Container(
                width: 240,
                height: 100,
                child: CachedNetworkImage(
                  imageUrl: widget.categoryjsonList["logoUrl"],
                ),
              ),
            ),
            onDrawerChanged: (isOpened) {
              if (isOpened == false) {
                print("dfs");
                changeContainerColor(0);
                _subcategoryVisibilityList = List.filled(100, false);
                redtowhitesubcategorycolor = List.filled(1000, Colors.black);
                subcategorycontainercolor = List.filled(1000, Colors.white);
                redtowhitetextcolor = List.filled(1000, Colors.black);
                categorycontainercolor = List.filled(1000, Colors.white);
                homecolor = Colors.white;
                seithigalcolor = Colors.white;
                cinemacolor = Colors.white;
                vilaiyatucolor = Colors.white;
                anmigamcolor = Colors.white;
                puthagamcolor = Colors.white;
              }
            },
            drawer: Drawer(
                backgroundColor: Colors.white,
                width: 225,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Column(children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close))),
                      Container(
                        width: 300,
                        height: 40,
                        child: CachedNetworkImage(
                          imageUrl: widget.categoryjsonList["logoUrl"],
                        ),
                      ),
                      // Text(categoryjsonList["navigation"].length.toString()),
                      InkWell(
                          onTap: () {
                            setState(() {
                              isRedContainerClicked = true;
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => MyHomePage(),
                              //     )).then((value) {
                              //   setState(() {
                              //     isRedContainerClicked = false;
                              //     _subcategoryVisibilityList =
                              //         List.filled(100, false);
                              //   });
                              //   Navigator.of(context).pop();
                              //   redtowhitesubcategorycolor =
                              //       List.filled(1000, Colors.black);
                              //   subcategorycontainercolor =
                              //       List.filled(1000, Colors.white);
                              //   redtowhitetextcolor =
                              //       List.filled(1000, Colors.black);
                              //   categorycontainercolor =
                              //       List.filled(1000, Colors.white);
                              // });
                            });
                          },
                          child: Container(
                            color: isRedContainerClicked
                                ? Colors.red
                                : Colors.white,
                            height: 40,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: Text(
                                    'முகப்பு',
                                    style: TextStyle(
                                        color: isRedContainerClicked
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                )),
                          )),
                      Container(
                        height: 0,
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      ListView.builder(
                          padding: EdgeInsets.only(top: 0.0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              widget.categoryjsonList["navigation"].length,
                          itemBuilder: (context, indexa) {
                            return Container(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        print(indexa);
                                        redtowhitetextcolor = List.filled(
                                          1000,
                                          Colors.black,
                                        );
                                        categorycontainercolor = List.filled(
                                          1000,
                                          Colors.white,
                                        );
                                        _subcategoryVisibilityList =
                                            List<bool>.filled(100, false);

                                        categorycontainercolor[indexa] =
                                            (categorycontainercolor[indexa] ==
                                                    Colors.white)
                                                ? Colors.red
                                                : Colors.white;

                                        redtowhitetextcolor[indexa] =
                                            (redtowhitetextcolor[indexa] ==
                                                    Colors.black)
                                                ? Colors.white
                                                : Colors.black;
                                        //if (subcategorycolor ==
                                        //    Colors.white) {
                                        //  subcategorycolor =
                                        //      Colors.red;
                                        //} else {
                                        //  subcategorycolor =
                                        //      Colors.white;
                                        //}
                                        _subcategoryVisibilityList[indexa] =
                                            !_subcategoryVisibilityList[indexa];
                                        redtowhitesubcategorycolor =
                                            List.filled(1000, Colors.black);
                                        subcategorycontainercolor =
                                            List.filled(1000, Colors.white);
                                      });
                                    },
                                    child: Container(
                                        height: 40,
                                        color: categorycontainercolor[indexa],
                                        child: DefaultTextStyle(
                                          style: TextStyle(
                                            color: redtowhitetextcolor[indexa],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24.0, right: 24.0),
                                            child: Container(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        widget.categoryjsonList[
                                                                "navigation"]
                                                            [indexa]["name"],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: null,
                                                        softWrap: true,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color:
                                                          redtowhitetextcolor[
                                                              indexa],
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        )),
                                  ),
                                  Container(
                                    height: 0,
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Visibility(
                                    visible: _subcategoryVisibilityList[indexa],
                                    child: ListView.builder(
                                        padding: EdgeInsets.only(top: 0.0),
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: widget
                                            .categoryjsonList["navigation"]
                                                [indexa]["subcategories"]
                                            .length,
                                        itemBuilder: (context, indexs) {
                                          return Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0),
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        print(indexs);
                                                        print(indexa);
                                                        Navigator.of(context)
                                                            .pop();
                                                        redtowhitesubcategorycolor =
                                                            List.filled(1000,
                                                                Colors.black);
                                                        subcategorycontainercolor =
                                                            List.filled(1000,
                                                                Colors.white);
                                                        subcategorycontainercolor[
                                                                indexs] =
                                                            (subcategorycontainercolor[
                                                                        indexs] ==
                                                                    Colors
                                                                        .white)
                                                                ? Colors.red
                                                                : Colors.white;

                                                        redtowhitesubcategorycolor[
                                                                indexs] =
                                                            (redtowhitesubcategorycolor[
                                                                        indexs] ==
                                                                    Colors
                                                                        .black)
                                                                ? Colors.white
                                                                : Colors.black;
                                                      });
                                                      redtowhitetextcolor =
                                                          List.filled(
                                                        1000,
                                                        Colors.black,
                                                      );
                                                      categorycontainercolor =
                                                          List.filled(
                                                        1000,
                                                        Colors.white,
                                                      );
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CategoryPage(
                                                            categorylength:
                                                                indexa,
                                                            subcategorylength:
                                                                indexs,
                                                            categoryjsonList: widget
                                                                .categoryjsonList,
                                                            jsonList:
                                                                widget.jsonList,
                                                            relatednewsjsonList:
                                                                widget
                                                                    .relatednewsjsonList,
                                                            galleryresponselist:
                                                                widget
                                                                    .galleryresponselist,
                                                          ),
                                                        ),
                                                      ).then((value) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        _subcategoryVisibilityList =
                                                            List.filled(
                                                                100, false);
                                                        // Reset all colors to initial state here
                                                        redtowhitesubcategorycolor =
                                                            List.filled(1000,
                                                                Colors.black);
                                                        subcategorycontainercolor =
                                                            List.filled(1000,
                                                                Colors.white);
                                                        redtowhitetextcolor =
                                                            List.filled(1000,
                                                                Colors.black);
                                                        categorycontainercolor =
                                                            List.filled(1000,
                                                                Colors.white);
                                                      });
                                                    },
                                                    child: Container(
                                                        height: 40,
                                                        color:
                                                            subcategorycontainercolor[
                                                                indexs],
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 24.0),
                                                          child: Row(children: [
                                                            Text(
                                                              widget.categoryjsonList[
                                                                              "navigation"]
                                                                          [
                                                                          indexa]
                                                                      [
                                                                      "subcategories"]
                                                                  [
                                                                  indexs]["name"],
                                                              style: TextStyle(
                                                                color:
                                                                    redtowhitesubcategorycolor[
                                                                        indexs],
                                                              ),
                                                            ),
                                                          ]),
                                                        )),
                                                  ),
                                                  Container(
                                                    height: 0,
                                                    child: Divider(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            );
                          }),
                      InkWell(
                        onTap: () {
                          isRedContainerClicked = true;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JoiningPage(
                                      jsonList: widget.jsonList,
                                      relatednewsjsonList:
                                          widget.relatednewsjsonList,
                                      categoryjsonList: widget.categoryjsonList,
                                      galleryresponselist:
                                          widget.galleryresponselist,
                                    )),
                          ).then((value) {
                            isRedContainerClicked = false;
                            Navigator.of(context).pop();
                          });
                        },
                        child: Container(
                          color:
                              isRedContainerClicked ? Colors.red : Colors.white,
                          height: 40,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 24.0),
                                child: Text(
                                  'நீங்களும் நிருபர் ஆகலாம்',
                                  style: TextStyle(
                                      color: isRedContainerClicked
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              )),
                        ),
                      ),
                    ]),
                  ),
                )
                //ListView(
                //  padding: EdgeInsets.zero,
                //  children: [
                //    ListTile(
                //      title: Container(
                //        width: 180,
                //        height: 180,
                //        child: CachedNetworkImage(
                //          progressIndicatorBuilder: (context, url, progress) =>
                //              CircularProgressIndicator(
                //            value: progress.progress,
                //          ),
                //          imageUrl:
                //              'https://uyirmeiseithigal.com/assets/img/logo/uyirmei-logo.png',
                //        ),
                //      ),
                //    ),
                //    ListTile(
                //      title: Text('Home'),
                //    ),
                //    ListTile(
                //      title: Text(categoryjsonList["navigation"][0]["name"]),
                //    )
                //  ],
                //),
                ),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         shareToFacebook(relatednewsjsonList["posts"]
                    //             [widget.index]["title"]);
                    //       },
                    //       child: SocialIcon(
                    //           imagePath: 'assets/images/facebook_icon.png'),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         shareToLinkedIn(relatednewsjsonList["posts"]
                    //             [widget.index]["title"]);
                    //       },
                    //       child: SocialIcon(
                    //           imagePath: 'assets/images/linkedln_icon.png'),
                    //     ),
                    //     //InkWell(
                    //     //    onTap: () {
                    //     //      shareToYouTube(relatednewsjsonList["posts"]
                    //     //          [widget.index]["title"]);
                    //     //    },
                    //     //    child: SocialIcon(
                    //     //        imagePath: 'assets/images/youtube_icon.png')),
                    //     InkWell(
                    //         onTap: () {
                    //           shareToTwitter(relatednewsjsonList["posts"]
                    //               [widget.index]["title"]);
                    //         },
                    //         child: SocialIcon(
                    //             imagePath: 'assets/images/twitter_icon.png')),
                    //     InkWell(
                    //       onTap: () {
                    //         shareToWhatsApp(relatednewsjsonList["posts"]
                    //             [widget.index]["title"]);
                    //       },
                    //       child: SocialIcon(
                    //           imagePath: 'assets/images/whatsapp_icon.png'),
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        child: Image.asset('assets/images/advertisement.jpg'),
                      ),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              widget.relatednewsjsonList["posts"][widget.index]
                                  ["subcategory"]["name"],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                            height: 0, child: Divider(color: Colors.blue)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.relatednewsjsonList["posts"][widget.index]
                                ["title"],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsSection(
                                    authorindex: widget.index,
                                    categoryjsonList: widget.categoryjsonList,
                                    jsonList: widget.jsonList,
                                    relatednewsjsonList:
                                        widget.relatednewsjsonList,
                                    galleryresponselist:
                                        widget.galleryresponselist,
                                  )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.person),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(widget.relatednewsjsonList["posts"]
                                    [widget.index]["author"]["name"]),
                              )
                            ]),
                      ),
                    ),

                    //   Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: FxBreadCrumbNavigator(
                    //       firstRoute: "Home",
                    //     ),
                    //   ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => NewsSection()),
                    //     );
                    //   },
                    //   child: Container(
                    //     child: Row(children: [
                    //       IconButton(
                    //         onPressed: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => NewsSection()),
                    //           );
                    //         },
                    //         icon: Icon(
                    //           Icons.person,
                    //           size: 50,
                    //         ),
                    //       ),
                    //       Text('செய்திப்பிரிவு')
                    //     ]),
                    //   ),
                    // ),
                    Builder(builder: (context) {
                      if (widget.relatednewsjsonList["posts"][widget.index]
                              ["video"] !=
                          null) {
                        _controller = YoutubePlayerController(
                          flags: const YoutubePlayerFlags(
                            autoPlay: false,
                          ),
                          initialVideoId: YoutubePlayer.convertUrlToId(
                              widget.relatednewsjsonList["posts"][widget.index]
                                  ["video"])!,
                        );
                      }
                      if (widget.relatednewsjsonList["posts"][widget.index]
                              ["video"] !=
                          null) {
                        return Container(
                          child: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),

                    Builder(builder: (context) {
                      if (widget.relatednewsjsonList["posts"][widget.index]
                                      ["image"]
                                  .toString() ==
                              "[]" ||
                          widget.relatednewsjsonList["posts"][widget.index]
                                  ["image"] ==
                              null) {
                        return Container();
                      } else {
                        return CachedNetworkImage(
                          height: 250,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          imageUrl: widget.relatednewsjsonList["posts"]
                              [widget.index]["image"],
                        );
                      }
                    }),
                    Builder(builder: (context) {
                      String htmlContent = widget.relatednewsjsonList["posts"]
                          [widget.index]['content'];
                      String firstHalf =
                          htmlContent.substring(0, htmlContent.length ~/ 2);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Html(
                            data: showFullContent ? htmlContent : firstHalf,
                            style: {
                              "body": Style(
                                fontSize: FontSize(16.0),
                              ),
                              "img": Style(
                                width: Width(
                                    MediaQuery.of(context).size.width - 80),
                                height: Height(250),
                              )
                            },
                          ),
                        ),
                      );
                    }),
                    Visibility(
                      visible: !showFullContent,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            showFullContent = !showFullContent;
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                        child: Text("மேலும் காண"),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        if (widget.relatednewsjsonList != null &&
                            widget.relatednewsjsonList.containsKey("posts") &&
                            widget.index <
                                widget.relatednewsjsonList["posts"].length &&
                            widget.relatednewsjsonList["posts"][widget.index]
                                .containsKey("tags") &&
                            widget.relatednewsjsonList["posts"][widget.index]
                                    ["tags"] !=
                                null &&
                            widget
                                .relatednewsjsonList["posts"][widget.index]
                                    ["tags"]
                                .isNotEmpty &&
                            widget.relatednewsjsonList["posts"][widget.index]
                                    ["tags"][0]
                                .containsKey("name") &&
                            widget.relatednewsjsonList["posts"][widget.index]
                                    ["tags"][0]["name"] !=
                                null &&
                            widget.relatednewsjsonList["posts"][widget.index]
                                    ["tags"][0]["name"]
                                .containsKey("ta") &&
                            widget.relatednewsjsonList["posts"][widget.index]
                                    ["tags"][0]["name"]["ta"] !=
                                null) {
                          return Row(
                            children: [
                              Text('Tags : -'),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Tags(
                                          indexvalue: widget.index,
                                          categoryjsonList:
                                              widget.categoryjsonList,
                                          jsonList: widget.jsonList,
                                          relatednewsjsonList:
                                              widget.relatednewsjsonList,
                                          galleryresponselist:
                                              widget.galleryresponselist,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      border: Border.all(color: Colors.red),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Text(" "),
                                          Text(
                                            widget.relatednewsjsonList["posts"]
                                                    [widget.index]["tags"][0]
                                                ["name"]["ta"],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(" "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Visibility(
                              visible: false,
                              child: Row(children: [Text("data")]));
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        child: Image.asset('assets/images/advertisement.jpg'),
                      ),
                    ),

                    //  Row(
                    //    children: [
                    //      Text('Tags : -'),
                    //      Padding(
                    //        padding: const EdgeInsets.only(left: 8.0),
                    //        child: Container(
                    //            height: 30,ask name logo,area,serices,social,contact
                    //            decoration: BoxDecoration(
                    //              color: Colors.red,
                    //              border: Border.all(color: Colors.red),
                    //              borderRadius: BorderRadius.circular(5.0),
                    //            ),
                    //            child: Center(
                    //                child: Row(
                    //              children: [
                    //                Text(" "),
                    //                Builder(
                    //                  builder: (context) {
                    //                    if (jsonList != null &&
                    //                        jsonList.containsKey("posts") &&
                    //                        widget.index <
                    //                            jsonList["posts"].length &&
                    //                        jsonList["posts"][widget.index]
                    //                            .containsKey("tags") &&
                    //                        jsonList["posts"][widget.index]
                    //                                ["tags"] !=
                    //                            null &&
                    //                        jsonList["posts"][widget.index]["tags"]
                    //                            .isNotEmpty &&
                    //                        jsonList["posts"][widget.index]["tags"]
                    //                                [0]
                    //                            .containsKey("name") &&
                    //                        jsonList["posts"][widget.index]["tags"]
                    //                                [0]["name"] !=
                    //                            null &&
                    //                        jsonList["posts"][widget.index]["tags"]
                    //                                [0]["name"]
                    //                            .containsKey("ta") &&
                    //                        jsonList["posts"][widget.index]["tags"]
                    //                                [0]["name"]["ta"] !=
                    //                            null) {
                    //                      return Text(
                    //                        jsonList["posts"][widget.index]["tags"]
                    //                            [0]["name"]["ta"],
                    //                        style: TextStyle(color: Colors.white),
                    //                      );
                    //                    } else {
                    //                      return Row(children: []);
                    //                    }
                    //                  },
                    //                ),
                    //                // Builder(builder: (context) {
                    //                //   if (jsonList["posts"][widget.index]["tags"][0]
                    //                //           ["name"]["ta"] !=
                    //                //       null) {
                    //                //     return Text(
                    //                //       jsonList["posts"][widget.index]["tags"][0]
                    //                //           ["name"]["ta"],
                    //                //       style: TextStyle(color: Colors.white),
                    //                //     );
                    //                //   } else {
                    //                //     return Text(
                    //                //       "No Tags",
                    //                //     );
                    //                //   }
                    //                // }),
                    //                Text(" "),
                    //              ],
                    //            ))),
                    //      ),
                    //    ],
                    //  ),

                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Related News",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                            height: 0, child: Divider(color: Colors.blue)),
                      ],
                    ),
                    ListView.builder(
                        itemCount: widget.relatednewsjsonList["posts"].length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          if (index != widget.index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 8, top: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Related(
                                                  index: index,
                                                  relatednewsjsonList: widget
                                                      .relatednewsjsonList,
                                                  jsonList: widget.jsonList,
                                                  categoryjsonList:
                                                      widget.categoryjsonList,
                                                  galleryresponselist: widget
                                                      .galleryresponselist,
                                                )));
                                  },
                                  child: Container(
                                      child: Column(children: [
                                    Builder(builder: (context) {
                                      if (widget.relatednewsjsonList["posts"]
                                                      [index]["image_data"]
                                                  .toString() ==
                                              "[]" ||
                                          widget.relatednewsjsonList["posts"]
                                                      [index]["image_data"][0]
                                                  ["original_url"] ==
                                              null) {
                                        return Container();
                                      } else {
                                        return CachedNetworkImage(
                                          height: 250,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          imageUrl: widget.relatednewsjsonList[
                                                  "posts"][index]["image_data"]
                                              [0]["original_url"],
                                        );
                                      }
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        width: 350,
                                        child: Text(
                                          widget.relatednewsjsonList["posts"]
                                              [index]["title"],
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        widget.relatednewsjsonList["posts"]
                                            [index]["subcategory"]["name"],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    )
                                  ])),
                                ));
                          } else {
                            return Container();
                          }
                        })
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: Color.fromRGBO(241, 242, 243, 1),
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Gallery(
                                index: 0,
                                id: 0,
                                jsonList: widget.jsonList,
                                relatednewsjsonList: widget.relatednewsjsonList,
                                categoryjsonList: widget.categoryjsonList,
                                galleryresponselist: widget.galleryresponselist,
                              ),
                            ));
                      },
                      child: Container(
                        width: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              'assets/images/movie.svg',
                              height: 20,
                              width: 20,
                              color: Colors.white,
                            ),
                            Text(
                              'வெப் ஸ்டோரீஸ்',
                              style:
                                  TextStyle(fontSize: 6, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(
                              categorylength: 1,
                              subcategorylength: 0,
                              categoryjsonList: widget.categoryjsonList,
                              jsonList: widget.jsonList,
                              relatednewsjsonList: widget.relatednewsjsonList,
                              galleryresponselist: widget.galleryresponselist,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              'assets/images/cinema.svg',
                              height: 20,
                              width: 20,
                              color: Colors.white,
                            ),
                            Text(
                              'சினிமா',
                              style:
                                  TextStyle(fontSize: 6, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //   Container(
                    //     width: 50,
                    //     decoration: BoxDecoration(
                    //       color: Colors.red,
                    //       shape: BoxShape.circle,
                    //     ),
                    //     child: IconButton(
                    //       icon: SvgPicture.asset(
                    //         'assets/images/ninedots.svg',
                    //         height: 50,
                    //         width: 50,
                    //         color: Colors.white,
                    //       ),
                    //       onPressed: () {
                    //         // Handle tap
                    //       },
                    //     ),
                    //   ),
                    Container(
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: isOpen
                            ? SvgPicture.asset(
                                'assets/images/ninedots.svg',
                                height: 30,
                                width: 30,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          });
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              'assets/images/books.svg',
                              height: 20,
                              width: 20,
                              color: Colors.white,
                            ),
                            Text(
                              'புத்தங்கள்',
                              style:
                                  TextStyle(fontSize: 6, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.info, color: Colors.white),
                            Text(
                              'எங்களைப்பற்றி',
                              style:
                                  TextStyle(fontSize: 6, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                if (!_isAtTop)
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: _scrollToTop,
                    child: Icon(Icons.arrow_upward, color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class SocialIcon extends StatelessWidget {
  final String imagePath;

  const SocialIcon({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: 20,
      height: 20,
    );
  }
}
