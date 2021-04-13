import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:medicine_cabinet/widgets/description.dart';

class DetailPage extends StatelessWidget {
  final String name;
  final String chemical;
  final List<String> categories;
  final List<String> dosages;
  final String description =
      "Nam ultricies metus ut dolor hendrerit, sit amet volutpat justo hendrerit. Aenean pretium, massa eget varius sagittis, mi lorem malesuada turpis, id ultricies purus erat at arcu. Proin egestas risus non ex faucibus interdum. Ut sagittis magna at ex ullamcorper, sed varius lorem condimentum. Nunc dignissim velit gravida rhoncus feugiat. Mauris ligula tortor, ornare dapibus efficitur a, fringilla nec neque. Pellentesque vel ante odio. Duis efficitur malesuada tempor. Aliquam maximus, libero bibendum tristique fermentum, quam metus maximus elit, ut fermentum magna turpis vel urna. Mauris non metus augue. Mauris lectus massa, sodales non lacus id, sollicitudin semper felis. Donec porta leo quis diam hendrerit, sed bibendum arcu scelerisque.";
  const DetailPage({
    Key key,
    this.name = "Paralen",
    this.chemical = "Paracetamol",
    this.categories = const ["Fever", "Pain", "Pain", "Pain", "Pain"],
    this.dosages = const ["50mg", "100mg"],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: CustomScrollView(slivers: [
          SliverAppBar(
            pinned: true,
            //floating: true,
            //snap: true,

            title: Text(
              name,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w300),
            ),
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                name,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                chemical,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Wrap(
                                  spacing: 5,
                                  direction: Axis.horizontal,
                                  children: categories
                                      .map((category) => Container(
                                            child: Chip(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              backgroundColor: Theme.of(context)
                                                  .primaryColorDark,
                                              label: Text(
                                                category,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.medical_services_outlined,
                          color: Color(0xff12263a),
                          size: 100,
                        ),
                      ],
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor,
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                      child: Description(
                        description: description,
                      )),
                ),
              ),
              Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              ItemCard(),
              ItemCard(),
              ItemCard(),
              ItemCard(),
            ]),
          )
        ]),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "50mg",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Exp. 12/2021"),
            Text(
              "40 ks",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(50),
                child: Icon(
                  Icons.add,
                  color: Colors.red,
                  size: 50,
                ),
              ),
              Text(
                "40 Ks",
                textScaleFactor: 1.8,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {},
                child: Icon(
                  Icons.remove,
                  color: Colors.black,
                  size: 50,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
