// ignore_for_file: unused_import, unnecessary_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, deprecated_member_use, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterap_breadcrumb/components/fx_app_navigator_observer.dart';
import 'package:flutterap_breadcrumb/fx_flutterap_breadcrumb.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uyirmeiseithigal/gallery.dart';
import 'package:uyirmeiseithigal/joiningpage.dart';
import 'package:uyirmeiseithigal/main.dart';
import 'package:uyirmeiseithigal/seithipirivu.dart';
import 'related.dart';

class CategoryPage extends StatefulWidget {
  var subcategorylength;
  var categorylength;
  var jsonList;
  var categoryjsonList;
  var relatednewsjsonList;
  var galleryresponselist;

  CategoryPage({
    super.key,
    required this.subcategorylength,
    required this.categorylength,
    required this.jsonList,
    required this.categoryjsonList,
    required this.relatednewsjsonList,
    required this.galleryresponselist,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtTop = true;
  DateTime now = DateTime.now();

  int intvalue = 5;
  int indexvalue = 0;
  int gallerycount = 1;
  bool seithigalvisibility = false;
  bool cinemavisibility = false;
  bool anmigamvisibility = false;
  bool vilaiyatuvisibility = false;
  bool puthagangalvisibility = false;
  bool webstoriesvisibility = false;
  bool tvvisibility = false;
  Color homecolor = Colors.white;
  Color seithigalcolor = Colors.white;
  Color cinemacolor = Colors.white;
  Color vilaiyatucolor = Colors.white;
  Color anmigamcolor = Colors.white;
  Color puthagamcolor = Colors.white;
  bool disableLabel = false;
  bool isOpen = true;
  bool isRedContainerClicked = false;
  // Color subcategorycolor = Colors.white;
  List<Color> redtowhitetextcolor = [];
  List<Color> categorycontainercolor = [];
  List<Color> redtowhitesubcategorycolor = [];
  List<Color> subcategorycontainercolor = [];
  List<bool> _subcategoryVisibilityList = [];

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

  void _incrementCounter() {
    setState(() {
      intvalue = intvalue + 5;
    });
  }

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    if (widget.jsonList == null) {
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
            surfaceTintColor: Colors.transparent,
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
            toolbarHeight: 80,
            shape: Border(bottom: BorderSide(color: Colors.blue)),
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
                          color:
                              isRedContainerClicked ? Colors.red : Colors.white,
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
                        itemCount: widget.categoryjsonList["navigation"].length,
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: null,
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: redtowhitetextcolor[
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
                                                                  Colors.white)
                                                              ? Colors.red
                                                              : Colors.white;

                                                      redtowhitesubcategorycolor[
                                                              indexs] =
                                                          (redtowhitesubcategorycolor[
                                                                      indexs] ==
                                                                  Colors.black)
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
                                                                        [indexa]
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
                    // InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => JoiningPage(
                    //                   jsonList: widget.jsonList,
                    //                   relatednewsjsonList:
                    //                       widget.relatednewsjsonList,
                    //                   galleryresponselist:
                    //                       widget.galleryresponselist,
                    //                   categoryjsonList: widget.categoryjsonList,
                    //                 )),
                    //       );
                    //     },
                    //     child: Image.asset('assets/images/joining.jpg')),
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
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Column(
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
                          widget.categoryjsonList["navigation"]
                              [widget.categorylength]["name"],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(height: 0, child: Divider(color: Colors.blue)),
                  ],
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Row(children: [
              //     Expanded(
              //         child: Divider(
              //       color: Colors.grey,
              //     )),
              //     TextButton(
              //         onPressed: () {},
              //         style: TextButton.styleFrom(
              //           foregroundColor: Colors.white,
              //           backgroundColor: Colors.red,
              //         ),
              //         child: Row(
              //           children: [
              //             Text(widget.categoryjsonList["navigation"]
              //                 [widget.categorylength]["name"]),
              //           ],
              //         )),
              //     Expanded(child: Divider(color: Colors.grey)),
              //   ]),
              // ),
              // ElevatedButton(onPressed: () {}, child: Text("All categories")),
              //    Container(
              //      height: 60,
              //      child: ListView.builder(
              //          shrinkWrap: true,
              //          itemCount: categoryjsonList["navigation"]
              //                  [widget.categorylength]["subcategories"]
              //              .length,
              //          scrollDirection: Axis.horizontal,
              //          itemBuilder: (context, indexs) {
              //            return Padding(
              //              padding: const EdgeInsets.all(8.0),
              //              child: InkWell(
              //                onTap: () {},
              //                child: Container(
              //                    child: ElevatedButton(
              //                  onPressed: () {
              //                    setState(() {
              //                      widget.categorylength = widget.categorylength;
              //                      widget.subcategorylength = indexs;
              //                    });
              //                  },
              //                  child: Text(
              //                    categoryjsonList["navigation"]
              //                            [widget.categorylength]["subcategories"]
              //                        [indexs]["name"],
              //                  ),
              //                )),
              //              ),
              //            );
              //          }
              //          //scrollDirection: Axis.horizontal,
              //          //children: <Widget>[
              //          //  Container(
              //          //    child: ImageNetwork(
              //          //    width: 300,
              //          //    height: 200,
              //          //    fitWeb: BoxFitWeb.contain,
              //          //    image: relatednewsjsonList["posts"][0]["image_data"][0]
              //          //        ["original_url"],
              //          //  ))
              //          //],
              //          ),
              //    ),
              // Text(categoryjsonList["navigation"][widget.categorylength]
              //     ["subcategories"][widget.subcategorylength]["name"]),
              // Text(categoryjsonList["navigation"][widget.categorylength]
              //     ["subcategories"][widget.subcategorylength]["name"]),
              // Text(relatednewsjsonList["posts"][18]["image_data"].toString()),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.relatednewsjsonList["posts"].length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (widget.categoryjsonList["navigation"]
                                  [widget.categorylength]["subcategories"]
                              [widget.subcategorylength]["name"] ==
                          widget.relatednewsjsonList["posts"][index]
                              ["subcategory"]["name"]) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Related(
                                        index: index,
                                        jsonList: widget.jsonList,
                                        categoryjsonList:
                                            widget.categoryjsonList,
                                        relatednewsjsonList:
                                            widget.relatednewsjsonList,
                                        galleryresponselist:
                                            widget.galleryresponselist)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                                width: 300,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Builder(builder: (context) {
                                        if (widget.relatednewsjsonList["posts"]
                                                        [index]["image"]
                                                    .toString() ==
                                                "[]" ||
                                            widget.relatednewsjsonList["posts"]
                                                        [index]["image"] ==
                                                null) {
                                          return Container();
                                        } else {
                                          return CachedNetworkImage(
                                            height: 250,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            imageUrl:
                                                widget.relatednewsjsonList[
                                                            "posts"][index]
                                                        ["image"],
                                          );
                                        }
                                      }),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          widget.relatednewsjsonList["posts"]
                                              [index]["subcategory"]["name"],
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                          bottom: 8.0,
                                        ),
                                        child: Text(
                                          widget.relatednewsjsonList["posts"]
                                              [index]["title"],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                      )
                                    ])),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
            ]),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Color.fromRGBO(75, 5, 5, 1.0),
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
                            style: TextStyle(fontSize: 6, color: Colors.white),
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
                            style: TextStyle(fontSize: 6, color: Colors.white),
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
                            style: TextStyle(fontSize: 6, color: Colors.white),
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
                            style: TextStyle(fontSize: 6, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: _isAtTop
              ? null
              : FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: _scrollToTop,
                  child: Icon(Icons.arrow_upward, color: Colors.white),
                ),
        ),
      );
    }
  }
}
