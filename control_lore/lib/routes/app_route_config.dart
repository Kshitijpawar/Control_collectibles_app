import 'package:control_lore/models/subgroup.dart';
import 'package:control_lore/screens/chat_page.dart';
import 'package:control_lore/screens/home_page.dart';
import 'package:control_lore/screens/item_page.dart';
import 'package:control_lore/screens/subgroup_page.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/item.dart';

class MyAppRouter {
  GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
          path: '/',
          name: 'homepage',
          pageBuilder: (context, state) {
            return MaterialPage(
              child: HomePage(),
            );
          }),
      GoRoute(
        path: '/subgrouppage',
        name: 'subgrouppage',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: SubgroupPage(subgroups: state.extra as List<Subgroup>),
          );
        },
      ),
      GoRoute(
        path: '/itempage',
        name: 'itempage',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: ItemPage(
              item: state.extra as Item,
            ),
          );
        },
      ),
      GoRoute(
        path: '/chatpage',
        name: 'chatpage',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ChatPage(
              // item: state.extra as Item,
            ),
          );
        },
      ),
    ],
  );
}
