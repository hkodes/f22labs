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
