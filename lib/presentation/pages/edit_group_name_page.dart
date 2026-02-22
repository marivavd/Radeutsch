import 'package:flutter/material.dart';

import '../../data/models/group_model.dart';

class EditGroupNamePage extends StatefulWidget {
  final GroupModel group;
  const EditGroupNamePage({super.key, required this.group});


  @override
  State<EditGroupNamePage> createState() => _EditGroupNamePageState();
}

class _EditGroupNamePageState extends State<EditGroupNamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
