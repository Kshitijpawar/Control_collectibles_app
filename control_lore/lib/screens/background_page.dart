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
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 0.5,
                  image: AssetImage(
                    'assets/fbc.png',
                  ),
                  fit: BoxFit.fill),
            ),
          ),

        ),
        theChildWidget,
      ],
    );
  }
}
