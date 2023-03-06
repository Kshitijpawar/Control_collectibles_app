import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final dynamic theChildWidget;
  const BackgroundWidget({super.key, required this.theChildWidget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                scale: 10.0,
                opacity: 0.5,
                image: AssetImage(
                  'assets/fbc.png',
                ),
              ),
            ),
          ),
        ),
        theChildWidget,
      ],
    );
  }
}
