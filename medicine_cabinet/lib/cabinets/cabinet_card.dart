import 'package:flutter/material.dart';

import 'cabinet_repository.dart';

class CabinetCard extends StatelessWidget {
  final String name;
  final String id;
  final bool isSelected;
  const CabinetCard({
    Key key,
    this.name,
    this.isSelected,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Card(
        elevation: 5,
        child: ExpansionTile(
          key: ObjectKey(id),
          leading: Icon(
            Icons.medical_services_outlined,
            color: Theme.of(context).primaryColorDark,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              if (isSelected)
                Tooltip(
                  message: "Opened cabinet",
                  child: Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColorDark,
                    size: 30,
                  ),
                )
            ],
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      CabinetRepository(context).remove(id);
                    },
                    child: Text(
                      "Edit",
                      style:
                          TextStyle(color: Theme.of(context).primaryColorDark),
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Share",
                      style:
                          TextStyle(color: Theme.of(context).primaryColorDark),
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Open",
                      style:
                          TextStyle(color: Theme.of(context).primaryColorDark),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
