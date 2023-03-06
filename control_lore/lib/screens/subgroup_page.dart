import 'package:control_lore/screens/app_bar.dart';
import 'package:control_lore/screens/background_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/subgroup.dart';

class SubgroupPage extends StatelessWidget {
  final List<Subgroup> subgroups;
  const SubgroupPage({super.key, required this.subgroups});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: BackgroundWidget(
        theChildWidget: ListView.builder(
          itemCount: subgroups.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              collapsedIconColor: const Color.fromARGB(255, 231, 0, 13),
              iconColor: Colors.white,
              childrenPadding: const EdgeInsets.only(left: 30),
              title: Text(
                subgroups[index].title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Interstate",
                  color: Color.fromARGB(255, 231, 0, 13),
                ),
              ),
              children: [
                ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: subgroups[index].items.length,
                  itemBuilder: (ctx, idx) {
                    return GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pushNamed('itempage',
                            extra: subgroups[index].items[idx]);
                      },
                      child: Card(
                        shadowColor: Colors.red,
                        elevation: 5.0,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            subgroups[index].items[idx].itemName,
                            style: const TextStyle(
                              fontFamily: 'AGBuchBQ-Regular',
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 141, 141, 143),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
