import 'package:deutscht/presentation/pages/create_new_group_page.dart';
import 'package:deutscht/presentation/pages/group_page.dart';
import 'package:flutter/material.dart';

import '../../data/models/group_model.dart';
import '../../domain/get_groups_for_user.dart';

class AllGroupsPage extends StatefulWidget {
  const AllGroupsPage({super.key});

  @override
  State<AllGroupsPage> createState() => _AllGroupsPageState();
}

class _AllGroupsPageState extends State<AllGroupsPage> {
  List<GroupModel> spGroups = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadGroups();
  }

  Future<void> loadGroups() async {
    final data = await getGroupsForUser();

    if (!mounted) return;

    setState(() {
      spGroups = data;
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFA2D6F9),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xFFEAF6FF),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              Align(
                alignment: AlignmentGeometry.topCenter,
                 child:  Text("Your vocabulary lists",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal
                    ),),
              ),
              SizedBox(height: 10,),
              Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15

                      ),
                      itemCount: spGroups.length,

                      itemBuilder: (context, index) {
                        return FilledButton(onPressed: ()async{
                          final result = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GroupPage(group: spGroups[index]),
                            ),
                          );


                          if (result == true) {
                            setState(() => isLoading = true);
                            await loadGroups();
                          }
                        },
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Color(0xFF5AB6F4), width: 2)
                            ),
                          ),
                          child: Text(
                            spGroups[index].groupName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF5AB6F4),
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                        );
                      }
                  )
              ),
              SizedBox(height: 10,)




            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF5AB6F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
          highlightElevation: 0,
          child: Text('+',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,

              ),),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewGroupPage())).then((value) => setState(() {}));
          }),

    );
  }
}
