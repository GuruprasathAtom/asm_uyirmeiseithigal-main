//      Padding(
//                padding: const EdgeInsets.only(
//                  top: 16.0,
//                  left: 16.0,
//                  right: 16.0,
//                ),
//                child: Column(
//                  children: [
//                    Align(
//                      alignment: Alignment.centerLeft,
//                      child: Container(
//                        height: 45,
//                        decoration: BoxDecoration(
//                          color: Colors.blue,
//                          border: Border.all(
//                            color: Colors.blue,
//                            width: 2.0,
//                          ),
//                        ),
//                        padding: EdgeInsets.all(10.0),
//                        child: Text(
//                          widget.relatednewsjsonList["posts"][widget.indexvalue]
//                              ["tags"][0]["name"]["ta"],
//                          style: TextStyle(color: Colors.white),
//                        ),
//                      ),
//                    ),
//                    Container(height: 0, child: Divider(color: Colors.blue)),
//                  ],
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.all(16.0),
//                child: ListView.builder(
//                    shrinkWrap: true,
//                    itemCount: widget.relatednewsjsonList["posts"].length,
//                    physics: NeverScrollableScrollPhysics(),
//                    itemBuilder: (context, index) {
//                      if (widget.relatednewsjsonList != null &&
//                          widget.relatednewsjsonList.containsKey("posts") &&
//                          index < widget.relatednewsjsonList["posts"].length &&
//                          widget.relatednewsjsonList["posts"][index]
//                              .containsKey("tags") &&
//                          widget.relatednewsjsonList["posts"][index]["tags"] !=
//                              null &&
//                          widget.relatednewsjsonList["posts"][index]["tags"]
//                              .isNotEmpty &&
//                          widget.relatednewsjsonList["posts"][index]["tags"][0]
//                              .containsKey("name") &&
//                          widget.relatednewsjsonList["posts"][index]["tags"][0]
//                                  ["name"] !=
//                              null &&
//                          widget.relatednewsjsonList["posts"][index]["tags"][0]
//                                  ["name"]
//                              .containsKey("ta") &&
//                          widget.relatednewsjsonList["posts"][index]["tags"][0]
//                                  ["name"]["ta"] !=
//                              null) {
//                        return Builder(builder: (context) {
//                          if (widget.relatednewsjsonList["posts"]
//                                      [widget.indexvalue]["tags"][0]["name"]
//                                  ["ta"] ==
//                              widget.relatednewsjsonList["posts"][index]["tags"]
//                                  [0]["name"]["ta"]) {
//                            return InkWell(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => Related(
//                                            index: index,
//                                            jsonList: widget.jsonList,
//                                            categoryjsonList:
//                                                widget.categoryjsonList,
//                                            relatednewsjsonList:
//                                                widget.relatednewsjsonList,
//                                            galleryresponselist:
//                                                widget.galleryresponselist)));
//                              },
//                              child: Padding(
//                                padding: const EdgeInsets.only(bottom: 8.0),
//                                child: Container(
//                                    width: 300,
//                                    child: Column(
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.start,
//                                        children: [
//                                          Builder(builder: (context) {
//                                            if (widget.relatednewsjsonList[
//                                                            "posts"][index]
//                                                            ["image_data"]
//                                                        .toString() ==
//                                                    "[]" ||
//                                                widget.relatednewsjsonList[
//                                                                "posts"][index]
//                                                            ["image_data"][0]
//                                                        ["original_url"] ==
//                                                    null) {
//                                              return Container();
//                                            } else {
//                                              return CachedNetworkImage(
//                                                height: 250,
//                                                fit: BoxFit.cover,
//                                                width: double.infinity,
//                                                imageUrl:
//                                                    widget.relatednewsjsonList[
//                                                                "posts"][index]
//                                                            ["image_data"][0]
//                                                        ["original_url"],
//                                              );
//                                            }
//                                          }),
//                                          Padding(
//                                            padding:
//                                                const EdgeInsets.only(top: 8.0),
//                                            child: Text(
//                                              widget.relatednewsjsonList[
//                                                      "posts"][index]
//                                                  ["subcategory"]["name"],
//                                              style: TextStyle(
//                                                color: Colors.blue,
//                                                fontWeight: FontWeight.bold,
//                                              ),
//                                            ),
//                                          ),
//                                          Padding(
//                                            padding: const EdgeInsets.only(
//                                              top: 8.0,
//                                              bottom: 8.0,
//                                            ),
//                                            child: Text(
//                                              widget.relatednewsjsonList[
//                                                  "posts"][index]["title"],
//                                            ),
//                                          ),
//                                          Divider(
//                                            color: Colors.grey,
//                                          )
//                                        ])),
//                              ),
//                            );
//                          } else {
//                            return Container();
//                          }
//                        });
//                      } else {
//                        return Container();
//                      }
//                    }),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//                child: Column(
//                  children: [
//                    Align(
//                      alignment: Alignment.centerLeft,
//                      child: Container(
//                        height: 45,
//                        decoration: BoxDecoration(
//                          color: Colors.blue,
//                          border: Border.all(
//                            color: Colors.blue,
//                            width: 2.0,
//                          ),
//                        ),
//                        padding: EdgeInsets.all(10.0),
//                        child: Text(
//                          "Related News",
//                          style: TextStyle(color: Colors.white),
//                        ),
//                      ),
//                    ),
//                    Container(height: 0, child: Divider(color: Colors.blue)),
//                  ],
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//                child: ListView.builder(
//                    itemCount: widget.relatednewsjsonList["posts"].length,
//                    physics: NeverScrollableScrollPhysics(),
//                    shrinkWrap: true,
//                    scrollDirection: Axis.vertical,
//                    itemBuilder: (context, index) {
//                      if (index != widget.indexvalue) {
//                        return Padding(
//                            padding: const EdgeInsets.only(bottom: 8, top: 8.0),
//                            child: InkWell(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => Related(
//                                              index: index,
//                                              relatednewsjsonList:
//                                                  widget.relatednewsjsonList,
//                                              jsonList: widget.jsonList,
//                                              categoryjsonList:
//                                                  widget.categoryjsonList,
//                                              galleryresponselist:
//                                                  widget.galleryresponselist,
//                                            )));
//                              },
//                              child: Container(
//                                  child: Column(children: [
//                                Builder(builder: (context) {
//                                  if (widget.relatednewsjsonList["posts"][index]
//                                                  ["image_data"]
//                                              .toString() ==
//                                          "[]" ||
//                                      widget.relatednewsjsonList["posts"][index]
//                                                  ["image_data"][0]
//                                              ["original_url"] ==
//                                          null) {
//                                    return Container();
//                                  } else {
//                                    return CachedNetworkImage(
//                                      height: 250,
//                                      fit: BoxFit.cover,
//                                      width: double.infinity,
//                                      imageUrl:
//                                          widget.relatednewsjsonList["posts"]
//                                                  [index]["image_data"][0]
//                                              ["original_url"],
//                                    );
//                                  }
//                                }),
//                                Padding(
//                                  padding: const EdgeInsets.only(top: 8.0),
//                                  child: Container(
//                                    width: 350,
//                                    child: Text(
//                                      widget.relatednewsjsonList["posts"][index]
//                                          ["title"],
//                                      style: TextStyle(
//                                        color: Colors.red,
//                                        fontWeight: FontWeight.bold,
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.only(top: 8.0),
//                                  child: Text(
//                                    widget.relatednewsjsonList["posts"][index]
//                                        ["subcategory"]["name"],
//                                  ),
//                                ),
//                                Divider(
//                                  color: Colors.grey,
//                                )
//                              ])),
//                            ));
//                      } else {
//                        return Container();
//                      }
//                    }),
//              )