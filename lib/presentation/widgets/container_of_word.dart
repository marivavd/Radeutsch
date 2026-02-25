import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WordContainer extends StatelessWidget {

  final String word;
  final String translate;
  final bool isEdit;
  final Function() onPressed;

  const WordContainer({super.key, required this.word, required this.translate, required this.isEdit, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(

              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(6),
                color: Colors.white
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                        children:[
                          ClipOval(
                              child: SizedBox(
                                child: SvgPicture.asset("assets/Flag_of_Germany.svg", fit: BoxFit.cover, ),
                                height: 20,
                                width: 20,
                              )
                          ),
                        SizedBox(width: 10,),
                        Expanded(child: Text(
                          word,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        )),]),

                         SizedBox(height: 6),

                        Container(
                          height: 1.5,
                          width: double.infinity,
                          color: Color(0xFF5AB6F4),
                        ),

                        const SizedBox(height: 6),
                        Row(
                        children: [
                          ClipOval(

                              child: SizedBox(
                                child: SvgPicture.asset("assets/Flag_of_Russia.svg", fit: BoxFit.cover,),
                                height: 20,
                                width: 20,
                              )
                          ),
                        SizedBox(width: 10,),
                        Expanded(child: Text(
                          translate,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),)
                      ],
                    ),])
                  ),

                  (isEdit)?IconButton(
                    onPressed: onPressed,
                    icon: const Icon(Icons.edit, color: Color(0xFF5AB6F4),),
                  ):IconButton(
                    onPressed: onPressed,
                    icon: const Icon(Icons.remove_red_eye_outlined, color: Color(0xFF5AB6F4),),
                  )
                ],
              )
          );

  }
}
