import 'package:deutscht/data/models/word_model.dart';
import 'package:flutter/material.dart';

class CardOfWord extends StatefulWidget {
  final WordModel modelWord;
  const CardOfWord({super.key, required this.modelWord});

  @override
  State<CardOfWord> createState() => _CardOfWordState();
}

class _CardOfWordState extends State<CardOfWord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
