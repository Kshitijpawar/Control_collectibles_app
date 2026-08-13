import 'package:control_lore/routes/app_route_config.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());
final router = MyAppRouter().router;


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}