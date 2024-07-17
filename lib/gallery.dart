// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, prefer_const_constructors, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_import, unnecessary_import
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
import 'package:uyirmeiseithigal/categorynews.dart';
import 'package:uyirmeiseithigal/gallery.dart';
import 'package:uyirmeiseithigal/joiningpage.dart';
import 'package:uyirmeiseithigal/main.dart';
import 'package:uyirmeiseithigal/seithipirivu.dart';
import 'related.dart';

class GalleryGrid extends StatefulWidget {
  var jsonList;
  var relatednewsjsonList;
  var categoryjsonList;
  var galleryresponselist;
  GalleryGrid(
      {super.key,
      required this.jsonList,
      required this.relatednewsjsonList,
      required this.categoryjsonList,
      required this.galleryresponselist});

  @override
  State<GalleryGrid> createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
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
  // Color subcategorycolor = Colors.white;
  bool isRedContainerClicked = false;
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
            backgroundColor: Color.fromARGB(255,2, 10, 122),
            surfaceTintColor: Colors.transparent,
            leading: Builder(
              builder: (BuildContext context) {
                return Material(
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: IconButton(
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255,2, 10, 122))),
                    color: Colors.white,
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
                                                  Text(widget.categoryjsonList[
                                                          "navigation"][indexa]
                                                      ["name"]),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JoiningPage(
                                      jsonList: widget.jsonList,
                                      relatednewsjsonList:
                                          widget.relatednewsjsonList,
                                      galleryresponselist:
                                          widget.galleryresponselist,
                                      categoryjsonList: widget.categoryjsonList,
                                    )),
                          );
                        },
                        child: Image.asset('assets/images/joining.jpg')),
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
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              // GridView.count(
              //
              //   physics: NeverScrollableScrollPhysics(),
              //   crossAxisCount: 2,
              //   crossAxisSpacing: 10.0,
              //   mainAxisSpacing: 10.0,
              //   shrinkWrap: true,
              //   children: List.generate(
              //       galleryresponselist["grouped_images"].length, (index) {
              //     return InkWell(
              //       onTap: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) =>
              //                     Gallery(index: 0, id: index)));
              //       },
              //       child: CachedNetworkImage(
              //         imageUrl: galleryresponselist["grouped_images"][index]
              //             ["images"][0]["url"],
              //         fit: BoxFit.contain,
              //       ),
              //     );
              //   }),
              // )
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 300,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                shrinkWrap: true,
                itemCount: widget.galleryresponselist["grouped_images"].length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Gallery(
                            index: 0,
                            id: index,
                            galleryresponselist: widget.galleryresponselist,
                            jsonList: widget.jsonList,
                            relatednewsjsonList: widget.relatednewsjsonList,
                            categoryjsonList: widget.categoryjsonList,
                          ),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: widget.galleryresponselist["grouped_images"]
                          [index]["images"][0]["url"],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              //  GridView.builder(
              //    physics: NeverScrollableScrollPhysics(),
              //    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //      childAspectRatio: 2,
              //      crossAxisCount: 2,
              //    ),
              //    shrinkWrap: true,
              //    itemCount: galleryresponselist["grouped_images"].length,
              //    itemBuilder: (BuildContext context, int index) {
              //      return InkWell(
              //        onTap: () {
              //          Navigator.push(
              //            context,
              //            MaterialPageRoute(
              //              builder: (context) => Gallery(index: 0, id: index),
              //            ),
              //          );
              //        },
              //        child: Container(
              //          child: CachedNetworkImage(
              //            imageUrl: galleryresponselist["grouped_images"][index]
              //                ["images"][0]["url"],
              //            fit: BoxFit.fill,
              //          ),
              //        ),
              //      );
              //    },
              //  ),
              //  ListView.builder(
              //    physics: NeverScrollableScrollPhysics(),
              //    shrinkWrap: true,
              //    itemCount:
              //        (galleryresponselist["grouped_images"].length / 2).ceil(),
              //    itemBuilder: (BuildContext context, int index) {
              //      final int firstIndex = index * 2;
              //      final int secondIndex = firstIndex + 1;
              //      return Row(
              //        children: [
              //          Expanded(
              //            child: Padding(
              //              padding: const EdgeInsets.all(8.0),
              //              child: InkWell(
              //                onTap: () {
              //                  Navigator.push(
              //                    context,
              //                    MaterialPageRoute(
              //                      builder: (context) =>
              //                          Gallery(index: 0, id: firstIndex),
              //                    ),
              //                  );
              //                },
              //                child: Container(
              //                  height: 50, // Adjust the height as needed
              //                  width: 50,
              //                  child: CachedNetworkImage(
              //                    imageUrl: galleryresponselist["grouped_images"]
              //                        [firstIndex]["images"][0]["url"],
              //                    fit: BoxFit
              //                        .fill, // Adjust this according to your requirement
              //                  ),
              //                ),
              //              ),
              //            ),
              //          ),
              //          Expanded(
              //            child: Padding(
              //              padding: const EdgeInsets.all(8.0),
              //              child: InkWell(
              //                onTap: () {
              //                  Navigator.push(
              //                    context,
              //                    MaterialPageRoute(
              //                      builder: (context) =>
              //                          Gallery(index: 0, id: secondIndex),
              //                    ),
              //                  );
              //                },
              //                child: Container(
              //                  height: 800, // Adjust the height as needed
              //                  child: CachedNetworkImage(
              //                    imageUrl: galleryresponselist["grouped_images"]
              //                        [secondIndex]["images"][0]["url"],
              //                    fit: BoxFit
              //                        .fill, //Adjust this according to your requirement
              //                  ),
              //                ),
              //              ),
              //            ),
              //          ),
              //        ],
              //      );
              //    },
              //  ),
            ]),
          )),
          bottomNavigationBar: BottomAppBar(
            color: Color.fromRGBO(241, 242, 243, 1),
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Gallery(
                              index: 0,
                              id: 0,
                              galleryresponselist: widget.galleryresponselist,
                              jsonList: widget.jsonList,
                              relatednewsjsonList: widget.relatednewsjsonList,
                              categoryjsonList: widget.categoryjsonList,
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
                            height: 30,
                            width: 30,
                            color: Colors.grey[700],
                          ),
                          Text(
                            'வெப் ஸ்டோரீஸ்',
                            style: TextStyle(fontSize: 6, color: Colors.grey[700]),
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
                            height: 30,
                            width: 30,
                            color: Colors.grey[700],
                          ),
                          Text(
                            'சினிமா',
                            style: TextStyle(fontSize: 10, color: Colors.grey[700]),
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
                      color: Color.fromARGB(255, 7, 21, 216),
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
                            height: 30,
                            width: 30,
                            color: Colors.grey[700],
                          ),
                          Text(
                            'புத்தங்கள்',
                            style: TextStyle(fontSize: 10, color: Colors.grey[700]),
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
                          Icon(Icons.info, color: Colors.grey[700],size: 30,),
                          Text(
                            'எங்களைப்பற்றி',
                            style: TextStyle(fontSize: 6, color: Colors.black),
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

class Gallery extends StatefulWidget {
  var index;
  var id;
  var jsonList;
  var relatednewsjsonList;
  var categoryjsonList;
  var galleryresponselist;
  Gallery(
      {super.key,
      required this.index,
      required this.id,
      required this.jsonList,
      required this.relatednewsjsonList,
      required this.categoryjsonList,
      required this.galleryresponselist});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtTop = true;
  bool tagsvisibiity = true;
  Color homecolor = Colors.white;
  Color seithigalcolor = Colors.white;
  Color cinemacolor = Colors.white;
  Color vilaiyatucolor = Colors.white;
  Color anmigamcolor = Colors.white;
  Color puthagamcolor = Colors.white;

  bool seithigalvisibility = false;
  bool cinemavisibility = false;
  bool anmigamvisibility = false;
  bool vilaiyatuvisibility = false;
  bool puthagangalvisibility = false;
  bool webstoriesvisibility = false;
  bool tvvisibility = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
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

  void _incrementId() {
    setState(() {
      if (widget.id < widget.galleryresponselist["grouped_images"].length - 1) {
        widget.id++;
        widget.index = 0;
      }
    });
  }

  void _decrementId() {
    setState(() {
      if (widget.id > 0) {
        widget.id--;
        widget.index = 0;
      }
    });
  }

  void _incrementIndex() {
    setState(() {
      if (widget.index <
          widget.galleryresponselist["grouped_images"][widget.id]["images"]
                  .length -
              1) {
        widget.index++;
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return GalleryGrid(
            jsonList: widget.jsonList,
            relatednewsjsonList: widget.relatednewsjsonList,
            categoryjsonList: widget.categoryjsonList,
            galleryresponselist: widget.galleryresponselist,
          );
        }));
      }
    });
  }

  void _decrementIndex() {
    setState(() {
      if (widget.index > 0) {
        widget.index--;
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
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            _decrementId();
          } else {
            _incrementId();
          }
        },
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
            backgroundColor: Colors.grey,
            //Text(galleryresponselist["grouped_images"].length.toString()),
            body: Container(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  //CachedNetworkImage(
                  //  imageUrl: widget.galleryresponselist["grouped_images"]
                  //      [widget.id]["images"][widget.index]["url"],
                  //  fit: BoxFit.fill,
                  //),
                  Opacity(
                    opacity: 0.2,
                    child: CachedNetworkImage(
                      imageUrl: widget.galleryresponselist["grouped_images"]
                          [widget.id]["images"][widget.index]["url"],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CachedNetworkImage(
                      imageUrl: widget.galleryresponselist["grouped_images"]
                          [widget.id]["images"][widget.index]["url"],
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                            visible: widget.index == 0 ? false : true,
                            child: Icon(Icons.keyboard_arrow_left,
                                color: Colors.white)),
                        Icon(Icons.keyboard_arrow_right, color: Colors.white),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.galleryresponselist["grouped_images"]
                                            [widget.id]["images"][widget.index]
                                        ["title"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 12,
                    child: Image.asset(
                      'assets/images/uyirmeimainlogo.jpg',
                      width: 150,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${widget.index + 1}/ ${widget.galleryresponselist["grouped_images"][widget.id]["images"].length}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: CachedNetworkImage(
            //     height: double.infinity,
            //     fit: BoxFit.contain,
            //     width: double.infinity,
            //     imageUrl: galleryresponselist["grouped_images"][widget.id]
            //         ["images"][widget.index]["url"],
            //   ),
            // ),

            floatingActionButton: _isAtTop
                ? null
                : FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: _scrollToTop,
                    child: Icon(Icons.arrow_upward, color: Colors.white),
                  ),
          ),
        ),
      );
    }
  }
}
