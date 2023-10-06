import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nu_sources/modules/login_Pages/login_page.dart';

import 'layout/home_layout.dart';
import 'shared/login_cubit/cubit_observer.dart';
import 'shared/network/local/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
