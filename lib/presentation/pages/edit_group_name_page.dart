import 'package:deutscht/domain/use_case_change_name_of_group.dart';
import 'package:deutscht/presentation/pages/group_page.dart';
import 'package:deutscht/presentation/utils/show_dialogs.dart';
import 'package:flutter/material.dart';

import '../../data/models/group_model.dart';

class EditGroupNamePage extends StatefulWidget {
  final GroupModel group;
  const EditGroupNamePage({super.key, required this.group});


  @override
  State<EditGroupNamePage> createState() => _EditGroupNamePageState();




}

class _EditGroupNamePageState extends State<EditGroupNamePage> {
  late TextEditingController nameGroup;
  ChangeNameOfGroupUseCase useCase = ChangeNameOfGroupUseCase();
  bool isValid = true;


  @override
  void initState() {
    super.initState();
    nameGroup = TextEditingController(
      text: widget.group.groupName,
    );
  }

  @override
  void dispose() {
    nameGroup.dispose();
    super.dispose();
  }

  void onChange(_){
    setState(() {
      isValid = nameGroup.text.trim().isNotEmpty;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                  width: 40,
                  child: OutlinedButton(
                    onPressed: (){

                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back, color: Colors.black87,),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(5),
                    ),
                  ),
                ),
                  Spacer(),
                  Text('Change name of the list',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25,
                        fontWeight: FontWeight.w600
                    ),),
                  Spacer()



                ]
            ),
            SizedBox(height: 60,),
            Text(
              'Name of the list',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(height: 6,),
            SizedBox(
              height: 40,
              child: TextField(
                  controller: nameGroup,
                  onChanged: onChange,
                  style: TextStyle(color: Color(0xFF3A3A3A), fontSize: 14, height: 16/14, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color:  Color(0xFF5AB6F4)),),
                    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  )
              ),

            ),
            SizedBox(height: 70,),
            Align(
              alignment: AlignmentGeometry.center,
              child: SizedBox(
                height: 46,
                width: double.infinity,
                child: FilledButton(

                    onPressed: (nameGroup.text.trim().isNotEmpty)?()async{
                      showLoading(context);
                      useCase.pressChangeNameOfGroup(
                          widget.group.groupId,
                          nameGroup.text.trim(),
                              (_)async{
                            hideLoading(context);

                            if (!mounted) return;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GroupPage(group: GroupModel(groupId: widget.group.groupId, groupName: nameGroup.text.trim(), userId: widget.group.userId)))).then((value) => setState(() {}));


                          }, (String e)async{
                        hideLoading(context);
                        showError(context, e);});
                    }:null,
                    style: FilledButton.styleFrom(
                        backgroundColor: Color(0xFF5AB6F4)
                    ),
                    child: Text(
                        "Save changes"
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
