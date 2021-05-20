import 'package:flutter/material.dart';

import 'category_chip.dart';

class DrugCategories extends StatelessWidget {
  const DrugCategories({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Wrap(
          spacing: 5,
          direction: Axis.horizontal,
          children: categories
              .map(
                (category) => CategoryChip(
                  category: category,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
