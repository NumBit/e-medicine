import 'package:flutter/material.dart';

class ChipFilter extends StatefulWidget {
  final String? name;
  const ChipFilter({
    Key? key,
    this.name,
  }) : super(key: key);

  @override
  _ChipFilterState createState() => _ChipFilterState();
}

class _ChipFilterState extends State<ChipFilter> {
  final String name = "Filter";
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: FilterChip(
        elevation: 3,
        backgroundColor: Colors.white,
        selectedColor: const Color(0x6006BCC1),
        label: Text(widget.name ?? "Empty"),
        selected: active,
        onSelected: (bool value) {
          setState(() {
            active = value;
          });
        },
      ),
    );
  }
}
