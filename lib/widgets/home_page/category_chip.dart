import 'package:flutter/material.dart';
import '../../../model/category_model.dart';

class CategoryChip extends StatelessWidget {
  final CategoryModel category;
  final bool selected;
  final Function(bool) onSelected;

  const CategoryChip({
    super.key,
    required this.category,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: ChoiceChip(
        label: Text(category.name),
        selected: selected,
        selectedColor: Colors.green,
        backgroundColor: Colors.grey.shade200,
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontSize: 14,
        ),
        onSelected: onSelected,
      ),
    );
  }
}
