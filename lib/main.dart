import 'package:deutscht/presentation/pages/main_page.dart';
import 'package:deutscht/presentation/pages/sign_in_page.dart';
import 'package:deutscht/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://mhdudqozculuggkraetf.supabase.co',
    anonKey: 'sb_publishable_p5vfORtlC_SO_8r3_uzuQg_nkf-M5cD',
  );

  runApp(MyApp());
}

final supabase = Supabase.instance.client;




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radeutsch',
      home: SignInPage(),

    );
  }
}

