import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/main/state/navigator_keys.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({
    Key key,
    this.model,
  }) : super(key: key);

  final DrugModel model;

  @override
  Widget build(BuildContext context) {
    print(model);
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
                NavigationState nav = Get.find();
                print("tap" + model.name);
                print(Get.key);
                Get.toNamed(
                  "/edit_drug",
                  arguments: model,
                  id: nav.navigatorId.value,
                );
                // Navigator.pushNamed(context, "/edit_drug", arguments: model);
                // Get.toNamed("/edit_drug", arguments: model);
              },
              borderRadius: BorderRadius.circular(50),
              child: Icon(
                Icons.edit,
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
