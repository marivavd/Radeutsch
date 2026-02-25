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
  bool isEdited = false;
  String oldGermanWord = '';
  String oldRussianWord = '';
  bool isValidName = false;





  void onChange(_){
    setState(() {
      isValid = germanWord.text.trim().isNotEmpty && russianWord.text.trim().isNotEmpty;
    });
  }

  void onChangeName(_){
    setState(() {
      isValidName = nameGroup.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final keyboardOpen = bottomInset > 0;


    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFEAF6FF),


      body: SafeArea(
          child: LayoutBuilder(
              builder: (context, constraints) {
               return SingleChildScrollView(
                 padding: EdgeInsets.symmetric(horizontal: 25),
                   child: ConstrainedBox(
                     constraints: BoxConstraints(minHeight: constraints.maxHeight),

                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(height: 5,),
                           Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [SizedBox(
                                 width: 40,
                                 child: OutlinedButton(
                                   onPressed: () {
                                     Navigator.of(context).pop();
                                   },
                                   child: Icon(Icons.arrow_back,
                                     color: Colors.white,),
                                   style: OutlinedButton.styleFrom(
                                     padding: EdgeInsets.all(5),
                                     backgroundColor: Color(0xFF5AB6F4),
                                     side: BorderSide(color: Colors.transparent)
                                   ),
                                 ),
                               ),
                                 SizedBox(
                                   height: 40,
                                   width: 90,
                                   child: FilledButton(
                       
                                       style: FilledButton.styleFrom(
                                           backgroundColor: Color(0xFF5AB6F4),
                                         disabledBackgroundColor: Color(0xFFE0E0E0)
                                       ),
                                       onPressed: (isValidName) ? () async {
                                         showLoading(context);
                                         GroupUseCase.pressButtonDone(nameGroup.text,
                                                 (idGroup) {
                                               for (int i = 0; i <
                                                   slWords.length; i++) {
                                                 WordUseCase.pressAddNewWord(idGroup,
                                                     slWords.keys.toList()[i],
                                                     slWords[slWords.keys
                                                         .toList()[i]] ?? "",
                                                         (_) {},
                                                         (String e) async {
                                                       hideLoading(context);
                                                       showError(context, e);
                                                     });
                                               }
                                               hideLoading(context);
                                               Navigator.push(context,
                                                   MaterialPageRoute(
                                                       builder: (context) =>
                                                           MyHomePage())).then((
                                                   value) => setState(() {}));
                                             },
                                                 (String e) async {
                                               hideLoading(context);
                                               showError(context, e);
                                             });
                                       } : null, child: Text('Done',
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
                                 onChanged: onChangeName,
                                 style: TextStyle(color: Color(0xFF3A3A3A),
                                     fontSize: 14,
                                     height: 16 / 14,
                                     fontWeight: FontWeight.w500),
                                 decoration: InputDecoration(
                                   filled: true,
                                   fillColor: Colors.white,

                                   hintText: "List",
                                   hintStyle: TextStyle(color: Colors.grey),
                       
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
                                     borderSide: BorderSide(color: Color(0xFF5AB6F4)),),
                                   contentPadding: EdgeInsets.symmetric(
                                       vertical: 14, horizontal: 10),
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

                             width: double.infinity,
                             padding: EdgeInsets.all(20),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(6),
                                 border: Border.all(color: Colors.transparent),
                               color: Colors.white
                       
                             ),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Row(
                                   children: [
                                     ClipOval(
                       
                                         child: SizedBox(
                                           child: SvgPicture.asset(
                                             "assets/Flag_of_Germany.svg",
                                             fit: BoxFit.cover,),
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
                                             style: TextStyle(
                                                 color: Color(0xFF3A3A3A),
                                                 fontSize: 14,
                                                 height: 16 / 14,
                                                 fontWeight: FontWeight.w500),
                                             decoration: InputDecoration(
                                               hintText: "Vocabulary in German",
                                               hintStyle: TextStyle(
                                                   color: Colors.grey),
                       
                                               border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(
                                                     6),
                                                 borderSide: BorderSide(
                                                     color: Colors.grey),
                                               ),
                                               enabledBorder: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(
                                                     6),
                                                 borderSide: BorderSide(
                                                     color: Colors.grey),
                                               ),
                                               focusedBorder: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(
                                                     6),
                                                 borderSide: BorderSide(
                                                     color: Color(0xFF5AB6F4)),),
                                               contentPadding: EdgeInsets.symmetric(
                                                   vertical: 5, horizontal: 10),
                                             )
                                         ),),)
                                   ],
                                 ),
                                 SizedBox(height: 10,),
                                 Row(
                                   children: [
                                     ClipOval(
                       
                                         child: SizedBox(
                                           child: SvgPicture.asset(
                                             "assets/Flag_of_Russia.svg",
                                             fit: BoxFit.cover,),
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
                                             style: TextStyle(
                                                 color: Color(0xFF3A3A3A),
                                                 fontSize: 14,
                                                 height: 16 / 14,
                                                 fontWeight: FontWeight.w500),
                                             decoration: InputDecoration(
                                               hintText: 'Vocabulary in Russian',
                                               hintStyle: TextStyle(
                                                   color: Colors.grey),
                                               border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(
                                                     6),
                                                 borderSide: BorderSide(
                                                     color: Colors.grey),
                                               ),
                                               enabledBorder: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(
                                                     6),
                                                 borderSide: BorderSide(
                                                     color: Colors.grey),
                                               ),
                                               focusedBorder: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(
                                                     6),
                                                 borderSide: BorderSide(
                                                     color: Color(0xFF5AB6F4)),),
                                               contentPadding: EdgeInsets.symmetric(
                                                   vertical: 5, horizontal: 10),
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
                       
                                           onPressed: () {
                                             setState(() {
                                               germanWord.clear();
                                               russianWord.clear();
                                               isValid = false;
                                               isEdited = false;
                                               oldGermanWord = '';
                                               oldRussianWord = '';
                                               FocusScope.of(context).unfocus();
                                             });
                                           },
                                           style: FilledButton.styleFrom(
                                               backgroundColor: Color(0xFF5AB6F4)
                                           ),
                                           child: Text(
                                               "Delete word"
                                           )),
                                     ),
                                     SizedBox(width: 5,),
                                     SizedBox(
                                       height: 40,
                       
                                       child: FilledButton(
                       
                                           onPressed: (isValid) ? () {
                                             setState(() {
                                               slWords = {
                                                 germanWord.text.trim(): russianWord
                                                     .text.trim(),
                                                 ...slWords
                                               };
                                               germanWord.clear();
                                               russianWord.clear();
                                               isValid = false;
                                               oldRussianWord = '';
                                               oldGermanWord = '';
                                               isEdited = false;
                                               FocusScope.of(context).unfocus();
                                             });
                                           } : null,
                                           style: FilledButton.styleFrom(
                                               backgroundColor: Color(0xFF5AB6F4)
                                           ),
                                           child: Text(
                                               (isEdited) ? "Edit word" : "Add word"
                                           )),
                                     ),
                       
                                   ],
                                 )
                       
                               ],
                             ),
                           ),
                           SizedBox(height: 15,),
                           ListView.separated(
                               shrinkWrap: true,
                               physics: const NeverScrollableScrollPhysics(),
                                   itemCount: slWords.length,
                                   separatorBuilder: (_, __) =>
                                   const SizedBox(height: 15),
                       
                                   itemBuilder: (context, index) {
                                     return WordContainer(word: slWords.keys
                                         .toList()[index],
                                         translate: slWords[slWords.keys
                                             .toList()[index]] ?? "",
                                         isEdit: true,
                                         onPressed: () {
                                           setState(() {
                                             germanWord.text =
                                             slWords.keys.toList()[index];
                                             russianWord.text = slWords[slWords.keys
                                                 .toList()[index]] ?? "";
                       
                                             slWords.remove(
                                                 slWords.keys.toList()[index]);
                                             if (isEdited) {
                                               slWords = {
                                                 oldGermanWord: oldRussianWord,
                                                 ...slWords
                                               };
                                             }
                                             isValid = true;
                                             isEdited = true;
                                             oldGermanWord = germanWord.text;
                                             oldRussianWord = russianWord.text;
                                           });
                                         });
                                   }
                               )

                         ],
                       ),
                     ),


               );
                
                
              }))
    );
  }
}
