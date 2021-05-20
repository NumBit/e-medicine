import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_cabinet/cabinet/cabinet_page.dart';
import 'package:medicine_cabinet/cabinets/cabinets_list_page.dart';
import 'package:medicine_cabinet/drug/add_edit/add_drug.dart';
import 'package:medicine_cabinet/drug/add_edit/edit_drug.dart';
import 'package:medicine_cabinet/drug/data/drug_model.dart';
import 'package:medicine_cabinet/main/state/navigation_state.dart';
import 'package:medicine_cabinet/profile/profile_page.dart';
import 'package:medicine_cabinet/schedule/create_schedule.dart';
import 'package:medicine_cabinet/schedule/data/schedule_model.dart';
import 'package:medicine_cabinet/schedule/edit_one_schedule.dart';
import 'package:medicine_cabinet/schedule/edit_schedule_plan.dart';
import 'package:medicine_cabinet/schedule/schedule_page.dart';

class TabNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TabState();
}

class TabState extends State<TabNavigation>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    var nav = Get.put(NavigationState());
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller!.addListener(() {
      nav.navigatorId.value = _controller!.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    NavigationState nav = Get.find();
    return WillPopScope(
      onWillPop: () async {
        var isFirst = !await Get.nestedKey(nav.navigatorId.value)!
            .currentState!
            .maybePop();
        return isFirst;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: TabBarView(
          // physics: NeverScrollableScrollPhysics(),
          children: [
            CabinetNavigatorPage(navigatorKey: Get.nestedKey(0)),
            ScheduleNavigatorPage(navigatorKey: Get.nestedKey(1)),
            ProfileNNavigatorPage(navigatorKey: Get.nestedKey(2))
          ],
          controller: _controller,
        ),
        bottomNavigationBar: BottomTabBar(controller: _controller),
      ),
    );
  }
}

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({
    Key? key,
    required controller,
  })   : _controller = controller,
        super(key: key);

  final TabController? _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      height: 60,
      child: TabBar(
        labelColor: Colors.white,
        indicatorColor: Colors.white,
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
    );
  }
}

class ProfileNNavigatorPage extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;

  const ProfileNNavigatorPage({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => ProfilePage(),
        );
      },
    );
  }
}

class ScheduleNavigatorPage extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;

  const ScheduleNavigatorPage({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  _ScheduleNavigatorPageState createState() => _ScheduleNavigatorPageState();
}

class _ScheduleNavigatorPageState extends State<ScheduleNavigatorPage>
    with AutomaticKeepAliveClientMixin<ScheduleNavigatorPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      initialRoute: "/",
      key: widget.navigatorKey,
      onGenerateRoute: (routeSettings) {
        if (routeSettings.name == "/")
          return GetPageRoute(page: () => SchedulePage());
        else if (routeSettings.name == "/create_schedule")
          return GetPageRoute(page: () => CreateSchedule());
        else if (routeSettings.name == "/edit_one_schedule")
          return GetPageRoute(
              page: () => EditOneSchedule(
                  model: routeSettings.arguments == null
                      ? ScheduleModel()
                      : routeSettings.arguments as ScheduleModel));
        else if (routeSettings.name == "/edit_schedule_plan")
          return GetPageRoute(
              page: () => EditSchedulePlan(
                  schedulerId: routeSettings.arguments as String?));
        return GetPageRoute(
            page: () => Container(
                  color: Colors.deepOrange,
                ));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }
}

class CabinetNavigatorPage extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;

  const CabinetNavigatorPage({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

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
      key: widget.navigatorKey,
      onGenerateRoute: (routeSettings) {
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
                  model: routeSettings.arguments == null
                      ? DrugModel()
                      : routeSettings.arguments as DrugModel));
        return GetPageRoute(
            page: () => Container(
                  color: Colors.deepOrange,
                ));
      },
    );
  }
}
