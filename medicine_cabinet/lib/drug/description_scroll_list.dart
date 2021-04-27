import 'package:flutter/material.dart';
import 'package:medicine_cabinet/drug/package_card.dart';

import 'description.dart';
import 'detail_app_bar.dart';

class DescriptionScrollList extends StatelessWidget {
  const DescriptionScrollList({
    Key key,
    @required this.name,
    @required this.description,
  }) : super(key: key);

  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      DetailAppBar(name: name),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 250,
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          Description(description: description),
          Container(
            color: Theme.of(context).primaryColor,
            child: Divider(
              color: Theme.of(context).primaryColorDark,
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                PackageCard(),
                PackageCard(),
                PackageCard(),
                PackageCard(),
                PackageCard(),
                PackageCard(),
                PackageCard(),
              ],
            ),
          )
        ]),
      )
    ]);
  }
}
