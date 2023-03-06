// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

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
      appBar: CustomAppBar(),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: BackgroundWidget(
          theChildWidget: ListView.builder(
              itemCount: subgroups.length,
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              // crossAxisCount: 1,
              // ),
              itemBuilder: (context, index) {
                // String gName = jsonData[index].groupName;
                // return GestureDetector(
                //   onTap: () {
                //     // GoRouter.of(context)
                //     // .pushNamed("subgrouppage", extra: jsonData[index].subgroups);
                //     print("bruh");
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Container(
                //       height: 50,
                //       width: 50,
                //       color: Colors.blue,
                //       child: Text('${subgroups[index].title}'),
                //     ),
                //   ),
                // );
                return ExpansionTile(
                  // onExpansionChanged: ,
                  collapsedIconColor: Color.fromARGB(255, 231, 0, 13),
                  iconColor: Colors.white,
                  childrenPadding: EdgeInsets.only(left: 30),
                  title: Text(
                    subgroups[index].title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Interstate",
                      color: Color.fromARGB(255, 231, 0, 13),
                    ),
                  ),
                  // childrenPadding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 5.0),
                  children: [
                    ListView.builder(
                      physics: ClampingScrollPhysics(),
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
                            color: Color.fromARGB(255, 0, 0, 0),
                            // margin: EdgeInsets.all(20),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                subgroups[index].items[idx].itemName,
                                style: TextStyle(
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
                    )
                  ],
                );
              })),
    );
  }
}
