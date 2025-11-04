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
        label: Text(
          category.name,
          style: TextStyle(
            color: selected ? Colors.white : Colors.grey.shade700,
            fontSize: 14,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        selected: selected,
        selectedColor: Colors.deepOrange, // تغيير اللون ل deepOrange
        backgroundColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: selected ? Colors.deepOrange : Colors.grey.shade300,
            width: selected ? 0 : 1,
          ),
        ),
        elevation: selected ? 2 : 0,
        shadowColor: Colors.deepOrange.withOpacity(0.3),
        onSelected: onSelected,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}