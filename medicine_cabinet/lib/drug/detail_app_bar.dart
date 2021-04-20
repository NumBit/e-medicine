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
      title: Text(
        name,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 30,
            fontWeight: FontWeight.w300),
      ),
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(),
    );
  }
}
