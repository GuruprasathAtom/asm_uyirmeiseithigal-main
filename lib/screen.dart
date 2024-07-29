import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uyirmeiseithigal/colors_util.dart';

class screen_image extends StatefulWidget {
  var relatednewsjsonList;
  var index;

  @override
  State<screen_image> createState() => _screen_imageState();
}

class _screen_imageState extends State<screen_image> {
  final ScrollController _scrollController = ScrollController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double imageHeight = constraints.biggest.width * 0.75; // Assuming 4:3 aspect ratio
                return SliverAppBar(
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(14),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 5, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: hexStringToColor("5099ef"),
                            border: Border.all(
                              color: hexStringToColor("5099ef"),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'செய்தி துளிகள்',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  pinned: true,
                  backgroundColor: hexStringToColor("5099ef"),
                  expandedHeight: imageHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Builder(builder: (context) {
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
                          })
                  ),
                );
              },
            ),
          ),
          // Your other slivers here
        ],
      ),
    );
  }
}
