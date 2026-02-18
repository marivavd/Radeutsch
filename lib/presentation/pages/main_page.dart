import 'package:deutscht/data/models/group_model.dart';
import 'package:deutscht/presentation/pages/create_new_group_page.dart';
import 'package:deutscht/presentation/pages/group_page.dart';
import 'package:deutscht/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../domain/get_groups_for_user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GroupModel> spGroups = [];
  @override
  void initState() {
    super.initState();
    loadGroups();
  }

  Future<void> loadGroups() async {
    final groups = await getGroupsForUser();
    setState(() {
      spGroups = groups;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 40),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Spacer(),
                  Text("Your vocabulary lists",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal
                    ),),
                  Spacer(),
                  GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())).then((value) => setState(() {}));
                    },
                    child: Container(
                      height: 30,
                      width: 30,

                      child: SvgPicture.asset('assets/profile.svg'),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30,),
              Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15

                      ),
                      itemCount: spGroups.length,

                      itemBuilder: (context, index) {
                        return FilledButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GroupPage(group: spGroups[index],))).then((value) => setState(() {}));
                        },
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                              spGroups[index].groupName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                            ),
                          ),

                        );
                      }
                  )
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 60,
                  width: 60,
                  child: FilledButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewGroupPage())).then((value) => setState(() {}));
                      },
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.all(5)
                      ),
                      child: Text('+',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400
                        ),
                      )
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
