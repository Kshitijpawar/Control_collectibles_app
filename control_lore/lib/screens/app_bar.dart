import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      title: const Text(
        'FBC Archives',
        style: TextStyle(
          fontFamily: 'ITCAvantGardeStd-Demi',
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
          color: Color.fromARGB(255, 231, 0, 13),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 40, 40, 40),
    );
  }
}
