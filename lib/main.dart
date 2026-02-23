import 'package:deutscht/presentation/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://mhdudqozculuggkraetf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1oZHVkcW96Y3VsdWdna3JhZXRmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU4MTI5MDYsImV4cCI6MjA4MTM4ODkwNn0.MuM41INdxf_ERaWXkz1ZSYnlfzLBbvkUBLsEFvetdqE',
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
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blue),
      ),

    );
  }
}

