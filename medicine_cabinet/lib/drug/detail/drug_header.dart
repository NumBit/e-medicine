import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/data/drug_photo_model.dart';
import 'package:medicine_cabinet/drug/data/drug_photo_repository.dart';
import 'package:medicine_cabinet/error/loading_widget.dart';
import 'package:medicine_cabinet/firebase/storage/storage.dart';

class DrugHeader extends StatelessWidget {
  // final List<String> categories;
  final DrugModel model;
  const DrugHeader({
    Key? key,
    // required this.categories,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drug = model;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  drug.substance!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              // DrugCategories(categories: categories)
            ],
          ),
          StreamBuilder<List<DrugPhotoModel>>(
              stream: DrugPhotoRepository(model.id).streamModels(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const LoadingWidget();
                final photos = snapshot.data!;
                return Center(
                    child: photos.isEmpty
                        ? Icon(
                            deserializeIcon(jsonDecode(model.icon!)
                                as Map<String, dynamic>),
                            color: Theme.of(context).primaryColorDark,
                            size: 50,
                          )
                        : FutureBuilder<String>(
                            future: Storage().getLink(photos.first.path!),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Icon(
                                  deserializeIcon(jsonDecode(model.icon!)
                                      as Map<String, dynamic>),
                                  color: Theme.of(context).primaryColorDark,
                                  size: 50,
                                );
                              }
                              return SizedBox(
                                width: 120,
                                height: 120,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.network(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                    )),
                              );
                            },
                          ));
              })

          // Icon(
          //   deserializeIcon(jsonDecode(drug.icon!)),
          //   color: Theme.of(context).primaryColorDark,
          //   size: 100,
          // ),
        ],
      ),
    );
  }
}
