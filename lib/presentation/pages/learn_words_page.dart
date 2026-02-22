import 'package:deutscht/data/models/word_model.dart';
import 'package:flutter/material.dart';

class LearnWordsPage extends StatefulWidget {
  final List<WordModel> spWords;
  const LearnWordsPage({super.key, required this.spWords});


  @override
  State<LearnWordsPage> createState() => _LearnWordsPageState();
}

class _LearnWordsPageState extends State<LearnWordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
