import 'package:flutter/material.dart';
import 'package:medicine_cabinet/detail_page.dart';
import 'package:medicine_cabinet/profile.dart';
import 'package:medicine_cabinet/widgets/chip_filter.dart';
import 'package:medicine_cabinet/widgets/drug_grid_item.dart';
import 'package:medicine_cabinet/widgets/search_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color(0xff06BCC1),
          primaryColorDark: Color(0xff12263A),
          primarySwatch: Colors.teal,
          iconTheme: IconThemeData(color: Colors.white)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Menu")),
            ListTile(
              title: Text("Profile"),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile())),
            ),
            ListTile(
              title: Text("Schedule"),
              onTap: () {},
            )
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Home cabinet",
                textScaleFactor: 1.23,
                style: TextStyle(color: Colors.white),
              ),
            ),
            expandedHeight: 120,
            collapsedHeight: 60,
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.zero,
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor,
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: Offset(0, -2),
                  )
                ],
              ),
              child: Column(
                children: [
                  SearchBar(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: SizedBox(
                      height: 60,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ChipFilter(name: "Filter"),
                          ChipFilter(name: "Filter"),
                          ChipFilter(name: "Filter"),
                          ChipFilter(name: "Filter"),
                          ChipFilter(name: "Filter"),
                          ChipFilter(name: "Filter"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(15),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
                DrugGridItem(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Add medication',
        icon: Icon(
          Icons.add,
          size: 30,
        ),
        label: Text(
          "Add",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
