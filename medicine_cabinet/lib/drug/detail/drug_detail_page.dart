import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/data/drug_photo_model.dart';
import 'package:medicine_cabinet/drug/data/drug_photo_repository.dart';
import 'package:medicine_cabinet/drug/data/drug_repository.dart';
import 'package:medicine_cabinet/drug/detail/add_package.dart';
import 'package:medicine_cabinet/drug/detail/description.dart';
import 'package:medicine_cabinet/drug/detail/detail_app_bar.dart';
import 'package:medicine_cabinet/drug/detail/packages_list.dart';
import 'package:medicine_cabinet/error/loading_widget.dart';
import 'package:medicine_cabinet/firebase/storage/storage.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';
import 'drug_header.dart';

class DrugDetailPage extends StatelessWidget {
  final String? id;
  final List<String> categories;
  final List<String> dosages;
  const DrugDetailPage({
    Key? key,
    this.categories = const ["Fever", "Pain", "Pain", "Pain", "Pain"],
    this.dosages = const ["50mg", "100mg"],
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserState userState = Get.find();
    return StreamBuilder<DrugModel>(
        stream: DrugRepository(userState.openCabinetId.value).streamModel(id),
        initialData: DrugModel(
          id: "",
          description: "",
          icon: "",
          substance: "",
          name: "",
        ),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Center(child: Container(child: Text("Please go back")));
          var drug = snapshot.data!;
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: CustomScrollView(
              slivers: [
                DetailAppBar(
                  model: drug,
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Carousel(drug: drug),
                  Description(description: drug.description),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColorDark),
                            onPressed: () {
                              Get.dialog(AddPackage(drugId: drug.id));
                            },
                            child: Text("Add Package")),
                      ],
                    ),
                  ),
                ])),
                PackagesList(model: drug),
              ],
            ),
          );
        });
  }
}

class Carousel extends StatelessWidget {
  const Carousel({
    Key? key,
    required this.drug,
  }) : super(key: key);

  final DrugModel drug;

  @override
  Widget build(BuildContext context) {
    final current = 0.obs;
    return Container(
        color: Colors.white,
        child: StreamBuilder<List<DrugPhotoModel>>(
            stream: DrugPhotoRepository(drug.id).streamModels(),
            initialData: [],
            builder: (context, snapshot) {
              if (snapshot.data == null) return LoadingWidget();
              List<Widget> items;
              items = snapshot.data!.map((e) {
                return FutureBuilder<String>(
                  future: Storage().getLink(e.path!),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return LoadingWidget();
                    return InkWell(
                      child: Image.network(snapshot.data!),
                      onTap: () => Get.dialog(Dialog(
                        child: Stack(
                          children: [
                            Container(
                              width: 5000,
                              child: Image.network(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Theme.of(context).errorColor,
                                  ),
                                  onPressed: () async {
                                    Get.back();
                                    await Storage().deleteFile(e.path);
                                    DrugPhotoRepository(e.drugId).delete(e.id);
                                  },
                                ))
                          ],
                        ),
                      )),
                    );
                  },
                );
              }).toList();
              var newItems = [
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: DrugHeader(model: drug)),
                ...items,
                AddPhoto(
                  items: items,
                  drugId: drug.id,
                )
              ];
              items = newItems;
              return Column(children: [
                CarouselSlider(
                  items: items,
                  options: CarouselOptions(
                    height: 150,
                    enableInfiniteScroll: false,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) => current.value = index,
                  ),
                ),
                CarouselIndicator(items: items, current: current)
              ]);
            }));
  }
}

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    Key? key,
    required this.items,
    required this.current,
  }) : super(key: key);

  final List<Widget> items;
  final RxInt current;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.map((obj) {
            int index = items.indexOf(obj);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: current.value == index
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).primaryColorDark.withOpacity(0.4),
              ),
            );
          }).toList(),
        ));
  }
}

class AddPhoto extends StatelessWidget {
  final String drugId;
  final List<Widget> items;
  const AddPhoto({Key? key, required this.items, required this.drugId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).primaryColorDark,
            width: 3,
          )),
      child: IconButton(
        icon: Icon(
          Icons.add_photo_alternate_outlined,
          size: 35,
          color: Theme.of(context).primaryColorDark,
        ),
        onPressed: () async {
          var pickedFile =
              await ImagePicker().getImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            await Storage().uploadFile(pickedFile.path, pickedFile.path);
            DrugPhotoRepository(drugId).add(DrugPhotoModel(
                drugId: drugId,
                path: pickedFile.path,
                createdAt: Timestamp.now()));
          }
        },
        tooltip: "Add Picture",
      ),
    );
  }
}
