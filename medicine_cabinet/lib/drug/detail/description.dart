import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  Description({Key key, this.description}) : super(key: key);
  final String description;

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Description"),
                    InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                        ))
                  ],
                ),
                children: [
                  Container(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 2000,
                          child: Text(
                            widget.description,
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Description",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.description,
                  maxLines: 5,
                  overflow: TextOverflow.fade,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
