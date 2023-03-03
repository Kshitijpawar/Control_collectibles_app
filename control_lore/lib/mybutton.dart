import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        print("button was pressed");
        final testRef = FirebaseDatabase.instance.ref();
        final stringData = await testRef.get();
        // final theData = await testRef.child("Trench").get().toString();
        // final theData =
        // await testRef.child("correspondence").once(DatabaseEventType.value);

        // final test = await testRef.get();
        // testRef.or
        // print("printing");
        // print(test.value.toString());

        if (stringData.value != null) {
          // Directory appDocDirectory = await getApplicationDocumentsDirectory();
          // Directory? externalDir = await getDownloadsDirectory();
          Directory downloadsDir = Directory('/storage/emulated/0/Download');

          final filePath = downloadsDir.path;
          final fileObject = File('$filePath/counter.txt');
          // theData.snapshot.

          // Future<File> textFile = File("test.txt").create(recursive: true).then(
          //     (File file) =>
          //         file.writeAsString(theData.snapshot.value.toString()));

          fileObject.writeAsString(stringData.value.toString());
          print("Completed writing");
        } else {
          print("no Data available");
        }
      },
      child: Icon(Icons.ac_unit),
    );
  }
}
