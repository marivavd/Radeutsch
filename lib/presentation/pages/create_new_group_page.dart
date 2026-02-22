import 'package:deutscht/domain/use_case_add_word.dart';
import 'package:deutscht/presentation/pages/main_page.dart';
import 'package:deutscht/presentation/widgets/container_of_word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/use_case_add_new_group.dart';
import '../utils/show_dialogs.dart';

class CreateNewGroupPage extends StatefulWidget {
  const CreateNewGroupPage({super.key});

  @override
  State<CreateNewGroupPage> createState() => _CreateNewGroupPageState();
}

class _CreateNewGroupPageState extends State<CreateNewGroupPage> {
  TextEditingController nameGroup = TextEditingController();
  TextEditingController germanWord = TextEditingController();
  TextEditingController russianWord = TextEditingController();
  bool isValid = false;
  Map<String, String> slWords = {};
  AddNewGroupUseCase GroupUseCase = AddNewGroupUseCase();
  AddNewWordUseCase WordUseCase = AddNewWordUseCase();




  void onChange(_){
    setState(() {
      isValid = germanWord.text.isNotEmpty && russianWord.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [SizedBox(
                  width: 40,
                  child: OutlinedButton(
                    onPressed: (){

                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back, color: Colors.black87,),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(5)
                    ),
                  ),
                ),
                  SizedBox(
                    height: 40,
                    width: 90,
                    child: FilledButton(

                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.blue
                        ),
                        onPressed: (nameGroup.text.isNotEmpty)?()async{
                          showLoading(context);
                          GroupUseCase.pressButtonDone(nameGroup.text,
                                  (idGroup){
                                for (int i = 0; i < slWords.length; i++){
                                  WordUseCase.pressAddNewWord(idGroup,
                                      slWords.keys.toList()[i],
                                      slWords[slWords.keys.toList()[i]] ?? "",
                                          (_){
                                      },
                                          (String e)async{
                                        hideLoading(context);
                                        showError(context, e);

                                      });
                                }
                                hideLoading(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage())).then((value) => setState(() {}));
                              },
                                  (String e)async{
                                hideLoading(context);
                                showError(context, e);

                              });
                        }:null, child: Text('Done',
                    style: TextStyle(
                      fontWeight: FontWeight.w600
                    ),)),
                  )
                ]
              ),
              Text(
                      'Name of a list',
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
                            borderSide: BorderSide(color: Colors.blue),),
                          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                        )
                    ),

                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: Text("Words",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black
                      ),),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    height: 186,
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey)

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(

                              child: SizedBox(
                                child: SvgPicture.asset("assets/Flag_of_Germany.svg", fit: BoxFit.cover,),
                                height: 35,
                                width: 35,
                              )
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: SizedBox(
                              height: 40,
                              child: TextField(
                                  controller: germanWord,
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
                                      borderSide: BorderSide(color: Colors.blue),),
                                    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                                  )
                              ),),)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            ClipOval(

                                child: SizedBox(
                                  child: SvgPicture.asset("assets/Flag_of_Russia.svg", fit: BoxFit.cover,),
                                  height: 35,
                                  width: 35,
                                )
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: SizedBox(
                                height: 40,
                                child: TextField(
                                    controller: russianWord,
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
                                        borderSide: BorderSide(color: Colors.blue),),
                                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                                    )
                                ),),)
                          ],
                        ),
                        SizedBox(height: 14,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            SizedBox(
                              height: 40,

                              child: FilledButton(

                                  onPressed: (isValid)?(){
                                    setState(() {
                                      slWords[germanWord.text] = russianWord.text;
                                      germanWord.clear();
                                      russianWord.clear();
                                      isValid = false;
                                    });
                                  }:null,
                                  style: FilledButton.styleFrom(
                                      backgroundColor: Colors.blue
                                  ),
                                  child: Text(
                                      "Add word"
                                  )),
                            ),
                            SizedBox(width: 5,),
                            SizedBox(
                              height: 40,

                              child: FilledButton(

                                  onPressed: (){
                                    setState(() {
                                      germanWord.clear();
                                      russianWord.clear();
                                      isValid = false;
                                    });
                                  },
                                  style: FilledButton.styleFrom(
                                      backgroundColor: Colors.blue
                                  ),
                                  child: Text(
                                      "Delete word"
                                  )),
                            ),
                          ],
                        )

                      ],
                    ),
              ),
              SizedBox(height: 5,),
              Expanded(
                  child: ListView.separated(
                      itemCount: slWords.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 15),

                      itemBuilder: (context, index) {
                        return WordContainer(word: slWords.keys.toList()[index], translate: slWords[slWords.keys.toList()[index]] ?? "", isEdit: true, onPressed: () {
                          setState(() {
                            germanWord.text = slWords.keys.toList()[index];
                            russianWord.text = slWords[slWords.keys.toList()[index]] ?? "";
                            slWords.remove(slWords.keys.toList()[index]);
                            isValid = true;
                          });
                        });
                      }
                  )
              ),
            ],
          ),
        ),
      )
    );
  }
}
