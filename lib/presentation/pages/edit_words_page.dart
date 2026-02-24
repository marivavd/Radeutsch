import 'package:deutscht/data/models/word_model.dart';
import 'package:deutscht/domain/use_case_add_word.dart';
import 'package:deutscht/domain/use_case_update_word.dart';
import 'package:deutscht/presentation/pages/group_page.dart';
import 'package:deutscht/presentation/utils/show_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/models/group_model.dart';
import '../widgets/container_of_word.dart';

class EditWordsPage extends StatefulWidget {
  List<WordModel> spWords;
  GroupModel group;
  EditWordsPage({super.key, required this.spWords, required this.group});


  @override
  State<EditWordsPage> createState() => _EditWordsPageState();
}

class _EditWordsPageState extends State<EditWordsPage> {
  TextEditingController germanWord = TextEditingController();
  TextEditingController russianWord = TextEditingController();

  List<WordModel> spAllWords = [];
  bool isEdited = false;
  bool isValid = false;
  bool isError = false;
  WordModel oldWordModel = WordModel(wordId: 0, word: '', translate: '', groupId: 0);
  UpdateWordUseCase updateUseCase = UpdateWordUseCase();
  AddNewWordUseCase addNewWordUseCase = AddNewWordUseCase();


  void onChange(_){
    setState(() {
      isValid = germanWord.text.trim().isNotEmpty && russianWord.text.trim().isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    formSpWords();
  }

  void formSpWords()  {

    setState(() {
      for (int i = 0; i < widget.spWords.length; i++){
        spAllWords.add(WordModel(wordId: widget.spWords[i].wordId, word: widget.spWords[i].word, translate: widget.spWords[i].translate, groupId: widget.spWords[i].groupId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40,
                  child: OutlinedButton(
                    onPressed: (){

                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back, color: Colors.white,),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(5),
                      backgroundColor: Colors.blue.shade400,
                      side: BorderSide(color: Colors.transparent)
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,

                  child: FilledButton(

                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.blue.shade400
                      ),
                      onPressed: ()async{
                        showLoading(context);
                        for (int i = 0; i < spAllWords.length; i++){
                          if (isError){

                            break;
                          }
                          if (spAllWords[i].wordId == 0){
                            addNewWordUseCase.pressAddNewWord(widget.group.groupId,
                                spAllWords[i].word,
                                spAllWords[i].translate, (_){

                                },
                                    (String e)async{
                                  hideLoading(context);
                                  isError = true;
                                  showError(context, e);


                                });
                          }
                          else if (spAllWords.any((element) => widget.spWords.contains(element))){
                            continue;

                          }
                          else {
                            updateUseCase.pressUpdateWord(spAllWords[i].wordId,
                                spAllWords[i].word,
                                spAllWords[i].translate, (_){

                                },
                                    (String e)async{
                                  hideLoading(context);
                                  isError = true;
                                  showError(context, e);


                                });
                        }
                        }
                        if (!isError){
                          hideLoading(context);
                          if (!mounted) return;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GroupPage(group: widget.group))).then((value) => setState(() {}));
                        }

                      }, child: Text('Done',
                    style: TextStyle(
                        fontWeight: FontWeight.w600
                    ),)),
                )
              ],
            ),

            SizedBox(height: 40,),
            Container(

              height: 186,
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
                                hintText: 'Vocabulary in German',
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
                                  borderSide: BorderSide(color: Colors.blue),),
                                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
                                hintText: 'Vocabulary in Russian',
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
                                  borderSide: BorderSide(color: Colors.blue),),
                                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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

                            onPressed: (){
                              setState(() {
                                germanWord.clear();
                                russianWord.clear();
                                isValid = false;
                                FocusScope.of(context).unfocus();
                              });
                            },
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.blue
                            ),
                            child: Text(
                                "Delete word"
                            )),
                      ),
                      SizedBox(width: 5,),
                      SizedBox(
                        height: 40,

                        child: FilledButton(

                            onPressed: (isValid)?(){
                              setState(() {
                                if (isEdited){
                                  spAllWords.insert(0, WordModel(wordId: oldWordModel.wordId, word: germanWord.text.trim(), translate: russianWord.text.trim(), groupId: oldWordModel.groupId));
                                }
                                else{
                                  spAllWords.insert(0, WordModel(wordId: 0, word: germanWord.text.trim(), translate: russianWord.text.trim(), groupId: widget.group.groupId));
                                }



                                germanWord.clear();
                                russianWord.clear();
                                isValid = false;
                                oldWordModel = WordModel(wordId: 0, word: '', translate: '', groupId: 0);
                                isEdited = false;
                                FocusScope.of(context).unfocus();
                              });
                            }:null,
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.blue
                            ),
                            child: Text(
                                (isEdited)?"Edit word":"Add word"
                            )),
                      ),

                    ],
                  )

                ],
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
                child: ListView.separated(
                    physics: keyboardOpen
                        ? const NeverScrollableScrollPhysics()
                        : const BouncingScrollPhysics(),
                    itemCount: spAllWords.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 15),
                    padding: EdgeInsets.zero,

                    itemBuilder: (context, index) {
                      return WordContainer(word: spAllWords[index].word, translate: spAllWords[index].translate, isEdit: true, onPressed: () {
                        setState(() {

                          germanWord.text = spAllWords[index].word;
                          russianWord.text = spAllWords[index].translate;
                          int wordId = spAllWords[index].wordId;
                          int groupId = spAllWords[index].groupId;




                          spAllWords.removeAt(index);
                          if (isEdited){
                            spAllWords.insert(0, oldWordModel);
                          }
                          oldWordModel = WordModel(wordId: wordId, word: germanWord.text, translate: russianWord.text, groupId: groupId);
                          isValid = true;
                          isEdited = true;
                        });
                      });
                    }
                )
            ),
            SizedBox(height: 10,)




          ]),
      ),
    );
  }
}
