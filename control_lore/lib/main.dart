
// import 'dart:async';
// import 'package:control_lore/models/group.dart';
import 'package:control_lore/routes/app_route_config.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'dart:convert';

// Future<dynamic> fetchStr() async {
//   await Future.delayed(const Duration(seconds: 2), () {});
//   final FirebaseApp _fbApp = await Firebase.initializeApp();
//   final List finalData = await fetchData();
//   if (finalData.isEmpty) {
//     return 'Hello World';
//   } else {
//     return finalData;
//   }
// }

// Future<List<Group>> fetchData() async {
// // Future<String> fetchData() async {
  
//   final List<Group> finalData = [];
  
//   await Future.delayed(const Duration(seconds: 2), () {});
//   final FirebaseApp _fbApp = await Firebase.initializeApp();
//   // final List<Group>
  
//   final testRef = FirebaseDatabase.instance.ref();
//   final stringData = await testRef.get();
//   // print(stringData.value as Map<String, dynamic);
//   final jsonMap = stringData.value as Map;
//   jsonMap.forEach((key, value) {
//     // print(key);
//     finalData.add(Group.fromJson(key, value));
//     print("added one group");
//   });
//   // print(finalData);
//   return finalData;
//   // return "Data Loaded";
//   // print(jsonMap.keys.toList());
// }

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final Future<String> finalData = fetchData();
  // late final Future<List<Group>> theData;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   theData = fetchData();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(

      routeInformationParser: MyAppRouter().router.routeInformationParser,
      routerDelegate: MyAppRouter().router.routerDelegate,
      // routeInformationProvider: ,
      // title: 'Fetch Data Example',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Fetch New Data example'),
      //   ),
      //   body: Center(
      //     child: FutureBuilder<List<Group>>(
      //       future: theData,
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData) {
      //           // var ok = snapshot.data!.toString();
      //           List<Group> jsonData = snapshot.data!;
      //           // return Text('loaded the json: $ok');
      //           return GridView.builder(
      //               itemCount: jsonData.length,
      //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //                 crossAxisCount: 2,
      //               ),
      //               itemBuilder: (context, index) {
      //                 // String gName = jsonData[index].groupName;
      //                 return Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Container(
      //                     height: 50,
      //                     width: 50,
      //                     color: Colors.blue,
      //                     child: Text('${jsonData[index].groupName}'),
      //                   ),
      //                 );
      //               });
      //         } else if (snapshot.hasError) {
      //           return Text("${snapshot.error}");
      //         }
      //         // By default, show a loading spinner
      //         return CircularProgressIndicator();
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
