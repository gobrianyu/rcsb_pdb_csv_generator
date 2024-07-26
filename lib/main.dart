import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rcsb_pdb_json2csv_flex/views/big_boss.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMaximizable(false);
    WindowManager.instance.setMinimumSize(const Size(1300, 800));
    WindowManager.instance.setMaximumSize(const Size(1300, 800));
  }

  Directory appDocDir = await getApplicationSupportDirectory();
  Hive.init(appDocDir.path);
  
  await Hive.openBox<Map>('mapBox');
  await Hive.openBox<List>('listBox');
  await Hive.openBox<List>('filterBox');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color.fromARGB(105, 121, 147, 168),
        )
      ),
      debugShowCheckedModeBanner: false,
      home: const BigBoss()
    );
  }
}

