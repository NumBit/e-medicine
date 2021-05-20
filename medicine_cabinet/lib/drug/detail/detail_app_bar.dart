import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({
    Key? key,
    required this.model,
  }) : super(key: key);

  final DrugModel model;

  @override
  Widget build(BuildContext context) {
    print(model);
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.edit,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            NavigationState nav = Get.find();
            print("tap" + model.name!);
            print(Get.key);
            Get.toNamed(
              "/edit_drug",
              arguments: model,
              id: nav.navigatorId.value,
            );
          },
        )
      ],
      title: Tooltip(
        message: model.name!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                model.name!,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 30),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
