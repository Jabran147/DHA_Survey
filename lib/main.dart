import 'package:dha_cleaning_app/model/phase_model.dart';
import 'package:dha_cleaning_app/model/phase_record.dart';
import 'package:dha_cleaning_app/utils/country_demo.dart';
import 'package:dha_cleaning_app/utils/shared_service.dart';
import 'package:dha_cleaning_app/widgets/demo_phase.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'dart:io';
import './screens/splash_screen.dart';
import './screens/login.dart';
import './screens/homepage.dart';
import './model/maintenance_record.dart';
import './model/user_record.dart';
import './model/phase_record.dart';
import './utils/country_demo.dart';

Widget _defaultHome = const SplashScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool result = await SharedService.isLoggedIn();
  if (result) {
    _defaultHome = const SplashScreen();
  }
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<MaintenanceRecord>(MaintenanceRecordAdapter());
  Hive.registerAdapter<UserRecord>(UserRecordAdapter());
  // Hive.registerAdapter(PhasesRecordsAdapter());
  await Hive.openBox<MaintenanceRecord>('maintenanceRecord');
  // await Hive.openBox<PhasesRecords>('phaseRecord');
  await Hive.openBox<UserRecord>('userRecord');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Hive.box<MaintenanceRecord>('maintenanceRecord').clear();
    // Hive.box<PhasesRecords>('phaseRecord').clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DHA Cleaning App',
      theme: ThemeData(
        fontFamily: 'SF-Pro',
      ),
      // home: const SplashScreen(),
      routes: {
        '/': (context) => _defaultHome,
        '/home': (context) => HomePage(),
        '/login': (context) => LoginScreen(),
      },
      // @override
      // void dispose() {
      //   Hive.close();
      //   super.dispose();
      // }
    );
  }
}
