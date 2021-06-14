import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/cabinet_app_bar.dart';
import 'package:medicine_cabinet/cabinet/drug_grid_item.dart';
import 'package:medicine_cabinet/cabinet/search_bar.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/drug/data/drug_repository.dart';
import 'package:medicine_cabinet/error/loading_widget.dart';
import 'package:medicine_cabinet/main/state/filter_state.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/main/state/user_state.dart';

class CabinetPage extends StatelessWidget {
  const CabinetPage();

  @override
  Widget build(BuildContext context) {
    Get.put(FilterState());
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          CabinetAppBar(),
          SearchSliver(),
          DrugGrid(),
        ],
      ),
      floatingActionButton: AddDrugFAB(),
    );
  }
}

class AddDrugFAB extends StatelessWidget {
  const AddDrugFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        final NavigationState nav = Get.find();

        Get.toNamed("/add_drug", id: nav.navigatorId.value);
      },
      backgroundColor: Theme.of(context).primaryColor,
      tooltip: "Add medication",
      icon: const Icon(
        Icons.add,
        size: 30,
      ),
      label: const Text(
        "Add",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DrugGrid extends StatelessWidget {
  const DrugGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserState userState = Get.find();
    final FilterState filter = Get.find();
    
    return Obx(() => StreamBuilder<List<DrugModel>>(
        stream: DrugRepository(userState.openCabinetId.value)
            .streamModels(filter: filter.filter.value),
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.data == null) return const LoadingWidget();
          final drugs =
              snapshot.data!.map((m) => DrugGridItem(model: m)).toList();
          drugs
              .sort((a, b) => a.model.createdAt!.compareTo(b.model.createdAt!));
          return SliverPadding(
              padding: const EdgeInsets.all(15),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: drugs,
              ));
        }));
  }
}

class SearchSliver extends StatelessWidget {
  const SearchSliver({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.zero,
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor,
              offset: const Offset(0, -2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SearchBar(),
          ],
        ),
      ),
    );
  }
}
