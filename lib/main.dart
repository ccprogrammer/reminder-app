import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder_app/screens/example_ui_screen.dart';

import 'models/reminder.dart';
import 'repository/reminder_repository.dart';
import 'bloc/reminder_bloc.dart';
import 'screens/reminder_list_screen.dart';
import 'screens/reminder_detail_screen.dart';
import 'services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ReminderAdapter());
  Hive.registerAdapter(RecurrenceTypeAdapter());

  tz.initializeTimeZones();

  await NotificationService.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    NotificationService.listenForActions((reminder) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => ReminderDetailScreen(reminder: reminder),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReminderBloc(ReminderRepository()),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const ReminderListScreen(),
        // home: const ExampleUIScreen(),
      ),
    );
  }
}
