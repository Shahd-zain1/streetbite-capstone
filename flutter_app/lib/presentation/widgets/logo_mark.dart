import 'package:flutter/material.dart';
import 'package:streetbite/core/theme/app_colors.dart';

class LogoMark extends StatelessWidget {
  const LogoMark({this.size = 96, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.brand, AppColors.brandDark],
        ),
      ),
      child: Icon(Icons.lunch_dining, size: size * 0.55, color: Colors.white),
    );
  }
}
