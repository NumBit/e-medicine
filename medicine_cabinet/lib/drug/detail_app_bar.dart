import 'package:flutter/material.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      title: Tooltip(
        message: name,
        child: Text(
          name,
          textAlign: TextAlign.start,
          overflow: TextOverflow.fade,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w300,
              fontSize: 30),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
