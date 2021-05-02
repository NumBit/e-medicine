import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/cabinet_page.dart';
import 'package:medicine_cabinet/cabinets/cabinets_list_page.dart';
import 'package:medicine_cabinet/drug/add_edit/add_drug.dart';
import 'package:medicine_cabinet/drug/add_edit/edit_drug.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/main/state/navigator_keys.dart';
import 'package:medicine_cabinet/profile/profile_page.dart';
import 'package:medicine_cabinet/schedule/schedule_page.dart';

class TabNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TabState();
}

class TabState extends State<TabNavigation>
    with SingleTickerProviderStateMixin {
  var _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var nav = Get.put(NavigationState());
    return WillPopScope(
      onWillPop: () async {
        var isFirst =
            !await Get.nestedKey(nav.navigatorId.value).currentState.maybePop();
        print(isFirst);
        return isFirst;
      },
      child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              CabinetNavigatorPage(navigatorKey: Get.nestedKey(0)),
              Navigator(
                key: Get.nestedKey(1),
                onGenerateRoute: (routeSettings) {
                  print(Get.key);

                  return MaterialPageRoute(
                    builder: (context) => SchedulePage(),
                  );
                },
              ),
              Navigator(
                key: Get.nestedKey(2),
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  );
                },
              )
            ],
            controller: _controller,
          ),
          bottomNavigationBar: Container(
            color: Theme.of(context).primaryColorDark,
            height: 60,
            child: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              onTap: (index) {
                nav.navigatorId.value = index;
              },
              tabs: [
                Tab(
                  icon: Icon(Icons.medical_services),
                  text: "Cabinet",
                  iconMargin: EdgeInsets.only(bottom: 5),
                ),
                Tab(
                  icon: Icon(Icons.calendar_today),
                  text: "Schedule",
                  iconMargin: EdgeInsets.only(bottom: 5),
                ),
                Tab(
                  icon: Icon(Icons.account_circle),
                  text: "Profile",
                  iconMargin: EdgeInsets.only(bottom: 5),
                ),
              ],
              controller: _controller,
            ),
          )),
    );
  }
}

class CabinetNavigatorPage extends StatefulWidget {
  const CabinetNavigatorPage({
    Key key,
    @required GlobalKey<NavigatorState> navigatorKey,
  })  : _navigatorKey = navigatorKey,
        super(key: key);

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  _CabinetNavigatorPageState createState() => _CabinetNavigatorPageState();
}

class _CabinetNavigatorPageState extends State<CabinetNavigatorPage>
    with AutomaticKeepAliveClientMixin<CabinetNavigatorPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      initialRoute: "/",
      key: widget._navigatorKey,
      onGenerateRoute: (routeSettings) {
        print(routeSettings.name);
        if (routeSettings.name == "/")
          return GetPageRoute(
            page: () => CabinetPage(),
          );
        else if (routeSettings.name == "/add_drug")
          return GetPageRoute(page: () => AddDrug());
        else if (routeSettings.name == "/cabinets")
          return GetPageRoute(page: () => CabinetsListPage());
        else if (routeSettings.name == "/edit_drug")
          return GetPageRoute(
            page: () => EditDrug(
              model: routeSettings.arguments,
            ),
          );
        return GetPageRoute(
            page: () => Container(
                  color: Colors.deepOrange,
                ));
      },
    );
  }
}
