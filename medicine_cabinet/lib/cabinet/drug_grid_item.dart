import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:medicine_cabinet/drug/data/drug_photo_model.dart';
import 'package:medicine_cabinet/drug/data/drug_photo_repository.dart';
import 'package:medicine_cabinet/drug/detail/drug_detail_page.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/error/loading_widget.dart';
import 'package:medicine_cabinet/firebase/storage/storage.dart';
import 'package:medicine_cabinet/drug/package/data/package_repository.dart';

class DrugGridItem extends StatelessWidget {
  final List<String> categories = ["Fever"];
  final int count = 3;
  final DrugModel model;

  DrugGridItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
        tappable: false,
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        closedElevation: 5,
        transitionDuration: const Duration(milliseconds: 500),
        closedBuilder: (context, action) {
          return InkWellOverlay(
            openContainer: action,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardIcon(model: model),
                  CardName(model: model),
                  CardStats(model: model),
                ],
              ),
            ),
          );
        },
        openBuilder: (context, action) {
          return DrugDetailPage(
            id: model.id,
          );
        });
  }
}

class CardStats extends StatelessWidget {
  const CardStats({
    Key? key,
    required this.model,
  }) : super(key: key);

  final DrugModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            model.substance ?? "Not set",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        // Text(
        //   categories.first,
        //   textScaleFactor: 1.2,
        // ),
        StreamBuilder<int>(
            stream: PackageRepository(model.id).countPillsStream(),
            builder: (context, snapshot) {
              return getCounterText(snapshot.data ?? 0);
            })
      ],
    );
  }
}

class CardIcon extends StatelessWidget {
  const CardIcon({
    Key? key,
    required this.model,
  }) : super(key: key);

  final DrugModel model;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DrugPhotoModel>>(
        stream: DrugPhotoRepository(model.id).streamModels(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LoadingWidget();
          final photos = snapshot.data!;
          return Center(
              child: photos.isEmpty
                  ? Icon(
                      deserializeIcon(
                          jsonDecode(model.icon!) as Map<String, dynamic>),
                      color: Theme.of(context).primaryColorDark,
                      size: 50,
                    )
                  : FutureBuilder<String>(
                      future: Storage().getLink(photos.first.path!),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const LoadingWidget();
                        return SizedBox(
                          width: 100,
                          height: 70,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              )),
                        );
                      },
                    ));
        });
  }
}

class CardName extends StatelessWidget {
  const CardName({
    Key? key,
    required this.model,
  }) : super(key: key);

  final DrugModel model;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        model.name ?? "Not set",
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textScaleFactor: 1.5,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

Widget getCounterText(int count) {
  return Text(count == 0 ? "Empty" : "$count ks",
      textScaleFactor: 1.2,
      style: TextStyle(
        color: Color(count <= 3 ? 0xffc33149 : 0xff12263a),
      ));
}

class InkWellOverlay extends StatelessWidget {
  const InkWellOverlay({
    this.openContainer,
    this.width,
    this.height,
    this.child,
  });

  final VoidCallback? openContainer;
  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}
