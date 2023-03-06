import 'package:control_lore/screens/background_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/group.dart';
import 'app_bar.dart';

Future<List<Group>> fetchData() async {
  final List<Group> finalData = [];

  await Future.delayed(const Duration(seconds: 2), () {});
  // ignore: unused_local_variable
  final FirebaseApp fbApp = await Firebase.initializeApp();

  final testRef = FirebaseDatabase.instance.ref();
  final stringData = await testRef.get();
  final jsonMap = stringData.value as Map;
  jsonMap.forEach((key, value) {
    finalData.add(Group.fromJson(key, value));
  });
  return finalData;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<List<Group>> theData;

  @override
  void initState() {
    super.initState();
    theData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: BackgroundWidget(
        theChildWidget: FutureBuilder<List<Group>>(
          future: theData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Group> jsonData = snapshot.data!;
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: jsonData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 7 / 10,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pushNamed('subgrouppage',
                            extra: jsonData[index].subgroups);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 500,
                          width: 500,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              opacity: 0.9,
                              fit: BoxFit.fill,
                              image: AssetImage(
                                'assets/${jsonData[index].groupName}.png',
                              ),
                            ),
                          ),
                          child: const Text(''),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
