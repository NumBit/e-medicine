import 'package:expandable/expandable.dart';
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
      color: Colors.transparent,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpandablePanel(
                  theme: ExpandableThemeData(
                    tapBodyToExpand: true,
                    tapBodyToCollapse: true,
                    useInkWell: true,
                    sizeCurve: Curves.decelerate,
                  ),
                  header: Container(
                    child: Text(
                      "Description",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  collapsed: Container(
                    child: Text(
                      widget.description,
                      overflow: TextOverflow.fade,
                      maxLines: 5,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  expanded: Container(
                    child: Text(
                      widget.description,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  // child: Text(
                  //   widget.description,
                  //   overflow: expanded ? null : TextOverflow.fade,
                  //   maxLines: expanded ? null : 5,
                  //   style: TextStyle(color: Colors.white, fontSize: 18),
                  // ),
                )
              ],
            )),
      ),
    );
  }
}
