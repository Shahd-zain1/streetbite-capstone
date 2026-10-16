import 'package:flutter/material.dart';

class CartBadgeIcon extends StatelessWidget {
  const CartBadgeIcon({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: count > 0,
      label: Text('$count'),
      child: const Icon(Icons.shopping_bag_outlined),
    );
  }
}
