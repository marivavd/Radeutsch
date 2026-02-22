import 'package:deutscht/data/models/word_model.dart';
import 'package:flutter/material.dart';

class EditWordsPage extends StatefulWidget {
  List<WordModel> spWords;
  EditWordsPage({super.key, required this.spWords});


  @override
  State<EditWordsPage> createState() => _EditWordsPageState();
}

class _EditWordsPageState extends State<EditWordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
