import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/reminder.dart';
import 'repository/reminder_repository.dart';
import 'bloc/reminder_bloc.dart';
import 'screens/reminder_list_screen.dart';
import 'services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ReminderAdapter());

  tz.initializeTimeZones();

  await NotificationService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReminderBloc(ReminderRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ReminderListScreen(),
      ),
    );
  }
}
