import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({
    Key key,
    this.model,
  }) : super(key: key);

  final DrugModel model;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      title: Tooltip(
        message: model.name,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                model.name,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 30),
              ),
            ),
            InkWell(
              onTap: () {
                print("tap" + model.name);
                Navigator.pushNamed(context, "/edit_drug", arguments: model);
                // Get.toNamed("/edit_drug", arguments: model);
              },
              borderRadius: BorderRadius.circular(50),
              child: Icon(
                Icons.more_horiz,
                color: Theme.of(context).primaryColorDark,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
