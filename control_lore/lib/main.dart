// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'mybutton.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   MyApp({super.key});

//   final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
//   // final Future<String> str1 = "null" as Future<String>;
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       // home: const MyHomePage(title: 'Flutter Demo Home Page'),
//       home: FutureBuilder(
//         future: _fbApp,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             print("you have an error ${snapshot.error.toString()}");
//             return Text("somthing went wrong");
//           } else if (snapshot.hasData) {
//             return MyHomePage(title: "my amazing counter app");
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   Future<String> fetchStr() async {
//     await Future.delayed(const Duration(seconds: 5), () {});
//     return "Hello World!!";
//   }

//   // late Future<String> str1;
//   late Future<String> str1;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             MyButton(),
//             FutureBuilder<String>(
//               future: str1,
//               builder: ((context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Text(snapshot.data!);
//                 } else if (snapshot.hasError) {
//                   return Text('${snapshot.error}');
//                 }
//                 return CircularProgressIndicator();
//               }),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

import 'dart:async';
import 'package:control_lore/models/group.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

Future<String> fetchStr() async {
  await Future.delayed(const Duration(seconds: 2), () {});
  final FirebaseApp _fbApp = await Firebase.initializeApp();
  fetchData();
  return 'Hello World';
}

void fetchData() async {
  // final List<Group>
  final finalData = [];
  final testRef = FirebaseDatabase.instance.ref();
  final stringData = await testRef.get();
  // print(stringData.value as Map<String, dynamic);
  final jsonMap = stringData.value as Map;
  jsonMap.forEach((key, value) {
    // print(key);
    finalData.add(Group.fromJson(key, value));
    print("added one group");
  });
  print(finalData);
  // print(jsonMap.keys.toList());
}

void main() => runApp(MyApp(str: fetchStr()));

class MyApp extends StatelessWidget {
  final Future<String> str;

  MyApp({Key? key, required this.str}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch New Data example'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: str,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
