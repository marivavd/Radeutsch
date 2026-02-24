import 'package:deutscht/data/models/word_model.dart';
import 'package:deutscht/domain/get_words_of_group.dart';
import 'package:deutscht/domain/use_case_delete_group.dart';
import 'package:deutscht/domain/use_case_delete_words.dart';
import 'package:deutscht/presentation/pages/card_of_word.dart';
import 'package:deutscht/presentation/pages/edit_group_name_page.dart';
import 'package:deutscht/presentation/pages/edit_words_page.dart';
import 'package:deutscht/presentation/pages/learn_words_page.dart';
import 'package:deutscht/presentation/pages/main_page.dart';
import 'package:deutscht/presentation/utils/show_dialogs.dart';
import 'package:deutscht/presentation/widgets/container_of_word.dart';
import 'package:flutter/material.dart';

import '../../data/models/group_model.dart';

class GroupPage extends StatefulWidget {
  final GroupModel group;
  const GroupPage({super.key, required this.group});


  @override
  State<GroupPage> createState() => _GroupPageState();

}


class _GroupPageState extends State<GroupPage> {
  List<WordModel> spWords = [];
  bool isLoading = true;
  DeleteGroupUseCase groupUseCase = DeleteGroupUseCase();
  DeleteWordsUseCase wordsUseCase = DeleteWordsUseCase();
  @override
  void initState() {
    super.initState();
    loadWords();
  }

  Future<void> loadWords() async {
    final data = await getWordsOfGroup(groupId: widget.group.groupId);

    if (!mounted) return;

    setState(() {
      spWords = data;
      isLoading = false;
    });
  }




  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40,
                    child: OutlinedButton(
                      onPressed: (){

                        if (!mounted) return;

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => MyHomePage()),
                        );
                        },
                      child: Icon(Icons.arrow_back, color: Colors.black87,),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(5)
                    ),
                  ),),
                  Text(
                    'Vocabulary list',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: OutlinedButton(
                      onPressed: ()async{
                        showSureMessage(context, 'Delete list', 'Are you sure you want to delete the list?', (){
                          Navigator.of(context).pop();
                          showLoading(context);
                          wordsUseCase.deleteWordsPress(
                              widget.group.groupId, (_){
                                groupUseCase.deleteGroupPress(
                                    widget.group.groupId, (_){
                                  hideLoading(context);
                                  Navigator.pop(context, true);
                                }, (String e)async{
                                  hideLoading(context);
                                  showError(context, e);});
                          }, (String e)async{
                            hideLoading(context);
                            showError(context, e);

                          });

                        });
                      },
                      child: Icon(Icons.delete_outline, color: Colors.black87,size: 30,),
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(5),
                        side: BorderSide(color: Colors.transparent)
                      ),
                    ),),

                ]
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.group.groupName,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: OutlinedButton(
                    onPressed: ()async{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditGroupNamePage(group: widget.group))).then((value) => setState(() {}));
                      
                    },
                    child: Icon(Icons.edit, color: Colors.black87,size: 30,),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        side: BorderSide(color: Colors.transparent)
                    ),
                  ),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.collections_bookmark, color: Colors.blue),
                Text(
                  ' ${spWords.length} ${spWords.length == 1 ? 'word' : 'words'}',
                  style: TextStyle(
                    fontSize: 16
                  ),
                )
              ],
            ),
            SizedBox(height: 30,),
            Align(
              alignment: AlignmentGeometry.center,
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: FilledButton(

                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LearnWordsPage(spWords:spWords,))).then((value) => setState(() {}));
                    },
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.blue
                    ),
                    child: Text(
                        "Learn this list",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                      ),
                    )),
              ),
            ),
            SizedBox(height: 40,),

          ],
        ),
      ),
          Expanded(
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  color: Colors.blue
              ),
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                              backgroundColor: Colors.blue.shade400
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditWordsPage(spWords:spWords, group: widget.group))).then((value) => setState(() {}));
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),

                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                        child: ListView.separated(
                        itemCount: spWords.length,
                            padding: EdgeInsets.zero,
                        separatorBuilder: (_, __) => const SizedBox(height: 15),

                        itemBuilder: (context, index) {
                          return WordContainer(word: spWords[index].word, translate: spWords[index].translate, isEdit: false, onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CardOfWord(modelWord: spWords[index]))).then((value) => setState(() {}));
                          },);
                        }
                    )),
                    SizedBox(height: 10,)
                  ],
                ),
              )
          ))
        ])
    );
  }
}
