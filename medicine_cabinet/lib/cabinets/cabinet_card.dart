import 'package:flutter/material.dart';
import 'package:medicine_cabinet/cabinet/data/cabinet_model.dart';
import 'package:medicine_cabinet/cabinets/edit_cabinet.dart';
import 'package:medicine_cabinet/main/app_state.dart';
import 'package:provider/provider.dart';

class CabinetCard extends StatelessWidget {
  final CabinetModel model;
  const CabinetCard({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Card(
        elevation: 5,
        child: ExpansionTile(
          key: ObjectKey(model.id),
          leading: Icon(
            Icons.medical_services_outlined,
            color: Theme.of(context).primaryColorDark,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  model.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              if (Provider.of<AppState>(context).cabinet == model.id)
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
                      showDialog(
                        context: context,
                        builder: (context) => EditCabinet(model: model),
                      );
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
                    onPressed: () {
                      var state = Provider.of<AppState>(context, listen: false);
                      state.cabinet = model.id;
                      Navigator.popUntil(context, ModalRoute.withName("/"));
                    },
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
