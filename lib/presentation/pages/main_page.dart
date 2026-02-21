import 'package:deutscht/data/models/group_model.dart';
import 'package:deutscht/presentation/pages/all_groups_page.dart';
import 'package:deutscht/presentation/pages/create_new_group_page.dart';
import 'package:deutscht/presentation/pages/group_page.dart';
import 'package:deutscht/presentation/pages/profile_page.dart';
import 'package:deutscht/presentation/pages/three_forms_page.dart';
import 'package:deutscht/presentation/pages/verbs_with_prepositions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../domain/get_groups_for_user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [AllGroupsPage(), ThreeFormsPage(), VerbsWithPrepositionsPage(), ProfilePage()][index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (val){
          setState(() {
            index = val;
          });
        },
        currentIndex: index,
        iconSize: 24,
        unselectedItemColor: Colors.grey,

        selectedItemColor: Colors.blue,
        unselectedLabelStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 12
        ),
        selectedLabelStyle: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w400,
            fontSize: 12
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/house.svg', color: (index == 0)?Colors.blue:Colors.grey,), label: "Home"),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/3_forms.svg', color: (index == 1)?Colors.blue:Colors.grey,), label: "3 forms"),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/preposition.svg', color: (index == 2)?Colors.blue:Colors.grey,), label: "Prepositions"),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/profile.svg', color: (index == 3)?Colors.blue:Colors.grey,), label: "Profile"),


        ],

      ),
    );
  }
}
