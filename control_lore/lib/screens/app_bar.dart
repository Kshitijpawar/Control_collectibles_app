import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            print("Question answer button pressed");
            GoRouter.of(context).pushNamed('chatpage',
                            );
          },
          icon: const Icon(Icons.question_answer),
        ),
        IconButton(
          icon: const Icon(
            Icons.info_outlined,
          ),
          onPressed: () {
            return showAboutDialog(
              context: context,
              applicationName: "Control Wiki",
              applicationVersion: "1.0.0",
              applicationLegalese:
                  "Copyrights Reserved. Data scraped from Fandom. All images are property of Remedy Entertainment, used for personal use only.",
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text("Made by Kshitij Pawar"),
                ),
              ],
            );
          },
        )
      ],
      title: const Text(
        'FBC Archives',
        style: TextStyle(
          fontFamily: 'ITCAvantGardeStd-Demi',
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
          color: Color.fromARGB(255, 231, 0, 13),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 40, 40, 40),
    );
  }
}
