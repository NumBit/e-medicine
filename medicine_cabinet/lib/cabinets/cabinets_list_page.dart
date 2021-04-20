import 'package:flutter/material.dart';

class CabinetsListPage extends StatelessWidget {
  const CabinetsListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cabinets'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Add cabinet',
          child: Icon(
            Icons.add,
            size: 30,
          )),
      body: ListView(
        children: [
          CabinetCard(name: "Cabinet", isSelected: true),
          CabinetCard(name: "Cabinet", isSelected: false),
          CabinetCard(name: "Cabinet", isSelected: false),
          CabinetCard(name: "Cabinet", isSelected: false),
          CabinetCard(name: "Cabinet", isSelected: false),
        ],
      ),
    );
  }
}

class CabinetCard extends StatelessWidget {
  final String name;
  final bool isSelected;
  const CabinetCard({
    Key key,
    this.name,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Card(
        elevation: 5,
        child: ExpansionTile(
          leading: Icon(Icons.medical_services_outlined),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 20),
              ),
              isSelected
                  ? Tooltip(
                      message: "Opened cabinet",
                      child: Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColorDark,
                        size: 30,
                      ),
                    )
                  : Tooltip(
                      message: "Select this cabinet",
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(50),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).primaryColorDark,
                          size: 30,
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
