import 'dart:ui';

import 'package:f22labs/explore_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatefulDragArea extends StatefulWidget {
  final Widget child;

  StatefulDragArea({required this.child});

  @override
  _DragAreaStateStateful createState() => _DragAreaStateStateful();
}

class _DragAreaStateStateful extends State<StatefulDragArea> {
  Offset position = const Offset(1, 1);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: position.dx,
          top: position.dy,
          child: Draggable(
            feedback: widget.child,
            childWhenDragging: Opacity(
              opacity: 0,
              child: widget.child,
            ),
            child: widget.child,
          ),
        )
      ],
    );
  }
}

class DetailsPage extends StatefulWidget {
  dynamic imageUrl;
  DetailsPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: (details) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ExplorePage()),
        );
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: StatefulDragArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(widget.imageUrl, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
