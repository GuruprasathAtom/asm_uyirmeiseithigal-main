// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, avoid_print, unused_import, unnecessary_import, sized_box_for_whitespace, deprecated_member_use
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uyirmeiseithigal/categorynews.dart';
import 'package:uyirmeiseithigal/colors_util.dart';
import 'package:uyirmeiseithigal/gallery.dart';
import 'package:uyirmeiseithigal/joiningpage.dart';
import 'package:uyirmeiseithigal/seithipirivu.dart';
import 'related.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [AppNavigatorObserver()],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtTop = true;
  DateTime now = DateTime.now();
  var jsonList;
  var relatednewsjsonList;
  var categoryjsonList;
  var galleryresponselist;
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
  bool showGridBody = false;
  List<Map<String, int>> watchednewsid = [
    {'id': 171},
  ];
  List<Map<String, int>> categoryname = [
    {'செய்திகள்': 0},
  ];
  List<Map<String, int>> subcategoryname = [
    {'இந்தியா': 0},
  ];
  bool isRedContainerClicked = false;
  List<Color> redtowhitetextcolor = [];
  List<Color> categorycontainercolor = [];
  List<Color> redtowhitesubcategorycolor = [];
  List<Color> subcategorycontainercolor = [];
  List<bool> _subcategoryVisibilityList = [];
  void addCategory(String name) {
    bool found = false;
    for (int i = 0; i < categoryname.length; i++) {
      if (categoryname[i].containsKey(name)) {
        categoryname[i][name] = categoryname[i][name]! + 1;
        found = true;
        break;
      }
    }
    if (!found) {
      categoryname.add({name: 1});
    }
    print(categoryname.toString());
  }

  Map<String, int> getCategoryWithHighestCount() {
    Map<String, int> highestCategory = {}; // Initialize highestCategory here
    int highestCount = 0;

    for (var category in categoryname) {
      String name = category.keys.first;
      int count = category.values.first;

      if (count > highestCount) {
        highestCount = count;
        highestCategory = {name: count}; // Update highestCategory
      }
    }

    return highestCategory;
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

  void _incrementCounter() {
    setState(() {
      if (jsonList.length > intvalue) {
        intvalue = intvalue + 5;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getData();

    _loadWatchedNewsId();

    _scrollController.addListener(_scrollListener);
    redtowhitetextcolor = List.filled(
      1000,
      Colors.black,

    );
    _subcategoryVisibilityList = List<bool>.filled(100, false);
    categorycontainercolor = List.filled(
      1000,
      hexStringToColor("D3D3D3"),
    );

    subcategorycontainercolor = List.filled(
      1000,
      hexStringToColor("D3D3D3"),
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

  void _loadWatchedNewsId() async {
    final prefs = await SharedPreferences.getInstance();
    final watchedIds = prefs.getStringList('watchednews');
    if (watchedIds != null) {
      setState(() {
        watchednewsid =
            watchedIds.map((item) => {'id': int.parse(item)}).toList();
      });
    }
  }

  void _saveWatchedNewsId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('watchednews',
        watchednewsid.map((item) => item['id'].toString()).toList());
  }

  void addItem(Map<String, int> item) {
    if (!watchednewsid.any((i) => i['id'] == item['id'])) {
      setState(() {
        watchednewsid.add(item);
      });
      _saveWatchedNewsId();
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top:Radius.circular(40))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("You've missed the top news. Check it out!"),
                  ),
                  Container(
                    height: 335,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: relatednewsjsonList["posts"].length,
                        scrollDirection: Axis.horizontal,
                         
                        itemBuilder: (context, index) {
                          bool isEqual = watchednewsid.any((i) =>
                              i['id'] ==
                              relatednewsjsonList["posts"][index]['id']);
                          print(isEqual.toString());
                          if (isEqual) {
                            return Container();
                          } else {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  addItem({
                                    "id": relatednewsjsonList["posts"]
                                        [index]['id'],
                                  });
                                });
                            
                                print(relatednewsjsonList["posts"][index]
                                    ['id']);
                                print(watchednewsid);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Related(
                                              index: index,
                                              relatednewsjsonList:
                                                  relatednewsjsonList,
                                              jsonList: jsonList,
                                              categoryjsonList:
                                                  categoryjsonList,
                                              galleryresponselist:
                                                  galleryresponselist,
                                            ))).then((value) =>
                                    {Navigator.of(context).pop()});
                              },
                              child: Container(
                                  width: 300,
                                  height: 250,
                                  child: Column(children: [
                                    Builder(builder: (context) {
                                      if (  relatednewsjsonList["posts"]
                                                        [index]["image"]
                                                    .toString() ==
                                                "[]" ||
                                            relatednewsjsonList["posts"]
                                                        [index]["image"]
                                                ==
                                                null) {
                                        return Container();
                                      } else {
                                        return CachedNetworkImage(
                                          height: 250,
                                          fit: BoxFit.cover,
                                          width: 300,
                                          imageUrl:
                                              relatednewsjsonList["posts"]
                                                      [index]["image"]
                                                 [0],
                                        );
                                      }
                                    }),
                                    Container(
                                      width: 350,
                                      child: Text(
                                        relatednewsjsonList["posts"][index]
                                            ["title"],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      relatednewsjsonList["posts"][index]
                                          ["subcategory"]["name"],
                                    )
                                  ])),
                            );
                          }
                        }
                    ),
                        //scrollDirection: Axis.horizontal,
                        //children: <Widget>[
                        //  Container(
                        //    child: ImageNetwork(
                        //    width: 300,
                        //    height: 200,
                        //    fitWeb: BoxFitWeb.contain,
                        //    image: relatednewsjsonList["posts"][0]["image"][0]
                        //        ["original_url"],
                        //  ))
                        //],
                        
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void getData() async {
    try {
      var response =
          await Dio().get('https://uyirmeiseithigal.com/api/newsdots');
      var relatednewsresponse =
          await Dio().get('https://uyirmeiseithigal.com/api/relatedNews');
      var categoryresponse =
          await Dio().get('https://uyirmeiseithigal.com/api/logo');
      var galleryresponse =
          await Dio().get('https://uyirmeiseithigal.com/api/gallery');
      print(galleryresponse);
      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data;
          relatednewsjsonList = relatednewsresponse.data;
          categoryjsonList = categoryresponse.data;
          galleryresponselist = galleryresponse.data;
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (jsonList == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Opacity(
              opacity: 0.4,
              child: Image.asset(
                'assets/images/backgroundnews.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: Center(
                child: Container(
                  height: 200,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/uyirmeimainlogo.jpg',
                        width: 300,
                        height: 100,
                      ),
                      CircularProgressIndicator()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        // Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
        //  children: [
        //    Center(
        //      child: Image.asset(
        //        'assets/images/uyirmeimainlogo.jpg',
        //        width: 300,
        //        height: 100,
        //      ),
        //    ),
        //    CircularProgressIndicator(),
        //  ],
        //),
      );
    } else {
      return GestureDetector(
        onTap: () {
          print("body");
          changeContainerColor(0);
          isRedContainerClicked = false;
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
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: hexStringToColor("5099ef"),
            surfaceTintColor: Colors.transparent,
            leading: Builder(
              builder: (BuildContext context) {
                return Material( 
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    color: hexStringToColor("5099ef"),
                    child: IconButton(
                      color: Colors.grey[850],
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: 'Categories',
                    ),
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
                imageUrl: categoryjsonList["logoUrl"],
              ),
            ),
          ),
          onDrawerChanged: (isOpened) {
            if (isOpened == false) {
              print("dfs");
              changeContainerColor(0);
              _subcategoryVisibilityList = List.filled(100, false);
              redtowhitesubcategorycolor = List.filled(1000, Colors.black);
              subcategorycontainercolor = List.filled(1000, hexStringToColor("D3D3D3"),);
              redtowhitetextcolor = List.filled(1000, Colors.black);
              categorycontainercolor = List.filled(1000, hexStringToColor("D3D3D3"),);
              homecolor = Colors.white;
              seithigalcolor = Colors.white;
              cinemacolor = Colors.white;
              vilaiyatucolor = Colors.white;
              anmigamcolor = Colors.white;
              puthagamcolor = Colors.white;
            }
          },
          drawer: Drawer(
              backgroundColor: hexStringToColor("D3D3D3"),  
              width: 225,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              child: Scaffold(
                backgroundColor: hexStringToColor("D3D3D3"),
                body: SingleChildScrollView(
                  child: Container(
                    child: Column (
                      children: [
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
                          imageUrl: categoryjsonList["logoUrl"],
                        ),
                      ),
                      // Text(categoryjsonList["navigation"].length.toString()),
                      InkWell(
                          onTap: () {
                            setState(() {
                              isRedContainerClicked = false;
                              Navigator.of(context).pop();
                              _scrollController.animateTo(
                                0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                              //  isRedContainerClicked = true;
                              //  Navigator.push(
                              //      context,
                              //      MaterialPageRoute(
                              //        builder: (context) => MyHomePage(),
                              //      )).then((value) {
                              //    setState(() {
                              //      isRedContainerClicked = false;
                              //      _subcategoryVisibilityList =
                              //          List.filled(100, false);
                              //    });
                              //    Navigator.of(context).pop();
                              //    redtowhitesubcategorycolor =
                              //        List.filled(1000, Colors.black);
                              //    subcategorycontainercolor =
                              //        List.filled(1000, Colors.white);
                              //    redtowhitetextcolor =
                              //        List.filled(1000, Colors.black);
                              //    categorycontainercolor =
                              //        List.filled(1000, Colors.white);
                              //  });
                            });
                          },
                          child: Container(
                            color:
                                isRedContainerClicked ? Colors.red : hexStringToColor("D3D3D3"),
                            height: 40,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: Text(
                                    'முகப்பு',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
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
                          itemCount: categoryjsonList["navigation"].length,
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
                                          hexStringToColor("D3D3D3"),
                                        );
                                        _subcategoryVisibilityList =
                                            List<bool>.filled(100, false);
                    
                                        categorycontainercolor[indexa] =
                                            (categorycontainercolor[indexa] ==
                                                    hexStringToColor("D3D3D3"))
                                                ? hexStringToColor("000000")
                                                : hexStringToColor("D3D3D3");
                    
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
                                            List.filled(1000, hexStringToColor("D3D3D3"));
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
                                                        categoryjsonList[
                                                                "navigation"]
                                                            [indexa]["name"],
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        maxLines: null,
                                                        softWrap: true,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold
                                                        ),
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
                                        itemCount: categoryjsonList["navigation"]
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
                    
                                                        redtowhitesubcategorycolor =
                                                            List.filled(1000,
                                                                Colors.black);
                                                        subcategorycontainercolor =
                                                            List.filled(1000,
                                                                hexStringToColor("D3D3D3"),);
                                                        subcategorycontainercolor[
                                                                indexs] =
                                                            (subcategorycontainercolor[
                                                                        indexs] ==
                                                                    hexStringToColor("D3D3D3"))
                                                                ? hexStringToColor("000000")
                                                                : hexStringToColor("D3D3D3");
                    
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
                                                            categoryjsonList:
                                                                categoryjsonList,
                                                            jsonList: jsonList,
                                                            relatednewsjsonList:
                                                                relatednewsjsonList,
                                                            galleryresponselist:
                                                                galleryresponselist,
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
                                                              categoryjsonList[
                                                                              "navigation"]
                                                                          [indexa]
                                                                      [
                                                                      "subcategories"]
                                                                  [
                                                                  indexs]["name"],
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
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
                                      jsonList: jsonList,
                                      relatednewsjsonList: relatednewsjsonList,
                                      categoryjsonList: categoryjsonList,
                                      galleryresponselist: galleryresponselist,
                                    )),
                          ).then((value) {
                            isRedContainerClicked = false;
                            Navigator.of(context).pop();
                          });
                        },
                        child: Container(
                          color:
                              isRedContainerClicked ? Colors.red : hexStringToColor("D3D3D3"),
                          height: 40,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 24.0),
                                child: Text(
                                  'நீங்களும் நிருபர் ஆகலாம்',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
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
                      //                   jsonList: jsonList,
                      //                   relatednewsjsonList: relatednewsjsonList,
                      //                   categoryjsonList: categoryjsonList,
                      //                   galleryresponselist: galleryresponselist,
                      //                 )),
                      //       ).then((value) => Navigator.of(context).pop());
                      //     },
                      //     child: Image.asset('assets/images/joining.jpg')),
                    ]),
                  ),
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
          body: showGridBody
              ? SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 300,
                            crossAxisCount: 2, 
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 0.0,
                          ),
                          shrinkWrap: true,
                          itemCount:
                              galleryresponselist["grouped_images"].length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Gallery(
                                      index: 0,
                                      id: index,
                                      jsonList: jsonList,
                                      relatednewsjsonList: relatednewsjsonList,
                                      categoryjsonList: categoryjsonList,
                                      galleryresponselist: galleryresponselist,
                                    ),
                                  ),
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: galleryresponselist["grouped_images"]
                                    [index]["images"][0]["url"],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : WillPopScope(
                  // onWillPop: () async => false,

                  onWillPop: () async {
                    setState(() {
                    //  _showBottomSheet(context);
                    });

                    return false;
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                hexStringToColor("5099ef"),
                hexStringToColor("17e3cb"),
                hexStringToColor("e8f269")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(children: [
                        // Text(jsonList.length.toString()),
                     Column(
                       children: [
                         Visibility(
                           visible: false,
                           child: Align(
                             alignment: Alignment.centerLeft,
                             child: FxBreadCrumbNavigator(
                               firstRoute: "Home",
                             ),
                           ),
                         ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //   height: 200,
                      //   child: Image.asset('assets/images/advertisement.jpg'),
                      //   ),
                      // ),
                       ],
                     ),
                     SizedBox(height: 20,),
                    Padding(
                            padding: const EdgeInsets.all(16.0),   
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Column(
                                      children: [
                                      //Padding(
                                      //  padding: const EdgeInsets.all(8.0),
                                      //  child: Align(
                                      //    alignment: Alignment.centerLeft,
                                      //    child: Text(
                                      //      jsonList[index]['title'],
                                      //      style: TextStyle(
                                      //          fontSize: 20.0,
                                      //          color: Colors.red,
                                      //          fontWeight: FontWeight.bold),
                                      //    ),
                                      //  ),
                                      //),
                                      //Padding(
                                      //  padding: const EdgeInsets.only(
                                      //      left: 8.0, bottom: 8.0),
                                      //  child: Row(
                                      //    children: [
                                      //      Text(DateFormat('dd.MM.yyyy')
                                      //          .format(DateTime.parse(
                                      //              jsonList[index]
                                      //                  ['created_at']))),
                                      //      Text(' - '),
                                      //      Text(DateFormat('HH:mm a').format(
                                      //          DateTime.parse(jsonList[index]
                                      //              ['created_at']))),
                                      //    ],
                                      //  ),
                                      //),
                                        Builder(
                                          builder: (context) {
                                            if (jsonList[index]['image'] == null) {
                                                return  Container();
                                            }else{
                                               return CachedNetworkImage(
                                                fit: BoxFit.contain,
                                                width: double.infinity,
                                                imageUrl: jsonList[index]['image'],
                                                placeholder: (context, url) => Center(
                                                      child: Column(
                                                        children: [
                                                          Image.asset(
                                                            width: 250,
                                                            height: 200,
                                                            'assets/images/uyirmeimainlogo.jpg',
                                                            fit: BoxFit.contain,
                                                          ),
                                                          Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )
                                                        ],
                                                      ),
                                                    ));
                                            }
                                           
                                          }
                                        ),
                                    //  Html(
                                    //      data: jsonList[index]['content'],
                                    //      style: {
                                    //        "body": Style(
                                    //          fontSize: FontSize(16.0),
                                    //        )
                                    //      }),
                                    //  //Padding(
                                    //  //  padding: const EdgeInsets.all(8.0),
                                    //  //  child:ImageNetwork(
                                    //  //      width: 300,
                                    //  //      height: 200,
                                    //  //      fitAndroidIos: BoxFit.contain,
                                    //  //      image:
                                    //  //          'https://uyirmeiseithigal.com/storage/251/bY23D4RIZbpd4E0w4hhJ7LU2vMrcFt-metaNjhkNmI3MzgtNTViMy00YWEwLWI0YWMtYzIwN2JlM2ZkMmNhLmpwZw==-.jpg'),
                                    //  //),
                                    //  Divider(
                                    //    color: Colors.grey,
                                    //  ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: intvalue),
                              ),
                        
                        //Padding(
                        //  padding: const EdgeInsets.all(8.0),
                        //  child: Row(children: [
                        //    Expanded(
                        //        child: Divider(
                        //      color: Colors.grey,
                        //    )),
                        //    Container(child: Text("செய்தி துளிகள்")),
                        //    Expanded(
                        //        child: Divider(
                        //      color: Colors.grey,
                        //    )),
                        //  ]),
                        //),
                      
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                          color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, left: 8.0, right: 8.0),
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
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'செய்தி துளிகள்',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          height: 0, child: Divider(color: Colors.blue))
                                    ],
                                  ),
                                ),
                                Padding(
                              padding: const EdgeInsets.all(8.0),   
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                jsonList[index]['title'],
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, bottom: 8.0),
                                            child: Row(
                                              children: [
                                                Text(DateFormat('dd.MM.yyyy')
                                                    .format(DateTime.parse(
                                                        jsonList[index]
                                                            ['created_at']))),
                                                Text(' - '),
                                                Text(DateFormat('HH:mm a').format(
                                                    DateTime.parse(jsonList[index]
                                                        ['created_at']))),
                                              ],
                                            ),
                                          ),
                                       // Builder(
                                       //   builder: (context) {
                                       //     if (jsonList[index]['image'] == null) {
                                       //         return  Container();
                                       //     }else{
                                       //        return CachedNetworkImage(
                                       //         fit: BoxFit.contain,
                                       //         width: double.infinity,
                                       //         imageUrl: jsonList[index]['image'],
                                       //         placeholder: (context, url) => Center(
                                       //               child: Column(
                                       //                 children: [
                                       //                   Image.asset(
                                       //                     width: 250,
                                       //                     height: 200,
                                       //                     'assets/images/uyirmeimainlogo.jpg',
                                       //                     fit: BoxFit.contain,
                                       //                   ),
                                       //                   Center(
                                       //                     child:
                                       //                         CircularProgressIndicator(),
                                       //                   )
                                       //                 ],
                                       //               ),
                                       //             ));
                                       //     }
                                       //    
                                       //   }
                                       // ),
                                          Html(
                                              data: jsonList[index]['content'],
                                              style: {
                                                "body": Style(
                                                  fontSize: FontSize(16.0),
                                                )
                                              }),
                                          //Padding(
                                          //  padding: const EdgeInsets.all(8.0),
                                          //  child:ImageNetwork(
                                          //      width: 300,
                                          //      height: 200,
                                          //      fitAndroidIos: BoxFit.contain,
                                          //      image:
                                          //          'https://uyirmeiseithigal.com/storage/251/bY23D4RIZbpd4E0w4hhJ7LU2vMrcFt-metaNjhkNmI3MzgtNTViMy00YWEwLWI0YWMtYzIwN2JlM2ZkMmNhLmpwZw==-.jpg'),
                                          //),
                                          Divider(
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: intvalue),
                                ),
                              Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Expanded(
                                    child: Divider(
                                  color: Colors.grey, 
                                )),
                                TextButton(
                                    onPressed: _incrementCounter,
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.red,
                                    ),
                                    child: Text('மேலும் படிக்க')),
                                Expanded(child: Divider(color: Colors.grey)),
                              ]),
                            ),
                            
                            Container(
                              height: 200,
                              child: Image.asset('assets/images/advertisement.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 8.0, right: 8.0),
                              child: Row(children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            border: Border.all(
                                              color: Colors.blue, // Border color
                                              width: 2.0, // Border width
                                            ),
                                          ),
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Related News',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(top: 38.0),
                                        child: Divider(color: Colors.blue))),
                              ]),
                            ),
                             Container(
                              height: 400,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: relatednewsjsonList["posts"].length,
                                  scrollDirection: Axis.horizontal,
                                  // physics: NeverScrollableScrollPhysics(),
                                  // shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    if ((171 ==
                                        relatednewsjsonList["posts"][index]
                                            ['id'])) {
                                      print(watchednewsid);
                                      print(relatednewsjsonList["posts"][index]
                                          ['id']);
                            
                                      return Container();
                                    } else {
                                      // print(relatednewsjsonList["posts"][index]
                                      //     ["category"]["name"]);
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              bottom: 8,
                                              top: 8.0),
                                          child: InkWell(
                                            onTap: () {
                                              addItem({
                                                "id": relatednewsjsonList["posts"]
                                                    [index]["id"],
                                              });
                                              addCategory(
                                                  relatednewsjsonList["posts"]
                                                      [index]["category"]["name"]);
                                              print(categoryname.toString());
                                              print(relatednewsjsonList["posts"]
                                                  [index]["id"]);
                                              print(watchednewsid.toString());
                                              print(getCategoryWithHighestCount());
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => Related(
                                                            index: index,
                                                            relatednewsjsonList:
                                                                relatednewsjsonList,
                                                            jsonList: jsonList,
                                                            categoryjsonList:
                                                                categoryjsonList,
                                                            galleryresponselist:
                                                                galleryresponselist,
                                                          )));
                                            },
                                            child: Container(
                                                width: 300,
                                                height: 250,
                                                child: Column(children: [
                                                  Builder(builder: (context) {
                                                    if (relatednewsjsonList["posts"]
                                                                        [index]
                                                                    ["image"]
                                                                .toString() ==
                                                            "[]" ||
                                                        relatednewsjsonList["posts"]
                                                                        [index][
                                                                    "image"] 
                                                                 ==
                                                            null) {
                                                      return Container();
                                                    } else {
                                                      return CachedNetworkImage(
                                                        height: 250,
                                                        fit: BoxFit.cover,
                                                        width: 300,
                                                        imageUrl:
                                                            relatednewsjsonList[
                                                                            "posts"]
                                                                        [index]
                                                                    ["image"]
                                                              ,
                                                      );
                                                    }
                                                  }),
                                                  Container(
                                                    width: 350,
                                                    child: Text(
                                                      (relatednewsjsonList["posts"]
                                                          [index]["title"]).toString(),
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    relatednewsjsonList["posts"]
                                                            [index]["subcategory"]
                                                        ["name"],
                                                  )
                                                ])),
                                          ));
                                    }
                                  }
                                  //scrollDirection: Axis.horizontal,
                                  //children: <Widget>[
                                  //  Container(
                                  //    child: ImageNetwork(
                                  //    width: 300,
                                  //    height: 200,
                                  //    fitWeb: BoxFitWeb.contain,
                                  //    image: relatednewsjsonList["posts"][0]["image"][0]
                                  //        ["original_url"],
                                  //  ))
                                  //],
                                  ),
                            ),
                            Container(
                              height: 200,
                              child: Image.asset('assets/images/advertisement.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 8.0, right: 8.0),
                              child: Row(children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            border: Border.all(
                                              color: Colors.blue, // Border color
                                              width: 2.0, // Border width
                                            ),
                                          ),
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'வெப்ஸ்டோரி',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(top: 38.0),
                                        child: Divider(color: Colors.blue))),
                              ]),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: gallerycount,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, top: 8.0, right: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Gallery(
                                              index: 0,
                                              id: index,
                                              jsonList: jsonList,
                                              relatednewsjsonList:
                                                  relatednewsjsonList,
                                              categoryjsonList: categoryjsonList,
                                              galleryresponselist:
                                                  galleryresponselist,
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            CachedNetworkImage(
                                              fit: BoxFit.contain,
                                              width: double.infinity,
                                              imageUrl: galleryresponselist[
                                                      "grouped_images"][index]
                                                  ["images"][0]["url"],
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              left: 0,
                                              child: Container(
                                                color: Colors.black54,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width, // Make container width equal to screen width
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        galleryresponselist[
                                                                    "grouped_images"]
                                                                [index]["images"][0]
                                                            ["title"],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Expanded(
                                    child: Divider(
                                  color: Colors.grey,
                                )),
                                TextButton(
                                    onPressed: () {
                                      // setState(() {
                                      //   showGridBody = !showGridBody;
                                      // });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GalleryGrid(
                                            jsonList: jsonList,
                                            relatednewsjsonList:
                                                relatednewsjsonList,
                                            categoryjsonList: categoryjsonList,
                                            galleryresponselist:
                                                galleryresponselist,
                                          ),
                                        ),
                                      );
                                      //setState(() {
                                      //
                                      // // if (gallerycount < 6) {
                                      // //   gallerycount = gallerycount + 2;
                                      // // }
                                      // });
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.red,
                                    ),
                                    child: Row(
                                      children: [
                                        Text('மேலும்'),
                                      ],
                                    )),
                                Expanded(child: Divider(color: Colors.grey)),
                              ]),
                            ),
                            Container(
                              height: 200,
                              child: Image.asset('assets/images/advertisement.jpg'),
                            ),
                              ],
                            ),
                          ),
                        ),
                        
                        
                       
                      ]),
                    ),
                  ),
                ),
          bottomNavigationBar: BottomAppBar(
            color: Color.fromRGBO(241, 242, 243, 1),
            child: Container(
              padding: EdgeInsets.zero,
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
                              jsonList: jsonList,
                              relatednewsjsonList: relatednewsjsonList,
                              categoryjsonList: categoryjsonList,
                              galleryresponselist: galleryresponselist,
                            ),
                          ));
                    },
                    child: Flexible(
                      child: Container(
                        
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/1976052_gallery_image_images_photo_picture_icon.svg',
                              height: 30,
                              width: 30,
                              color: Colors.grey[900],
                            ),
                            SizedBox(height: 3,),
                            Text(
                              'வெப் ஸ்டோரீஸ்',
                              style: TextStyle(fontSize: 10, color: Colors.grey[900], fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(
                            categorylength: 1,
                            subcategorylength: 0,
                            categoryjsonList: categoryjsonList,
                            jsonList: jsonList,
                            relatednewsjsonList: relatednewsjsonList,
                            galleryresponselist: galleryresponselist,
                          ),
                        ),
                      );
                    },
                    child: Flexible(
                      child: Container(
                       
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/video.svg',
                              height: 30,
                              width: 30,
                              color: Colors.grey[900],
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'சினிமா',
                              style: TextStyle(fontSize: 10, color: Colors.grey[900], fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
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
                  Flexible(
                    child: Container(
                      alignment: Alignment.center,
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 7, 21, 216),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(alignment: Alignment.center,
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
                          // _showBottomSheet(context);
                            //showDialog(
                            //  context: context,
                            //  builder: (ctx) => AlertDialog(
                            //    title: Center(child: const Text("Top News")),
                            //    content: Column(
                            //      children: [
                            //        const Text(
                            //            "You've missed the top news. Check it out!"),
                            //        const Divider(),
                            //      ],
                            //    ),
                            //    actions: [
                            //      TextButton(
                            //        onPressed: () {
                            //          Navigator.of(ctx).pop();
                            //          setState(() {
                            //            isOpen = !isOpen;
                            //          });
                            //        },
                            //        child: Container(
                            //          color: Colors.green,
                            //          padding: const EdgeInsets.all(14),
                            //          child: const Text("okay"),
                            //        ),
                            //      ),
                            //    ],
                            //  ),
                            //);
                    
                            //Navigator.push(
                            //    context,
                            //    MaterialPageRoute(
                            //      builder: (context) => ImageTest(),
                            //    ));
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: () {},
                    child: Flexible(
                      child: Container(
                      
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/bbook.svg',
                              height: 30,
                              width: 30,
                              color: Colors.grey[900],
                            ),
                            Text(
                              'புத்தங்கள்',
                              style: TextStyle(fontSize: 10, color: Colors.grey[900], fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: () {},
                    child: Flexible(
                      child: Container(
                        
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/info_icon.svg',
                              height: 30,
                              width: 30,
                              color: Colors.grey[900],
                            ),
                            Text(
                              'எங்களைப்பற்றி',
                              style: TextStyle(fontSize: 10, color: Colors.grey[900], fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
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
                  backgroundColor: hexStringToColor("5099ef"),
                  onPressed: _scrollToTop,
                  child: Icon(Icons.arrow_upward, color: Colors.white),
                ),
        ),
      );
    }
  }
  
}
