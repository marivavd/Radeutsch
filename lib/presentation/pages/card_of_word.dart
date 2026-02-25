import 'package:deutscht/data/models/word_model.dart';
import 'package:deutscht/presentation/utils/show_dialogs.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CardOfWord extends StatefulWidget {
  final WordModel modelWord;
  const CardOfWord({super.key, required this.modelWord});

  @override
  State<CardOfWord> createState() => _CardOfWordState();
}

class _CardOfWordState extends State<CardOfWord> {
  FlutterTts flutterTts = FlutterTts();
  Map<dynamic, dynamic> currentVoiceRu = {};
  Map<dynamic, dynamic> currentVoiceDe = {};


  @override
  void initState(){
    super.initState();
    initTTS();

  }


  void initTTS(){
    flutterTts.getVoices.then((data){
      try{
        List<Map> voices = List<Map>.from(data);
        List<Map> voicesRu = voices.where((voice) => voice['locale'].toString().toLowerCase().contains('ru')).toList();
        List<Map> voicesDe = voices.where((voice) => voice['locale'].toString().toLowerCase().contains('de')).toList();
        currentVoiceRu = voicesRu.first;
        currentVoiceDe = voicesDe.first;

      }
      catch (e){
        showError(context, e.toString());
      }
    });


  }

  void speak(Map voice, String text){
    flutterTts.setVoice({'name': voice['name'], 'locale': voice['locale']});
    flutterTts.speak(text);
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFA2D6F9),
              Color(0xFFD2FCF8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back, color: Colors.black87),
                    style: OutlinedButton.styleFrom(padding: EdgeInsets.all(5)),
                  ),
                ),
              ),
              SizedBox(height: 130),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                child: Center(
                  child: FlipCard(
                    fill: Fill.fillBack,
                    direction: FlipDirection.HORIZONTAL,
                    side: CardSide.FRONT,
                    front: Container(
                      width: double.infinity,
                      height: 500,
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                      decoration: BoxDecoration(
                        border: BoxBorder.all(color: Colors.transparent),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipOval(
                                  child: SizedBox(
                                    child: SvgPicture.asset("assets/Flag_of_Germany.svg", fit: BoxFit.cover, ),
                                    height: 25,
                                    width: 25,
                                  )
                              ),
                              GestureDetector(
                                child: Icon(Icons.volume_up, size: 25,color: Colors.blue.shade600,),
                                onTap: (){
                                  speak(currentVoiceDe, widget.modelWord.word);
                                },
                              )

                            ],
                          ),
                          SizedBox(height: 180,),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.modelWord.word,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                    back: Container(
                      width: double.infinity,
                      height: 500,
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                      decoration: BoxDecoration(
                        border: BoxBorder.all(color: Colors.transparent),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipOval(
                                  child: SizedBox(
                                    child: SvgPicture.asset("assets/Flag_of_Russia.svg", fit: BoxFit.cover, ),
                                    height: 25,
                                    width: 25,
                                  )
                              ),
                              GestureDetector(
                                child: Icon(Icons.volume_up, size: 25,color: Colors.blue.shade600,),
                                onTap: (){
                                  print('1');
                                  speak(currentVoiceRu, widget.modelWord.translate);
                                },
                              )

                            ],
                          ),
                          SizedBox(height: 180,),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.modelWord.translate,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
