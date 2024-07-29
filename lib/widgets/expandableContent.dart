import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as html_parser;

class ExpandableContent extends StatefulWidget {
  final String content;

  ExpandableContent({required this.content});

  @override
  _ExpandableContentState createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var document = html_parser.parse(widget.content);
    String parsedString = document.body?.text ?? "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _isExpanded
                ? Html(
                    data: widget.content,
                    style: {
                      "body": Style(
                        fontSize: FontSize(18.0),
                      ),
                    },
                  )
                : Text(
                    parsedString,
                    style: TextStyle(fontSize: 18.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ),
        if (!_isExpanded)
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text('Show More', style: TextStyle(
              color: Colors.blue,
            ),),
          ),
      ],
    );
  }
}