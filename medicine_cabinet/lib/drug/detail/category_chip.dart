import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String? category;
  const CategoryChip({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Theme.of(context).primaryColorDark,
      label: Text(
        category!,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
