import 'package:control_lore/models/subgroup.dart';
import 'package:control_lore/screens/home_page.dart';
import 'package:control_lore/screens/item_page.dart';
import 'package:control_lore/screens/subgroup_page.dart';
// import 'package:control_lore/screens/test_page.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/item.dart';

class MyAppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          name: 'homepage',
          pageBuilder: (context, state) {
            // return MaterialPage(child: HomePage());
            return MaterialPage(child: HomePage());
          }),
      GoRoute(
          path: '/subgrouppage',
          name: 'subgrouppage',
          pageBuilder: (context, state) {
            // return MaterialPage(child: HomePage());
            // print(state.extra);
            // return MaterialPage(child: ItemPage());
            return MaterialPage(child: SubgroupPage(subgroups: state.extra as List<Subgroup>));
          }),
      GoRoute(
          path: '/itempage',
          name: 'itempage',
          pageBuilder: (context, state) {
            // return MaterialPage(child: HomePage());
            return MaterialPage(child: ItemPage(item: state.extra as Item,));
          }),
    ],
  );
}
